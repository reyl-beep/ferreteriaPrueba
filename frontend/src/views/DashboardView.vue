<template>
  <section class="space-y-6">
    <header class="flex flex-col gap-2">
      <h2 class="text-2xl font-bold">Resumen general</h2>
      <p class="text-sm text-slate-500">
        Visualiza métricas claves de ventas, inventario y rendimiento operativo.
      </p>
    </header>
    <div class="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
      <div v-for="metric in metrics" :key="metric.title" class="rounded-xl border border-slate-200 bg-white p-4 shadow-sm dark:border-slate-800 dark:bg-slate-900">
        <p class="text-sm text-slate-500">{{ metric.title }}</p>
        <p class="mt-2 text-2xl font-semibold">{{ metric.value }}</p>
        <p class="text-xs text-emerald-500">{{ metric.trend }}</p>
      </div>
    </div>
    <div class="grid gap-4 xl:grid-cols-3">
      <div class="xl:col-span-2">
        <DataTable :rows="sales" :columns="columns" title="Ventas recientes" />
      </div>
      <div class="rounded-xl border border-slate-200 bg-white p-4 shadow-sm dark:border-slate-800 dark:bg-slate-900">
        <h3 class="text-lg font-semibold">Alertas rápidas</h3>
        <ul class="mt-3 space-y-2 text-sm">
          <li v-for="alert in alerts" :key="alert" class="rounded-md bg-amber-100 px-3 py-2 text-amber-900 dark:bg-amber-500/10 dark:text-amber-200">
            {{ alert }}
          </li>
        </ul>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import DataTable from '@/components/data/DataTable.vue';

const metrics = [
  { title: 'Ventas del día', value: '$48,530', trend: '+8.2% vs ayer' },
  { title: 'Cotizaciones activas', value: '14', trend: '3 nuevas hoy' },
  { title: 'Inventario crítico', value: '6 SKUs', trend: 'Atiende en <4h' },
  { title: 'Entregas en ruta', value: '5', trend: '2 entregadas' }
];

const columns = [
  { key: 'folio', label: 'Folio' },
  { key: 'cliente', label: 'Cliente' },
  { key: 'total', label: 'Total' },
  { key: 'estatus', label: 'Estatus' }
];

const sales = [
  { folio: 'VTA-1045', cliente: 'Constructora Alfa', total: '$12,400', estatus: 'Completado' },
  { folio: 'VTA-1046', cliente: 'Residencial La Paz', total: '$8,200', estatus: 'En ruta' },
  { folio: 'COT-204', cliente: 'Reparaciones Leo', total: '$5,320', estatus: 'Cotización' }
];

const alerts = [
  'Pino tratado 2x4 con stock bajo en Patio Norte',
  'Vencimiento próximo de lotes de cemento (2 lotes)',
  'Chofer López pendiente de cerrar ruta de la mañana'
];
</script>
