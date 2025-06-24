<template>
  <UApp>
    <NuxtPage />
  </UApp>
</template>

<style>
@import "tailwindcss";
@import "@nuxt/ui";

* {
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}

.wrapper {
  margin: 2rem 1rem;
}

.mobile {
  max-width: 500px;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

h1 {
  margin-bottom: 1rem;
  letter-spacing: 4px;
  text-transform: uppercase;
}
</style>
