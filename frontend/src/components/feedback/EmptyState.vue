<template>
  <div class="flex flex-col items-center gap-2 px-4 py-10 text-center text-slate-500 dark:text-slate-400">
    <svg class="h-12 w-12" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" d="M3 7.5l9-4.5 9 4.5M4.5 10.5V18a1.5 1.5 0 001.5 1.5h12A1.5 1.5 0 0019.5 18v-7.5" />
    </svg>
    <p>{{ message }}</p>
  </div>
</template>

<script setup lang="ts">
withDefaults(defineProps<{ message?: string }>(), {
  message: 'Sin datos disponibles en este momento.'
});
</script>
