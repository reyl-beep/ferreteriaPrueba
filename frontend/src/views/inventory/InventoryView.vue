<template>
  <section class="space-y-6">
    <header class="space-y-2">
      <h2 class="text-2xl font-bold">Inventario</h2>
      <p class="text-sm text-slate-500">
        Supervisa niveles por almacén, lotes con caducidad y movimientos de entrada/salida.
      </p>
    </header>
    <DataTable :rows="locations" :columns="columns" title="Stock por ubicación" />
  </section>
</template>

<script setup lang="ts">
import DataTable from '@/components/data/DataTable.vue';

const columns = [
  { key: 'ubicacion', label: 'Ubicación' },
  { key: 'categoria', label: 'Categoría' },
  { key: 'stock', label: 'Stock disponible' },
  { key: 'unidad', label: 'Unidad' }
];

const locations = [
  { ubicacion: 'Almacén Central', categoria: 'Acero', stock: '12,400', unidad: 'kg' },
  { ubicacion: 'Patio Norte', categoria: 'Madera de pino', stock: '320', unidad: 'pie³' },
  { ubicacion: 'Bodega Polvos', categoria: 'Cemento', stock: '540', unidad: 'saco' }
];
</script>
