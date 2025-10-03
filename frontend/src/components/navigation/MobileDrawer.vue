<template>
  <Transition name="slide">
    <div
      v-if="open"
      class="fixed inset-0 z-50 flex"
      role="dialog"
      aria-modal="true"
    >
      <div class="fixed inset-0 bg-slate-900/50" aria-hidden="true" @click="$emit('close')"></div>
      <aside class="relative ml-auto h-full w-64 bg-white p-4 shadow-lg dark:bg-slate-900">
        <button class="mb-4 text-sm text-slate-500" @click="$emit('close')">
          {{ t('navigation.close', 'Cerrar') }}
        </button>
        <NavDrawer :items="items" />
      </aside>
    </div>
  </Transition>
</template>

<script setup lang="ts">
import NavDrawer from './NavDrawer.vue';
import type { NavItem } from '@/utils/navigation';
import { useI18n } from 'vue-i18n';

defineProps<{ open: boolean; items: NavItem[] }>();

defineEmits<{ (e: 'close'): void }>();

const { t } = useI18n();
</script>

<style scoped>
.slide-enter-active,
.slide-leave-active {
  transition: transform 0.2s ease-in-out;
}

.slide-enter-from,
.slide-leave-to {
  transform: translateX(100%);
}
</style>
