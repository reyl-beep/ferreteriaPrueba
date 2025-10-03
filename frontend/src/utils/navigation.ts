import type { Component } from 'vue';
import {
  HomeIcon,
  CubeIcon,
  TagIcon,
  BuildingOffice2Icon,
  ShoppingCartIcon,
  TruckIcon,
  UserGroupIcon,
  ChartBarIcon,
  ShieldCheckIcon,
  MegaphoneIcon
} from '@heroicons/vue/24/outline';

export interface NavItem {
  name: string;
  label: string;
  to: string;
  icon: Component;
  roles?: string[];
}

export const navItems: NavItem[] = [
  { name: 'dashboard', label: 'Panel', to: '/', icon: HomeIcon },
  { name: 'catalog', label: 'Catálogo', to: '/catalogo', icon: CubeIcon },
  { name: 'pricing', label: 'Precios', to: '/precios', icon: TagIcon, roles: ['Encargado', 'Admin'] },
  { name: 'inventory', label: 'Inventario', to: '/inventario', icon: BuildingOffice2Icon, roles: ['Almacenista', 'Encargado', 'Admin'] },
  { name: 'sales', label: 'Ventas', to: '/ventas', icon: ShoppingCartIcon, roles: ['Vendedor', 'Cajero', 'Admin'] },
  { name: 'delivery', label: 'Domicilio', to: '/domicilio', icon: TruckIcon, roles: ['Chofer', 'Encargado', 'Admin'] },
  { name: 'employees', label: 'Empleados', to: '/empleados', icon: UserGroupIcon, roles: ['Encargado', 'Admin'] },
  { name: 'reports', label: 'Reportes', to: '/reportes', icon: ChartBarIcon, roles: ['Encargado', 'Admin'] },
  { name: 'security', label: 'Seguridad', to: '/seguridad', icon: ShieldCheckIcon, roles: ['Admin'] },
  { name: 'marketing', label: 'Marketing', to: '/marketing', icon: MegaphoneIcon, roles: ['Encargado', 'Admin'] }
];
