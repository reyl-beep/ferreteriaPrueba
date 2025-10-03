<template>
  <div class="min-h-screen bg-slate-100 text-slate-900 dark:bg-slate-950 dark:text-slate-50">
    <LoadingOverlay v-if="isLoading" />
    <div class="grid min-h-screen grid-cols-1 lg:grid-cols-[18rem_1fr]">
      <aside
        class="hidden border-r border-slate-200 bg-white dark:border-slate-800 dark:bg-slate-900 lg:block"
        aria-label="Navegación principal"
      >
        <NavDrawer :items="filteredNavItems" />
      </aside>
      <div class="flex flex-col">
        <TopBar
          class="border-b border-slate-200 dark:border-slate-800"
          :title="title"
          @toggle-nav="toggleDrawer"
        />
        <main class="flex-1 overflow-y-auto p-4 lg:p-8">
          <RouterView v-slot="{ Component, route }">
            <Transition name="fade" mode="out-in">
              <component :is="Component" :key="route.fullPath" />
            </Transition>
          </RouterView>
        </main>
      </div>
    </div>
    <MobileDrawer
      :open="drawerOpen"
      :items="filteredNavItems"
      @close="drawerOpen = false"
    />
    <ToastZone />
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import { useRoute } from 'vue-router';
import TopBar from '@/components/navigation/TopBar.vue';
import NavDrawer from '@/components/navigation/NavDrawer.vue';
import MobileDrawer from '@/components/navigation/MobileDrawer.vue';
import ToastZone from '@/components/feedback/ToastZone.vue';
import LoadingOverlay from '@/components/feedback/LoadingOverlay.vue';
import { useAppStore } from '@/stores/appStore';
import { navItems } from '@/utils/navigation';

const route = useRoute();
const store = useAppStore();

const drawerOpen = ref(false);

const filteredNavItems = computed(() =>
  navItems.filter((item) => !item.roles || item.roles.some((role) => store.hasRole(role)))
);

const title = computed(() => (route.meta?.title as string | undefined) ?? 'Ferretería POS');
const isLoading = computed(() => store.isLoading);

const toggleDrawer = () => {
  drawerOpen.value = !drawerOpen.value;
};
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease-in-out;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
