import { ULink, UButton } from '../.nuxt/components';
<template>
    <main class="wrapper">
        <h1>🏆 Leaderboard</h1>
        <div>
        таблица {{currentUserId}}
        </div>
        <ULink to="/create-user">
            <UButton>Добавить пользователя</UButton>
        </ULink>
        <div v-for="{ id, name } in data" :key="id" :class="{error: id == +currentUserId}">
            {{id}}{{ name }}
        </div>
    </main>
</template>

<script lang='ts' setup>
const { data } = await useFetch('/api/users')


const currentUserId = useCookie('userId')

</script>

<style lang="scss" scoped>
main {
    h1 {
        text-align: center;
    }
}
</style>
