import { ULink, UButton } from '../.nuxt/components';
<template>
    <main class="wrapper">
        <h1>🏆 Leaderboard</h1>
        <div>
        таблица {{userId}}
        </div>

        <div v-for="{ id, name } in data" :key="id" :class="{error: id == +userId}">
            {{id}}{{ name }}
        </div>
        <ULink to="/create-user">
          <UButton>Добавить пользователя</UButton>
        </ULink>
    </main>
</template>

<script lang='ts' setup>
const { data } = await useFetch('/api/users')

const userStore = useUserStore()

const userId = computed(() => userStore.id)
</script>

<style lang="scss" scoped>
main {
    h1 {
        text-align: center;
    }
}
</style>
