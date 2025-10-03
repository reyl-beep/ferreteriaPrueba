<template>
  <section class="space-y-6">
    <header class="space-y-2">
      <h2 class="text-2xl font-bold">Reportes y análisis</h2>
      <p class="text-sm text-slate-500">
        Consulta KPIs de ventas, margen por producto y campañas de marketing para la toma de decisiones.
      </p>
    </header>
    <DataTable :rows="reports" :columns="columns" title="Reportes disponibles" />
  </section>
</template>

<script setup lang="ts">
import DataTable from '@/components/data/DataTable.vue';

const columns = [
  { key: 'nombre', label: 'Nombre' },
  { key: 'frecuencia', label: 'Frecuencia' },
  { key: 'ultimo', label: 'Última ejecución' }
];

const reports = [
  { nombre: 'Ventas por categoría', frecuencia: 'Diario', ultimo: '2024-03-12' },
  { nombre: 'ROI campañas marketing', frecuencia: 'Semanal', ultimo: '2024-03-11' }
];
</script>
