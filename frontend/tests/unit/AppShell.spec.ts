import { describe, it, expect, vi } from 'vitest';
import { mount } from '@vue/test-utils';
import AppShell from '@/layouts/AppShell.vue';
import { createTestingPinia } from '@pinia/testing';
import router from '@/router';

describe('AppShell', () => {
  it('renderiza el contenedor principal', async () => {
    const wrapper = mount(AppShell, {
      global: {
        plugins: [
          createTestingPinia({ createSpy: vi.fn }),
          router
        ]
      }
    });

    await router.isReady();
    expect(wrapper.find('main').exists()).toBe(true);
  });
});
