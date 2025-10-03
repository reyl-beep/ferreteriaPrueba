<template>
  <section class="space-y-6">
    <header class="space-y-2">
      <h2 class="text-2xl font-bold">Catálogo de productos</h2>
      <p class="text-sm text-slate-500">
        Administra las categorías, subfamilias y atributos dimensionales requeridos para cada línea de producto.
      </p>
    </header>
    <DataTable
      :rows="products"
      :columns="columns"
      title="Productos destacados"
      subtitle="Filtra por categoría, unidad o estado"
    />
  </section>
</template>

<script setup lang="ts">
import DataTable from '@/components/data/DataTable.vue';

const columns = [
  { key: 'sku', label: 'SKU' },
  { key: 'nombre', label: 'Nombre' },
  { key: 'categoria', label: 'Categoría' },
  { key: 'unidad', label: 'Unidad' },
  { key: 'stock', label: 'Stock' }
];

const products = [
  { sku: 'PIN-2X4-SEC', nombre: 'Madera de pino 2x4 seca', categoria: 'Madera de Pino', unidad: 'pie³', stock: '120' },
  { sku: 'CEM-GRIS-50', nombre: 'Cemento gris 50kg', categoria: 'Polvos', unidad: 'saco', stock: '82' },
  { sku: 'BLK-6H', nombre: 'Block hueco 6"', categoria: 'Mampostería', unidad: 'pieza', stock: '4500' }
];
</script>
