<template>
  <div class="flex gap-2 items-center justify-start max-2xl:flex-col max-md:flex-row">
    <input
      type="text"
      class="w-full rounded-2xl p-1 bg-gray-200 focus:bg-gray-300 shadow-2xs focus:border-blue-300 focus:outline-none border border-blue-300"
      :placeholder="placeholder"
      :value="modelValue"
      @input="$emit('update:modelValue', $event.target.value)"
      @keyup.enter="$emit('search')"
    >
    <button @click="$emit('search')" class="bg-blue-500 max-md:hidden text-white px-3 py-1 rounded hover:bg-blue-600">
      Rechercher
    </button>
    
    <div class=" p-2 bg-amber-300 w-10 h-10 md:hidden flex justify-center items-center rounded-full ">
      <i @click="$emit('search')" class="pi pi-search  text-cyan-800 max-md:block md:hidden px-3 py-1 rounded hover:bg-blue-600 cursor-pointer"></i>

    </div>

  </div>
</template>
  
<script setup>
defineProps({
  modelValue: String,
  placeholder: {
    type: String,
    default: 'Rechercher'
  }
});
</script>
