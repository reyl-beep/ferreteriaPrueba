<template>
  <section class="space-y-6">
    <header class="space-y-2">
      <h2 class="text-2xl font-bold">Gestión de precios</h2>
      <p class="text-sm text-slate-500">
        Controla precios base, listas por tipo de cliente y reglas de descuentos automáticos.
      </p>
    </header>
    <DataTable :rows="priceLists" :columns="columns" title="Listas de precios" />
  </section>
</template>

<script setup lang="ts">
import DataTable from '@/components/data/DataTable.vue';

const columns = [
  { key: 'lista', label: 'Lista' },
  { key: 'segmento', label: 'Segmento' },
  { key: 'ajuste', label: 'Ajuste' },
  { key: 'vigencia', label: 'Vigencia' }
];

const priceLists = [
  { lista: 'Ferretería Mayorista', segmento: 'Constructoras', ajuste: '+12%', vigencia: '2024-12-31' },
  { lista: 'Retail Mostrador', segmento: 'Público general', ajuste: 'Base', vigencia: '2024-06-30' },
  { lista: 'Lealtad Oro', segmento: 'Clientes fidelizados', ajuste: '-5%', vigencia: '2025-01-01' }
];
</script>
