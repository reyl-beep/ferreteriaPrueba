<template>
  <section class="space-y-6">
    <header class="space-y-2">
      <h2 class="text-2xl font-bold">Seguridad y usuarios</h2>
      <p class="text-sm text-slate-500">
        Administra roles, permisos y bitácora de actividad para resguardar operaciones críticas.
      </p>
    </header>
    <DataTable :rows="roles" :columns="columns" title="Roles configurados" />
  </section>
</template>

<script setup lang="ts">
import DataTable from '@/components/data/DataTable.vue';

const columns = [
  { key: 'rol', label: 'Rol' },
  { key: 'descripcion', label: 'Descripción' },
  { key: 'permisos', label: 'Permisos clave' }
];

const roles = [
  { rol: 'Admin', descripcion: 'Acceso total', permisos: 'Configuración, Seguridad, Reportes' },
  { rol: 'Vendedor', descripcion: 'POS y cotizaciones', permisos: 'Ventas, Cotizaciones' }
];
</script>
