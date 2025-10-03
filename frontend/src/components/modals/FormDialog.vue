<template>
  <TransitionRoot appear :show="open" as="template">
    <Dialog as="div" class="relative z-50" @close="$emit('close')">
      <TransitionChild
        as="template"
        enter="duration-200 ease-out"
        enter-from="opacity-0"
        enter-to="opacity-100"
        leave="duration-150 ease-in"
        leave-from="opacity-100"
        leave-to="opacity-0"
      >
        <div class="fixed inset-0 bg-slate-900/50" />
      </TransitionChild>

      <div class="fixed inset-0 overflow-y-auto">
        <div class="flex min-h-full items-center justify-center p-4 text-center">
          <TransitionChild
            as="template"
            enter="duration-200 ease-out"
            enter-from="opacity-0 scale-95"
            enter-to="opacity-100 scale-100"
            leave="duration-150 ease-in"
            leave-from="opacity-100 scale-100"
            leave-to="opacity-0 scale-95"
          >
            <DialogPanel class="w-full max-w-2xl transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-all dark:bg-slate-900">
              <div class="mb-4 flex items-center justify-between">
                <DialogTitle class="text-lg font-medium leading-6 text-slate-900 dark:text-slate-100">
                  {{ title }}
                </DialogTitle>
                <button class="text-sm text-slate-500" @click="$emit('close')">Cerrar</button>
              </div>
              <slot />
              <div class="mt-6 flex justify-end gap-2">
                <button class="rounded-lg border border-slate-200 px-4 py-2 text-sm" @click="$emit('close')">
                  Cancelar
                </button>
                <button class="rounded-lg bg-primary px-4 py-2 text-sm font-semibold text-white" @click="$emit('submit')">
                  Guardar
                </button>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script setup lang="ts">
import { Dialog, DialogPanel, DialogTitle, TransitionChild, TransitionRoot } from '@headlessui/vue';

defineProps<{ open: boolean; title: string }>();

defineEmits<{ (e: 'close'): void; (e: 'submit'): void }>();
</script>
