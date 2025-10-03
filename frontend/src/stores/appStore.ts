import { defineStore } from 'pinia';

interface AppState {
  isLoading: boolean;
  isOffline: boolean;
  userRoles: string[];
}

export const useAppStore = defineStore('app', {
  state: (): AppState => ({
    isLoading: false,
    isOffline: false,
    userRoles: []
  }),
  actions: {
    setLoading(value: boolean) {
      this.isLoading = value;
    },
    setOffline(value: boolean) {
      this.isOffline = value;
    },
    setRoles(roles: string[]) {
      this.userRoles = roles;
    },
    hasRole(role: string) {
      return this.userRoles.includes(role);
    }
  },
  persist: {
    paths: ['userRoles']
  }
});
