# ADR 001 — Entités Doctrine dans `src/Entity`, domaine derrière des ports

- **Statut** : accepté
- **Date** : 2026-08-25
- **Remplace** : le choix laissé ouvert entre `docs/architecture-hexagonale-option1.md` et `docs/architecture-hexagonale-option2.md`

## Contexte

Le projet suit une architecture hexagonale depuis mai 2026. Deux cibles ont été
documentées, sans qu'aucune ne soit formellement retenue :

- **Option 1** — les entités restent dans `src/Entity`, avec leur mapping ORM par attributs.
- **Option 2** — les entités sont déplacées dans `src/Domain/<Contexte>/Entity`.

Cinq documents traitent du sujet et se contredisent sur trois points : la cible,
l'ordre de migration, et l'état d'avancement. `final-hexagonal-audit.md` conclut
que l'objectif est atteint, alors que la couche `Application` ne couvre que 3
contextes sur 28.

Cette ambiguïté a un coût réel : chaque reprise du chantier redémarre par un
arbitrage déjà fait.

## Décision

**Nous retenons l'option 1.** Les entités restent dans `src/Entity` et
conservent leurs attributs `Doctrine\ORM\Mapping`.

Les règles qui en découlent sont vérifiées automatiquement par `deptrac.yaml` :

| Couche | Peut dépendre de |
| --- | --- |
| `Domain` | `Entity` uniquement |
| `Application` | `Domain`, `Entity` |
| `Infrastructure` | `Domain`, `Entity`, Doctrine |
| `Controller`, `Command`, `EventListener` | `Application`, `Entity` |

`Infrastructure` est la seule couche autorisée à connaître Doctrine.
`Domain` et `Application` ne connaissent ni Doctrine, ni Symfony.

## Raisons

**L'option 2 ne supprime pas le couplage, elle le déplace.** Son propre tableau
de principes annonce un `Domain` en « pur PHP », mais son exemple d'entité
importe `Doctrine\ORM\Mapping` et sa configuration déclare `type: attribute`.
Après migration complète, `Domain` dépendrait toujours de Doctrine — au prix
d'un renommage de 28 entités et de 165 imports.

**Le coût est concentré là où il ne produit rien.** Un domaine réellement pur
imposerait de remapper 61 relations, de perdre le lazy loading, de reconstruire
90 déclarations `#[Groups]` et de réoutiller 21 entités exposées via API
Platform. Or les entités actuelles sont anémiques : 124 setters, 172 getters,
deux méthodes métier. La séparation produirait des modèles anémiques accompagnés
de mappers, sans gain de modélisation.

**Le vrai déficit est ailleurs.** Les ports et adaptateurs existent pour 25
contextes ; les cas d'usage n'existent que pour 3. C'est la couche `Application`
qui rend la logique métier testable et les contrôleurs minces, pas
l'emplacement des entités.

## Conséquences

**Acceptées :**

- `src/Entity` reste couplé à Doctrine, API Platform et au composant Serializer.
- `Domain` dépend des entités ORM plutôt que de modèles de domaine purs.
- `PageContentSanitizerListener` reste un listener Doctrine, assumé comme une
  politique de persistance.

**Obtenues :**

- Aucune migration de namespace, aucun mapper, aucun risque sur le schéma.
- Le contrat HTTP est inchangé : le front Vue n'est pas touché.
- Le chantier restant est incrémental et réversible, contexte par contexte.

## Réexamen

Cette décision pourra être rouverte si le modèle s'enrichit réellement —
invariants dans les constructeurs, méthodes métier, suppression des setters —
c'est-à-dire après la phase 05 de `docs/roadmap-100-hexagonal.md`. À ce moment,
isoler le domaine aurait un sens que le modèle anémique actuel ne lui donne pas.

Avant cela, ouvrir le sujet reviendrait à payer un renommage sans bénéfice.
