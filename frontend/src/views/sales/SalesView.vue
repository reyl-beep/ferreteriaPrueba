<template>
  <section class="space-y-6">
    <header class="space-y-2">
      <h2 class="text-2xl font-bold">Ventas y cotizaciones</h2>
      <p class="text-sm text-slate-500">
        Gestiona cotizaciones, conversiones a ventas y pedidos especiales con control de anticipos.
      </p>
    </header>
    <DataTable :rows="quotes" :columns="columns" title="Cotizaciones activas" />
  </section>
</template>

<script setup lang="ts">
import DataTable from '@/components/data/DataTable.vue';

const columns = [
  { key: 'folio', label: 'Folio' },
  { key: 'cliente', label: 'Cliente' },
  { key: 'total', label: 'Total' },
  { key: 'estatus', label: 'Estatus' }
];

const quotes = [
  { folio: 'COT-204', cliente: 'Residencial Monteverde', total: '$12,890', estatus: 'Enviada' },
  { folio: 'COT-205', cliente: 'Constructora Horizonte', total: '$32,400', estatus: 'Aceptada' }
];
</script>
