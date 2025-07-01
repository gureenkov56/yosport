<template>
  <main class="centered-block">
    <div>
      <h1>Изменить личные рекорды</h1>
      <div>
        Пользователь:
        <select id="name" v-model="selectedUserId">
          <option v-for="{id, name} in users" :key="id" :value="id">{{ name }}</option>
        </select>

        <UFormField label="Рекорд подтягиваний" class="mt-5">
          <UInput v-model="inputPullUpsRecord" highlight color="neutral" type="number"/>
        </UFormField>

        <UFormField label="Рекорд отжиманий на брусьях" class="mt-2">
          <UInput v-model="inputDipsRecord" highlight color="neutral" type="number"/>
        </UFormField>

        <UButton class="mt-5" @click="updateRecord">
          Обновить данные
        </UButton>

        <div>
          <UButton class="mt-2" color="neutral" variant="outline" @click="$router.back()">
            Назад
          </UButton>
        </div>
      </div>
    </div>
  </main>
</template>

<script lang='ts' setup>
import type {User} from "~/generated/prisma";

const toast = useToast()


const {data} = await useFetch<User[]>('/api/users')

if (!data.value || !data.value.length) {
  await navigateTo('/create-user')
}

const users = ref(data.value)

const selectedUserId = ref()

const userStore = useUserStore()
selectedUserId.value = userStore.id

const selectedUser = computed(() => users.value?.find(({id}) => id === +selectedUserId.value))

const pullUpsRecord = computed(() => selectedUser.value?.RecordPullUps)

const dipsRecord = computed(() => selectedUser.value?.RecordDips)


const inputPullUpsRecord = ref(pullUpsRecord.value)
const inputDipsRecord = ref(dipsRecord.value)

watch(pullUpsRecord, () => {
  inputPullUpsRecord.value = pullUpsRecord.value
})

watch(dipsRecord, () => {
  inputDipsRecord.value = dipsRecord.value
})


async function updateRecord() {
  if (!selectedUser.value) {
    return
  }

  const {status} = await useFetch(`/api/users/${selectedUser.value.id}`, {
    method: 'PUT',
    body: {RecordDips: +inputDipsRecord.value, RecordPullUps: +inputPullUpsRecord.value},
  })

  if (status.value === 'success') {
    toast.add({
      title: 'Успешно!',
      description: 'Ваши личные рекорды обновлены',
      color: 'success'
    })
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
