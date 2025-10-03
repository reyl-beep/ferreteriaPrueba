<template>
  <div class="pointer-events-none fixed inset-x-0 top-4 z-[100] flex flex-col gap-2 px-4">
    <TransitionGroup name="toast">
      <div
        v-for="toast in toasts"
        :key="toast.id"
        class="pointer-events-auto rounded-lg border border-slate-200 bg-white p-4 shadow-lg dark:border-slate-800 dark:bg-slate-900"
        :class="toast.type === 'error' ? 'border-red-300 text-red-600 dark:border-red-500 dark:text-red-300' : 'border-emerald-300 text-emerald-700 dark:border-emerald-500 dark:text-emerald-200'"
      >
        <p class="text-sm font-semibold">{{ toast.message }}</p>
      </div>
    </TransitionGroup>
  </div>
</template>

<script setup lang="ts">
import { storeToRefs } from 'pinia';
import { useToastStore } from '@/stores/toastStore';

const toastStore = useToastStore();
const { toasts } = storeToRefs(toastStore);
</script>

<style scoped>
.toast-enter-active,
.toast-leave-active {
  transition: all 0.2s ease;
}

.toast-enter-from {
  opacity: 0;
  transform: translateY(-10px);
}

.toast-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}
</style>
