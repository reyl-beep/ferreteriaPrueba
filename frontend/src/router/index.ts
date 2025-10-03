import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router';
import DashboardView from '@/views/DashboardView.vue';
import CatalogView from '@/views/catalog/CatalogView.vue';
import PricingView from '@/views/pricing/PricingView.vue';
import InventoryView from '@/views/inventory/InventoryView.vue';
import SalesView from '@/views/sales/SalesView.vue';
import DeliveryView from '@/views/delivery/DeliveryView.vue';
import EmployeesView from '@/views/employees/EmployeesView.vue';
import ReportsView from '@/views/reports/ReportsView.vue';
import SecurityView from '@/views/security/SecurityView.vue';
import MarketingView from '@/views/marketing/MarketingView.vue';

const routes: RouteRecordRaw[] = [
  { path: '/', name: 'dashboard', component: DashboardView, meta: { title: 'Panel' } },
  { path: '/catalogo', name: 'catalog', component: CatalogView, meta: { title: 'Catálogo' } },
  { path: '/precios', name: 'pricing', component: PricingView, meta: { title: 'Gestión de precios' } },
  { path: '/inventario', name: 'inventory', component: InventoryView, meta: { title: 'Inventario' } },
  { path: '/ventas', name: 'sales', component: SalesView, meta: { title: 'Ventas y cotizaciones' } },
  { path: '/domicilio', name: 'delivery', component: DeliveryView, meta: { title: 'Servicio a domicilio' } },
  { path: '/empleados', name: 'employees', component: EmployeesView, meta: { title: 'Gestión de empleados' } },
  { path: '/reportes', name: 'reports', component: ReportsView, meta: { title: 'Reportes y análisis' } },
  { path: '/seguridad', name: 'security', component: SecurityView, meta: { title: 'Seguridad y usuarios' } },
  { path: '/marketing', name: 'marketing', component: MarketingView, meta: { title: 'Marketing y fidelización' } }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
