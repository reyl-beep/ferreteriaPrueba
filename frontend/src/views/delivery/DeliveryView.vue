<template>
  <section class="space-y-6">
    <header class="space-y-2">
      <h2 class="text-2xl font-bold">Servicio a domicilio</h2>
      <p class="text-sm text-slate-500">
        Asigna pedidos a choferes, registra salidas y firmas de entrega con seguimiento preparado.
      </p>
    </header>
    <DataTable :rows="routes" :columns="columns" title="Rutas del día" />
  </section>
</template>

<script setup lang="ts">
import DataTable from '@/components/data/DataTable.vue';

const columns = [
  { key: 'pedido', label: 'Pedido' },
  { key: 'chofer', label: 'Chofer' },
  { key: 'horaSalida', label: 'Hora salida' },
  { key: 'estatus', label: 'Estatus' }
];

const routes = [
  { pedido: 'PED-1001', chofer: 'L. Pérez', horaSalida: '09:00', estatus: 'En ruta' },
  { pedido: 'PED-1002', chofer: 'M. Díaz', horaSalida: '11:00', estatus: 'Programado' }
];
</script>
