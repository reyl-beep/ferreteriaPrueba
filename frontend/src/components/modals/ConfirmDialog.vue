<template>
  <FormDialog :open="props.open" :title="props.title" @close="$emit('close')" @submit="$emit('confirm')">
    <p class="text-sm text-slate-600 dark:text-slate-300">
      {{ props.message }}
    </p>
  </FormDialog>
</template>

<script setup lang="ts">
import FormDialog from './FormDialog.vue';

const props = withDefaults(
  defineProps<{ open: boolean; title?: string; message: string }>(),
  {
    title: ''
  }
);

defineEmits<{ (e: 'close'): void; (e: 'confirm'): void }>();
</script>
