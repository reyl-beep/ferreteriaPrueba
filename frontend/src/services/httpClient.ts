import axios from 'axios';
import localforage from 'localforage';
import { useToastStore } from '@/stores/toastStore';
import { useAppStore } from '@/stores/appStore';
import type { Pinia } from 'pinia';

const client = axios.create({
  baseURL: __API_BASE_URL__,
  withCredentials: true
});

export interface Resultado<T = unknown> {
  value: boolean;
  message: string;
  data: T;
}

export const API_CACHE = localforage.createInstance({
  name: 'ferreteria-pos',
  storeName: 'api-cache'
});

export const configureApiClient = (pinia: Pinia) => {
  const toast = useToastStore(pinia);
  const app = useAppStore(pinia);

  client.interceptors.request.use((config) => {
    app.setLoading(true);
    return config;
  });

  client.interceptors.response.use(
    (response) => {
      app.setLoading(false);
      const result = response.data as Resultado;
      if (result?.value) {
        if (result.message) toast.success(result.message);
      } else {
        toast.error(result?.message ?? 'Ocurrió un error');
      }
      return response;
    },
    async (error) => {
      app.setLoading(false);
      toast.error(error.response?.data?.message ?? 'Error de red');
      throw error;
    }
  );
};

export const apiClient = client;

export async function callApi<T>(
  key: string,
  request: () => Promise<Resultado<T>>,
  options: { cache?: boolean } = { cache: true }
): Promise<Resultado<T>> {
  const toast = useToastStore();
  const app = useAppStore();

  try {
    const result = await request();
    if (!result.value && options.cache) {
      const cached = await API_CACHE.getItem<Resultado<T>>(key);
      if (cached) {
        toast.error(result.message);
        app.setOffline(true);
        return cached;
      }
    }
    if (options.cache && result.value) {
      await API_CACHE.setItem(key, result);
    }
    app.setOffline(false);
    return result;
  } catch (error) {
    if (options.cache) {
      const cached = await API_CACHE.getItem<Resultado<T>>(key);
      if (cached) {
        app.setOffline(true);
        return cached;
      }
    }
    throw error;
  }
}
