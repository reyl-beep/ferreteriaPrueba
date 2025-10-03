<template>
  <div class="w-full overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm dark:border-slate-800 dark:bg-slate-900">
    <header class="flex flex-col gap-3 border-b border-slate-200 p-4 dark:border-slate-800 lg:flex-row lg:items-center lg:justify-between">
      <div class="flex items-center gap-2">
        <slot name="title">
          <h2 class="text-lg font-semibold">{{ title }}</h2>
        </slot>
        <p v-if="subtitle" class="text-sm text-slate-500">{{ subtitle }}</p>
      </div>
      <div class="flex flex-1 flex-wrap items-center gap-2 lg:justify-end">
        <input
          v-model="search"
          type="search"
          class="w-full rounded-lg border border-slate-200 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary dark:border-slate-700 dark:bg-slate-800"
          :placeholder="searchPlaceholder"
        />
        <slot name="actions" />
      </div>
    </header>
    <div class="max-h-[60vh] overflow-auto">
      <table class="min-w-full divide-y divide-slate-200 text-left text-sm dark:divide-slate-800">
        <thead class="bg-slate-50 dark:bg-slate-800/50">
          <tr>
            <th
              v-for="column in columns"
              :key="column.key"
              scope="col"
              class="px-4 py-3 font-medium uppercase tracking-wide text-slate-500"
            >
              {{ column.label }}
            </th>
          </tr>
        </thead>
        <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
          <tr v-if="!filteredRows.length">
            <td :colspan="columns.length">
              <EmptyState />
            </td>
          </tr>
          <tr v-for="row in paginatedRows" :key="rowKey(row)" class="hover:bg-slate-50 dark:hover:bg-slate-800">
            <slot name="row" :row="row">
              <td v-for="column in columns" :key="column.key" class="px-4 py-3">
                {{ row[column.key] }}
              </td>
            </slot>
          </tr>
        </tbody>
      </table>
    </div>
    <footer class="flex items-center justify-between border-t border-slate-200 bg-slate-50 p-4 text-xs dark:border-slate-800 dark:bg-slate-900/50">
      <div>
        {{ paginationLabel }}
      </div>
      <div class="flex items-center gap-2">
        <button class="rounded-md border px-2 py-1" :disabled="page === 1" @click="page--">Prev</button>
        <span>{{ page }} / {{ totalPages }}</span>
        <button class="rounded-md border px-2 py-1" :disabled="page === totalPages" @click="page++">Next</button>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { computed, ref, watch } from 'vue';
import EmptyState from '@/components/feedback/EmptyState.vue';

export interface ColumnDefinition<T> {
  key: keyof T & string;
  label: string;
}

type KeyGetter<T> = (row: T) => string | number;

const props = defineProps<{
  rows: Record<string, any>[];
  columns: ColumnDefinition<Record<string, any>>[];
  title?: string;
  subtitle?: string;
  rowKey?: KeyGetter<Record<string, any>>;
  searchPlaceholder?: string;
  pageSize?: number;
}>();

const search = ref('');
const page = ref(1);

const pageSize = computed(() => props.pageSize ?? 10);

const filteredRows = computed(() => {
  const value = search.value.toLowerCase();
  if (!value) return props.rows;
  return props.rows.filter((row) =>
    Object.values(row).some((cell) => String(cell).toLowerCase().includes(value))
  );
});

const totalPages = computed(() => Math.max(Math.ceil(filteredRows.value.length / pageSize.value), 1));

const paginatedRows = computed(() => {
  const start = (page.value - 1) * pageSize.value;
  return filteredRows.value.slice(start, start + pageSize.value);
});

watch(filteredRows, () => {
  page.value = 1;
});

const rowKey = (row: Record<string, any>) => {
  if (props.rowKey) return props.rowKey(row);
  return JSON.stringify(row);
};

const paginationLabel = computed(
  () => `Mostrando ${(page.value - 1) * pageSize.value + 1}-${Math.min(
    page.value * pageSize.value,
    filteredRows.value.length
  )} de ${filteredRows.value.length}`
);

const searchPlaceholder = computed(() => props.searchPlaceholder ?? 'Buscar...');
</script>
