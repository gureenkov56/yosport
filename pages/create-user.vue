<template>
  <main class="centered-block">
    <div>
      <h1>👋 Добавить пользователя</h1>
      <div>
        <UFormField label="Имя пользователя">
          <UInput v-model="name" :color="error ? 'error' : 'neutral'" highlight/>
        </UFormField>
        <div v-if="error" class="hint error">{{ errorText }}</div>

        <UFormField label="Рекорд подтягиваний (не обязательно)" class="mt-5">
          <UInput v-model="pullUpsRecord" highlight color="neutral" type="number"/>
        </UFormField>

        <UFormField label="Рекорд отжиманий на брусьях (не обязательно)" class="mt-2">
          <UInput v-model="dipsRecord" highlight color="neutral" type="number"/>
        </UFormField>

        <UButton class="mt-5" @click="createUser">
          Создать
        </UButton>
      </div>
    </div>
  </main>
</template>

<script lang='ts' setup async>

const name = ref('')
const pullUpsRecord = ref('')
const dipsRecord = ref('')

const error = ref(false);
const errorText = ref('')

const userId = useCookie('userId')

watch(name, () => {
  error.value = false
  errorText.value = ''
})

async function createUser() {
  if (!name.value.length) {
    error.value = true;
    errorText.value = 'Заполните имя пользователя';
    return
  }

  const {data, error: fetchError} = await useFetch('/api/users', {
    method: 'POST',
    body: {name: name.value, RecordDips: +dipsRecord.value, RecordPullUps: +pullUpsRecord.value},
  })

  if (fetchError.value) {
    const {statusCode} = fetchError.value.data
    errorText.value = statusCode === 409 ? 'Пользователь уже существует' : 'Ошибка';
    error.value = true;
    return
  }

  if (data.value?.id) {
    userId.value = `${data.value.id}`;
    await navigateTo('/leaderboard')
  }
}
</script>

<style lang="scss">


.mt-1 > div {
  width: 100%;
}

.hint {
  font-size: .7rem;
}
</style>
