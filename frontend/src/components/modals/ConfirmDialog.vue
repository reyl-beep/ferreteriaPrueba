<template>
  <FormDialog :open="open" :title="title" @close="$emit('close')" @submit="$emit('confirm')">
    <p class="text-sm text-slate-600 dark:text-slate-300">
      {{ message }}
    </p>
  </FormDialog>
</template>

<script setup lang="ts">
import FormDialog from './FormDialog.vue';

defineProps<{ open: boolean; title?: string; message: string }>();

defineEmits<{ (e: 'close'): void; (e: 'confirm'): void }>();
</script>
