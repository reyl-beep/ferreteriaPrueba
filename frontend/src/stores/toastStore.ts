import { defineStore } from 'pinia';

interface ToastMessage {
  id: number;
  message: string;
  type: 'success' | 'error';
  timeout?: number;
}

export const useToastStore = defineStore('toast', {
  state: () => ({
    toasts: [] as ToastMessage[],
    counter: 0
  }),
  actions: {
    push(message: string, type: 'success' | 'error' = 'success', timeout = 4000) {
      const id = ++this.counter;
      this.toasts.push({ id, message, type, timeout });
      setTimeout(() => this.dismiss(id), timeout);
    },
    dismiss(id: number) {
      this.toasts = this.toasts.filter((toast) => toast.id !== id);
    },
    success(message: string) {
      this.push(message, 'success');
    },
    error(message: string) {
      this.push(message, 'error');
    }
  }
});
