<template>
    <main class="wrapper">
        <h1>🏆 Leaderboard</h1>
        таблица
        <div v-for="{ email, id } in data" :key="id">
            {{ email }}
        </div>
    </main>
</template>

<script lang='ts' setup>
const { data } = await useFetch('/api/users')

</script>

<style lang="scss" scoped>
main {
    h1 {
        text-align: center;
    }
}
</style>
