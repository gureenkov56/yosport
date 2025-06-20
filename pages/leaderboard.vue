<template>
    <div>
        <div v-for="{ email, id } in data" :key="id">
            {{ email }}
        </div>
    </div>
</template>

<script lang='ts' setup>
const { data } = await useFetch('/api/users')
console.log('data', data.value);

</script>

<style></style>