<template>
  <section class="space-y-6">
    <header class="space-y-2">
      <h2 class="text-2xl font-bold">Gestión de empleados</h2>
      <p class="text-sm text-slate-500">
        Controla roles, horarios y tareas operativas con indicadores de productividad.
      </p>
    </header>
    <DataTable :rows="employees" :columns="columns" title="Equipo operativo" />
  </section>
</template>

<script setup lang="ts">
import DataTable from '@/components/data/DataTable.vue';

const columns = [
  { key: 'nombre', label: 'Nombre' },
  { key: 'rol', label: 'Rol' },
  { key: 'entrada', label: 'Entrada' },
  { key: 'estatus', label: 'Estatus' }
];

const employees = [
  { nombre: 'Laura Martínez', rol: 'Vendedor', entrada: '08:00', estatus: 'En piso' },
  { nombre: 'Miguel Torres', rol: 'Chofer', entrada: '07:30', estatus: 'En ruta' }
];
</script>
