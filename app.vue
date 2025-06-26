<template>
  <UApp>
    <NuxtPage/>
    <Menu v-if="!hideMenu"/>
  </UApp>
</template>

<script setup lang="ts">
const hideMenu = computed(() => useRouter().currentRoute.value.path === '/');
console.log('useRouter().currentRoute.value.path', useRouter().currentRoute.value.path)
</script>

<style>
@import "tailwindcss";
@import "@nuxt/ui";

* {
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}

.wrapper {
  max-width: 800px;
  margin: 2rem auto 50px auto;
  padding: 0 1rem;
}


.centered-block {
  height: 100vh;
  position: relative;

  > div {
    width: 80%;
    max-width: 400px;
    margin: 0;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
}

h1 {
  margin-bottom: 1rem;
  letter-spacing: 4px;
  text-transform: uppercase;
}

.center {
  text-align: center;
}

a,
button {
  cursor: pointer;
}

.error {
  color: var(--ui-error);
}

select {
  &:focus {
    outline: none;
  }
}
</style>
