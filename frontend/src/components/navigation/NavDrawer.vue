<template>
  <nav class="flex h-full flex-col gap-2 p-4" aria-label="Menú principal">
    <RouterLink
      v-for="item in items"
      :key="item.to"
      :to="item.to"
      class="inline-flex items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium transition"
      :class="[
        $route.name === item.name
          ? 'bg-primary/10 text-primary'
          : 'text-slate-600 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800'
      ]"
    >
      <component :is="item.icon" class="h-5 w-5" />
      <span>{{ item.label }}</span>
    </RouterLink>
  </nav>
</template>

<script setup lang="ts">
import type { NavItem } from '@/utils/navigation';

defineProps<{ items: NavItem[] }>();
</script>
