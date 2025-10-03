import { createApp } from 'vue';
import { createPinia } from 'pinia';
import piniaPersistedstate from 'pinia-plugin-persistedstate';
import { createHead } from '@vueuse/head';
import App from './App.vue';
import router from './router';
import { createI18n } from 'vue-i18n';
import esEs from './locales/es-ES.json';
import './styles/tailwind.css';
import { configureApiClient } from './services/httpClient';

const app = createApp(App);

const pinia = createPinia();
pinia.use(piniaPersistedstate);

const i18n = createI18n({
  legacy: false,
  locale: 'es-ES',
  fallbackLocale: 'es-ES',
  messages: { 'es-ES': esEs }
});

const head = createHead();

app
  .use(pinia)
  .use(router)
  .use(i18n)
  .use(head);

configureApiClient(pinia);

app.mount('#app');
