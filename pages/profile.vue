<template>
  <main class="wrapper">
    <h1>
      <select id="name" v-model="selectorUserId">
        <option v-for="{id, name} in users" :key="id" :value="id">{{ name }}</option>
      </select>
    </h1>
    <div class="records">
      <h2>Рекорды</h2>
      <div>Подтягивания: {{ selectedUser.RecordPullUps }}</div>
      <div>Отжимания на брусьях: {{ selectedUser.RecordDips }}</div>
    </div>

<!--    его активность за неделю-->
<!--    его тоталы за день, неделю, месяц, год-->
    <div/>
  </main>
</template>

<script lang="ts" setup>
import type {User} from "~/generated/prisma";

const {data} = await useFetch<User[]>('/api/users')
const users = ref(data.value)

const userId = useCookie('userId');

const selectorUserId = ref(userId.value || 0)

const selectedUser = computed(() => {
  if (selectorUserId.value === 0) {
    const firstUser = users.value[0]
    selectorUserId.value = firstUser.id
    userId.value = firstUser.id
    return firstUser
  }

  const user = users.value?.find(({id}) => id === +selectorUserId.value)

  if (!user) {
    return users.value[0]
  }

  return user
})


watch(selectedUser, () => {
  userId.value = selectedUser.value.id.toString()
  selectorUserId.value = selectedUser.value.id
})

</script>
