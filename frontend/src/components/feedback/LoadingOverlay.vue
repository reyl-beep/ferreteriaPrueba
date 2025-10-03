<template>
  <div class="fixed inset-0 z-50 flex items-center justify-center bg-slate-950/50 backdrop-blur-sm">
    <div class="flex flex-col items-center gap-3 rounded-lg bg-white px-6 py-4 shadow-lg dark:bg-slate-900">
      <svg class="h-8 w-8 animate-spin text-primary" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z"></path>
      </svg>
      <p class="text-sm font-medium">Cargando...</p>
    </div>
  </div>
</template>
