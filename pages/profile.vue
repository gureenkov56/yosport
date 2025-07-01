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

    <div>
      <h2 class="mt-5">Тренировки</h2>
      <div v-if="noWorkouts">
        Нет записей тренировок
      </div>
      <div v-else-if="pending">
        <USkeleton class="h-8 mt-3"/>
        <USkeleton class="h-8 mt-3"/>
        <USkeleton class="h-8 mt-3"/>
      </div>
      <div v-else>
        <div v-for="({id, formattedDate, discipline, total,setsReps}) in workoutsForRender" :key="id" class="workout-record mt-4">
          <div class="date">{{formattedDate}}</div>
          <div class="discipline">{{discipline}}</div>
          <div>Подходы: {{setsReps}}</div>
          <div>Всего: {{total}}</div>

        </div>
      </div>

    </div>

    <!--    его активность за неделю-->
    <!--    его тоталы за день, неделю, месяц, год-->
    <div/>
  </main>
</template>

<script lang="ts" setup>
import type {User, Workout} from "~/generated/prisma";

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

const {pending, data: workoutsData } = await useFetch<Workout[]>(() => `/api/workout/${selectorUserId.value}`)



const noWorkouts = computed(() => !workoutsData.value || !workoutsData.value.length)
const workoutsForRender = computed(() => workoutsData?.value.map((workout) => {
  workout.discipline = workout.discipline === 'DIPS' ? 'Отжимания на брусьях' : 'Подтягивания';
  workout.setsReps = workout.setsReps?.split(',').map((rep) => rep.trim()).join(', ')
  const date = new Date(workout.date)

  const day = String(date.getUTCDate()).padStart(2, '0')
  const month = String(date.getUTCMonth() + 1).padStart(2, '0') // Months are 0-based
  const year = date.getUTCFullYear()

  workout.formattedDate = `${day}.${month}.${year}`

  return workout
}).sort((a, b) => a - b)
)
</script>

<style lang="scss" scoped>
.date {
  color: #a3a8a8;
  font-size: .8rem;
}
h2 {
  font-size: 1.5rem;
}
hr {
  color: var(--ui-border-accented);
  margin-top: 20px;
}
</style>
