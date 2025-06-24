<template>
    <main class="mobile">
        <h1>Создание пользователя</h1>
        <div>
            <UFormField label="Имя пользователя">
                <UInput v-model="name" :color="error ? 'error' : 'neutral'" highlight />
            </UFormField>
            <div v-if="error" class="hint error" >Заполните имя пользователя</div>

            <UButton class="mt-2" @click="createUser">
                Создать
            </UButton>
        </div>
    </main>
</template>

<script lang='ts' setup>
const name = ref('')
const error = ref(false);

watch(name, () => {
    error.value = false
})

function createUser(): void {
    if (!name.value.length) {
        error.value = true;
        return
    }
}
</script>

<style lang="scss">
.mt-1>div {
    width: 100%;
}

.hint {
    font-size: .7rem;
}
</style>