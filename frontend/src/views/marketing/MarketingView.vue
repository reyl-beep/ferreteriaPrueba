<template>
  <section class="space-y-6">
    <header class="space-y-2">
      <h2 class="text-2xl font-bold">Marketing y fidelización</h2>
      <p class="text-sm text-slate-500">
        Diseña promociones por categoría, campañas multicanal y analiza el ROI de esfuerzos comerciales.
      </p>
    </header>
    <DataTable :rows="campaigns" :columns="columns" title="Campañas activas" />
  </section>
</template>

<script setup lang="ts">
import DataTable from '@/components/data/DataTable.vue';

const columns = [
  { key: 'nombre', label: 'Campaña' },
  { key: 'canal', label: 'Canal' },
  { key: 'inicio', label: 'Inicio' },
  { key: 'roi', label: 'ROI estimado' }
];

const campaigns = [
  { nombre: 'Promo cemento primavera', canal: 'WhatsApp', inicio: '2024-03-01', roi: '12%' },
  { nombre: 'Fidelización puntos PRO', canal: 'Email', inicio: '2024-02-15', roi: '17%' }
];
</script>
