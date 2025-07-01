<template>
  <main class="wrapper">
    <div class="pt-10">
      <span class="mutted-text">
        Пользователь:
      </span>
      <select id="name" v-model="selectorUserId">
        <option v-for="{id, name} in users" :key="id" :value="id">{{ name }}</option>
      </select>
    </div>

    <div class="mt-2">
      <span class="mutted-text">
        Дисциплина:
      </span>
      <select id="name" v-model="selectorDiscipline">
        <option value="PULLUPS">Подтягивания на турнике</option>
        <option value="DIPS">Отжимания на брусьях</option>
      </select>
    </div>

    <!--    <div class="mt-8">-->
    <!--      <UPopover>-->
    <!--        <UButton color="neutral" variant="subtle" icon="i-lucide-calendar">-->
    <!--          {{ selectedDate ? df.format(selectedDate.toDate(getLocalTimeZone())) : 'Select a date' }}-->
    <!--        </UButton>-->

    <!--        <template #content>-->
    <!--          <UCalendar v-model="selectedDate" class="p-2"/>-->
    <!--        </template>-->
    <!--      </UPopover>-->
    <!--    </div>-->

    <UFormField label="Подходы и повторения (через запятую)" class="mt-5">
      <UInput v-model="inputRep" highlight color="neutral" placeholder="10, Л5, 8, 5, 5"/>
    </UFormField>
    <div class="total mt-1">
      Итог: {{ total || 0 }}
    </div>


    <UButton class="mt-5" @click="saveWorkout">
      Сохранить
    </UButton>

    <div class="hint mt-5">
      * Лесенку с 1 до 10 можно записать "Л10". <br>Сумма посчитается автоматически
    </div>
  </main>
</template>

<script setup lang="ts">
import type {User} from "~/generated/prisma";
import {Discipline} from "~/prisma/prisma.enum";

import type {WorkoutPost} from "~/server/api/workout/index.post";

// TODO при подгрузке страницы получить данные за сегодня этого юзера за эту дисциплину

const userId = useCookie('userId')

const selectorDiscipline = ref<Discipline>(Discipline.PULLUPS)

let currentWorkoutId: null | number = null;

const {data} = await useFetch<User[]>('/api/users')

if (!data.value || !data.value.length) {
  await navigateTo('/create-user')
}

const users = ref(data.value)
const selectorUserId = ref(userId.value || 0)

const selectedUser = computed(() => {
  if (selectorUserId.value === 0) {
    const firstUser = users.value[0]
    selectorUserId.value = firstUser.id
    return firstUser
  }

  return users.value?.find(({id}) => +id === +selectorUserId.value)
})

watch(selectedUser, () => {
  userId.value = selectedUser.value.id || 1;
  getDataForTodayWorkout();
})

watch(selectorDiscipline, getDataForTodayWorkout)

async function getDataForTodayWorkout() {
  const {data} = await useFetch(`/api/workout/today`, {
    method: "POST",
    body: {
      userId: userId.value,
      discipline: selectorDiscipline.value
    }
  })

  if (data.value) {
    currentWorkoutId = data.value.id
    inputRep.value = data.value.setsReps
  } else {
    currentWorkoutId = null
    inputRep.value = '';
  }

  console.log('currentWorkoutId', currentWorkoutId)
  console.log('> findTodayWorkout', data.value)
}


function sumStairRep(result: number): number {
  const array: number[] = [];
  array.length = result;

  return [...array].reduce((a, _, index) => a + ++index, 0);
}

const stairsSymbol = ['s', 'S', 'л', 'Л']
const inputRep = ref('');
const total = computed(() => {
  // todo вынести в utils так как может использоваться еще где-то
  const array = inputRep.value?.split(',').map(elem => {
    const trimmedElem = elem.trim();

    if (stairsSymbol.includes(trimmedElem[0])) {
      const n = parseInt(trimmedElem.slice(1)) || 0;
      return sumStairRep(n)
    }
    return parseInt(trimmedElem) || 0;
  });

  return array.reduce((a, b) => a + b, 0);
});


// const selectedDate = shallowRef(new CalendarDate(2022, 1, 10))
// const isoDate = computed(() => selectedDate.value.toString())  // '2024-06-19'
// const dateForDb = computed(() => new Date(isoDate.value))  // Date object with UTC midnight
//
//
// const df = new DateFormatter('en-US', {
//   dateStyle: 'medium'
// })

const toast = useToast()

async function saveWorkout() {

  const body: WorkoutPost = {
    id: currentWorkoutId,
    userId: +selectorUserId.value,
    discipline: selectorDiscipline.value,
    setsReps: inputRep.value,
    total: total.value,
  }

  // TODO validation

  const {error, status} = await useFetch(`/api/workout`, {
    method: 'POST',
    body,
  })

  console.log('error', error)


  if (error.value) {
    console.log('error', error)
    toast.add({
      title: 'Ошибка',
      description: 'Что-то пошло не так',
      color: 'error'
    })

    return
  }


  if (status.value === 'success') {
    toast.add({
      title: 'Успешно!',
      description: 'Тренировка записана',
      color: 'success'
    })
  }

}

getDataForTodayWorkout()
</script>

<style lang="scss" scoped>
.total, .hint {
  font-size: .8rem;
  color: var(--ui-text-muted);
}

.mutted-text {
  color: var(--ui-text-muted);
}
</style>
