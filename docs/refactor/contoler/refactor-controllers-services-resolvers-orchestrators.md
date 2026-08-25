# Refactor controllers Symfony vers services, resolvers et orchestrators

## Objectif

Cette note liste les changements recommandes pour alleger les controllers Symfony et renforcer l'architecture en couches deja presente dans le projet.

Le but n'est pas de tout refactorer d'un coup. Le projet possede deja une base DDD/CQRS correcte sur certains modules (`Note`, `Favorite`, `AgentCourse`). La prochaine etape consiste a appliquer le meme niveau de separation aux controllers qui contiennent encore trop de logique applicative.

## Constat general

Deux styles coexistent actuellement :

- Controllers fins : ils lisent la requete, creent une command/query, appellent un handler, retournent une reponse.
- Controllers riches : ils lisent le JSON, resolvent les relations, creent/modifient les entites, valident, sauvegardent et construisent les tableaux de reponse.

Le premier style est le plus propre pour l'architecture du projet.

## Controllers deja proches du bon modele

### `src/Controller/Api/NoteController.php`

Ce controller suit deja une logique CQRS :

- `CreateOrUpdateNoteCommand`
- `DeleteNoteCommand`
- `GetUserNotesQuery`
- `GetNoteByPageQuery`
- handlers dedies dans `src/Application/Note/Handler`

Le controller reste principalement HTTP : validation minimale, appel handler, conversion DTO en JSON.

### `src/Controller/Api/FavoriteController.php`

Ce controller suit aussi un modele propre :

- `AddFavoriteCommand`
- `RemoveFavoriteCommand`
- `ToggleFavoriteCommand`
- `CheckFavoriteQuery`
- handlers dedies dans `src/Application/Favorite/Handler`

Il peut servir de modele pour refactorer les autres controllers.

## Controllers prioritaires a refactorer

### 1. `ApiAgentCourseController`

Fichier :

`src/Controller/Api/AdminCrud/ApiAgentCourseController.php`

Problemes observes :

- Le controller melange creation, lecture, update, revisions, application de revision et mapping JSON.
- `create()` utilise deja `CreateAgentCourseHandler`, ce qui est positif.
- `update()` modifie directement `PageContent`.
- `applyRevision()` applique directement le nouveau code, sauvegarde le cours, marque la revision appliquee et sauvegarde la revision.
- Les methodes privees `mapCourse`, `mapRevision`, `mapRevisionDto` transforment les entites en reponses API dans le controller.

Services recommandes :

- `UpdateAgentCourseHandler`
- `ApplyAgentCourseRevisionHandler`
- `AgentCourseResponseMapper`
- `AgentCourseRevisionResponseMapper`
- eventuellement `AgentCourseQueryService` pour `list`, `show`, `listRevisions`

Benefice :

- Le controller ne connait plus les details de mutation de `PageContent` et `AgentCourseRevision`.
- Les regles d'application d'une revision deviennent testables hors HTTP.
- Les mappings JSON deviennent reutilisables.

Priorite : haute.

## 2. `ApiPageContentController`

Fichier :

`src/Controller/Api/AdminCrud/ApiPageContentController.php`

Problemes observes :

- `create()` instancie directement `PageContent`.
- Le controller resout `pageId`, `categoryId`, `menuId`.
- La logique de relations est dupliquee entre `create()` et `update()`.
- Le controller valide l'entite et transforme les erreurs.
- Le controller sauvegarde directement via repository.

Services recommandes :

- `CreatePageContentHandler`
- `UpdatePageContentHandler`
- `DeletePageContentHandler`
- `PageContentRelationResolver`
- `PageContentRequestMapper`
- `ValidationErrorFormatter`

Role possible de `PageContentRelationResolver` :

```text
input: pageId, categoryId, menuId
output: Page?, Category?, Menus?
erreurs: PageNotFound, CategoryNotFound, MenuNotFound
```

Benefice :

- Le controller ne fait plus de resolution d'entites.
- La logique de `create` et `update` devient testable.
- Les erreurs de relation sont centralisees.

Priorite : haute.

## 3. `ApiExoContentController`

Fichier :

`src/Controller/Api/AdminCrud/ApiExoContentController.php`

Problemes observes :

- Structure tres proche de `ApiPageContentController`.
- Resolution manuelle de `exoId`, `categoryId`, `exoMenuId`.
- Duplication create/update.
- Validation et persistence dans le controller.

Services recommandes :

- `CreateExoContentHandler`
- `UpdateExoContentHandler`
- `DeleteExoContentHandler`
- `ExoContentRelationResolver`
- `ExoContentRequestMapper`

Benefice :

- Meme logique que `PageContent`, mais appliquee aux exercices.
- Possibilite de factoriser certains patterns CRUD ensuite.

Priorite : moyenne a haute.

## 4. `PropositionIAController`

Fichier :

`src/Controller/PropositionIAController.php`

Problemes observes :

- `accept()` contient une vraie orchestration metier :
  - lecture du payload
  - interpretation de l'action `creation_cours` ou `analyse_cours`
  - resolution de `Page`, `Category`, `Menu`
  - creation ou update de `PageContent`
  - changement de statut de la proposition
  - sauvegarde de plusieurs entites
- `reject()`, `review()` et `delete()` changent directement l'etat de l'entite.
- `create()` cree directement `PropositionIA`.

Services recommandes :

- `AcceptPropositionIAHandler`
- `RejectPropositionIAHandler`
- `ReviewPropositionIAHandler`
- `CreatePropositionIAHandler`
- `PropositionPayloadResolver`
- `PropositionIAResponseMapper`

Nom alternatif :

- `PropositionIAOrchestrator`

L'orchestrator est pertinent ici parce que l'acceptation d'une proposition coordonne plusieurs objets et plusieurs repositories.

Benefice :

- La logique IA devient explicite dans la couche Application.
- Les actions possibles deviennent testables sans requete HTTP.
- Les erreurs metier sont mieux isolees.

Priorite : haute.

## 5. `PageVisitController`

Fichier :

`src/Controller/PageVisitController.php`

Problemes observes :

- Le controller gere le tracking global active/desactive.
- Il verifie la preference utilisateur.
- Il cree `UserPageVisit`.
- Il mappe l'historique.
- Il verifie la propriete d'une visite avant suppression.
- Il modifie la preference utilisateur.

Services recommandes :

- `PageVisitTracker`
- `PageVisitHistoryProvider`
- `PageVisitDeletionHandler`
- `PageVisitPreferenceService`
- `PageVisitResponseMapper`

Benefice :

- Les regles de tracking sont centralisees.
- La logique de confidentialite/propriete utilisateur est testable.
- Le controller redevient une couche HTTP fine.

Priorite : moyenne.

## 6. `CustomizationController`

Fichier :

`src/Controller/Api/CustomizationController.php`

Problemes observes :

- Le controller fusionne les defaults et les settings utilisateur.
- Il appelle le validator.
- Il cree ou recupere la personnalisation.
- Il sauvegarde et formatte la reponse.

Services recommandes :

- `CustomizationSettingsResolver`
- `SaveCustomizationHandler`
- `ResetCustomizationHandler`
- `CustomizationResponseMapper`

Benefice :

- La logique de merge `defaults + userSettings` devient reutilisable.
- Les regles de validation et persistence sortent du controller.

Priorite : moyenne.

## Services transverses recommandes

### `JsonRequestParser`

Responsabilite :

- decoder le JSON
- garantir que le payload est un tableau
- lever une exception claire si JSON invalide

Utilite :

- evite de repeter `json_decode($request->getContent(), true)` partout
- harmonise les erreurs `400 Bad Request`

### `ValidationErrorFormatter`

Responsabilite :

- transformer `ConstraintViolationListInterface` en tableau JSON stable

Utilite :

- evite les boucles d'erreurs dans chaque controller CRUD

### `ApiExceptionResponder`

Responsabilite :

- convertir les exceptions applicatives en reponses HTTP

Exemples :

- `NotFoundException` -> 404
- `InvalidArgumentException` -> 400
- `Unauthorized...Exception` -> 403

Alternative Symfony :

- utiliser un `EventSubscriber` sur `KernelEvents::EXCEPTION`

### Response mappers

Responsabilite :

- transformer entite ou DTO en tableau API

Exemples :

- `AgentCourseResponseMapper`
- `AgentCourseRevisionResponseMapper`
- `PageVisitResponseMapper`

Utilite :

- evite les methodes privees de mapping dans les controllers
- donne une forme stable aux responses API

## Structure cible proposee

Exemple pour `PageContent` :

```text
src/
├── Application/
│   └── PageContent/
│       ├── Command/
│       │   ├── CreatePageContentCommand.php
│       │   ├── UpdatePageContentCommand.php
│       │   └── DeletePageContentCommand.php
│       ├── Handler/
│       │   ├── CreatePageContentHandler.php
│       │   ├── UpdatePageContentHandler.php
│       │   └── DeletePageContentHandler.php
│       ├── DTO/
│       │   └── PageContentDTO.php
│       └── Resolver/
│           └── PageContentRelationResolver.php
│
├── Controller/
│   └── Api/AdminCrud/
│       └── ApiPageContentController.php
│
└── Infrastructure/
    └── PageContent/
        └── Repository/
            └── DoctrinePageContentRepository.php
```

## Exemple de flow cible

Controller actuel riche :

```text
Request -> Controller
Controller parse JSON
Controller resout relations
Controller modifie entite
Controller valide
Controller sauvegarde
Controller mappe response
```

Flow recommande :

```text
Request
-> Controller
-> RequestMapper / Command
-> Handler / Orchestrator
-> Resolver si relations
-> Repository
-> DTO
-> ResponseMapper
-> JsonResponse
```

## Priorisation recommandee

1. Extraire `AcceptPropositionIAHandler` ou `PropositionIAOrchestrator`.
2. Extraire `ApplyAgentCourseRevisionHandler`.
3. Extraire `PageContentRelationResolver`.
4. Extraire `CreatePageContentHandler` et `UpdatePageContentHandler`.
5. Repliquer le pattern sur `ExoContent`.
6. Ajouter les response mappers.
7. Ajouter un gestionnaire global des exceptions API.

## Argumentaire VAE

Ces changements renforcent le Bloc 2 du dossier VAE :

- separation Controller / Application / Domain / Infrastructure
- application concrete du principe SRP
- controllers limites a la couche HTTP
- orchestration metier dans des services testables
- resolution d'entites centralisee
- erreurs applicatives mieux structurees

Phrase possible pour le jury :

```text
J'ai identifie que certains controllers historiques contenaient encore de la logique applicative.
Le refactor recommande consiste a les transformer en controllers fins et a deplacer les cas d'usage
dans des handlers, resolvers et orchestrators, comme deja fait sur les modules Note et Favorite.
```

## Hors scope immediat

- Ne pas refactorer tous les CRUD EasyAdmin en premier.
- Ne pas introduire un framework de bus de commandes avant d'avoir stabilise les handlers existants.
- Ne pas rendre les mappers trop generiques au debut : mieux vaut des mappers explicites par domaine.

