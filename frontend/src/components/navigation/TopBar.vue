<template>
  <header class="flex items-center justify-between bg-white px-4 py-3 shadow-sm dark:bg-slate-900">
    <button
      class="inline-flex items-center rounded-md border border-slate-200 bg-white p-2 text-slate-700 shadow-sm transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-primary dark:border-slate-700 dark:bg-slate-800 dark:text-slate-100"
      @click="$emit('toggle-nav')"
      aria-label="Mostrar menú"
    >
      <Bars3Icon class="h-5 w-5" />
    </button>
    <h1 class="text-lg font-semibold">{{ title }}</h1>
    <slot name="actions">
      <button
        v-if="app.isOffline"
        class="rounded-full border border-transparent bg-amber-500 px-3 py-1 text-sm font-medium text-white shadow hover:bg-amber-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500"
      >
        {{ t('app.offline') }}
      </button>
    </slot>
  </header>
</template>

<script setup lang="ts">
import { Bars3Icon } from '@heroicons/vue/24/outline';
import { useI18n } from 'vue-i18n';
import { useAppStore } from '@/stores/appStore';

defineProps<{ title: string }>();

const { t } = useI18n();
const app = useAppStore();
</script>
