import { ref } from 'vue';
import { callApi, apiClient, type Resultado } from '@/services/httpClient';

export function useApi<T>(key: string, fetcher: () => Promise<Resultado<T>>) {
  const data = ref<T | null>(null);
  const loading = ref(false);
  const error = ref<string | null>(null);

  const execute = async () => {
    loading.value = true;
    error.value = null;
    try {
      const result = await callApi<T>(key, fetcher);
      if (result.value) {
        data.value = result.data;
      } else {
        error.value = result.message;
      }
      return result;
    } catch (err: any) {
      error.value = err?.message ?? 'Error desconocido';
      throw err;
    } finally {
      loading.value = false;
    }
  };

  return { data, loading, error, execute };
}

export { apiClient };
