<template>
    <div>
        <h1>Создание пользователя</h1>
        <div>
            <UForm :state="state" class="space-y-4" @submit="onSubmit">
                <UFormField label="Email" name="email">
                    <UInput v-model="state.email" />
                </UFormField>

                <UFormField label="Password" name="password">
                    <UInput v-model="state.password" type="password" />
                </UFormField>

                <UButton type="submit">
                    Submit
                </UButton>
            </UForm>
        </div>
    </div>
</template>

<script lang='ts' setup>
const state = reactive({
  email: undefined,
  password: undefined
})

const toast = useToast()
async function onSubmit(event: FormSubmitEvent<typeof state>) {
  toast.add({ title: 'Success', description: 'The form has been submitted.', color: 'success' })
  console.log(event.data)
}
</script>

<style lang="scss">
.mt-1 > div {
    width: 100%;
}
</style>