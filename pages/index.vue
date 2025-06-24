<template>
  <main class="mobile">
    <h1>Welcome to YoSport!</h1>
    <UInput v-model="key" type="password" placeholder="Password" :color="error ? 'error' : 'neutral'" highlight  />
    <div class="hint mb-3" :class="error ? 'error' : ''">* Пароль на листочке, где раньше таблица была</div>
    <div>
      <UButton class="ml-2 bg-blue-500 text-white px-3 py-1" @click="submitKey">Enter</UButton>
    </div>
  </main>
</template>

<script lang='ts' setup>
const key = ref('')
const error = ref(false)
const correctKey = useRuntimeConfig().public.accessKey

watch(key, () => error.value = false)

function submitKey(): void {
  if (key.value === correctKey) {
    useCookie('access_key').value = key.value
    navigateTo('/leaderboard') // or any other route
  } else {
    key.value = '';
    nextTick(() => {
      error.value = true
    })
  }
}
</script>

<style lang="scss" scoped>
main {
  text-align: center;

  .hint {
    max-width: 200px;
    font-size: .7rem;
    text-align: left;
    margin: .5rem auto 1rem auto;
  }
}
</style>
