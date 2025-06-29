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
        <option value="pullups">Подтягивания на турнике</option>
        <option value="dips">Отжимания на брусьях</option>
      </select>
    </div>

    <div class="mt-8">
      <UPopover>
        <UButton color="neutral" variant="subtle" icon="i-lucide-calendar">
          {{ calendarValue ? df.format(calendarValue.toDate(getLocalTimeZone())) : 'Select a date' }}
        </UButton>

        <template #content>
          <UCalendar v-model="calendarValue" class="p-2"/>
        </template>
      </UPopover>
    </div>
    {{ calendarValue }}

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

import {CalendarDate, DateFormatter, getLocalTimeZone} from '@internationalized/date'

// TODO при подгрузке страницы получить данные за сегодня этого юзера за эту дисциплину

const userId = useCookie('userId')

const selectorDiscipline = ref('pullups')

const {data} = await useFetch<User[]>('/api/users')
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
  userId.value = selectedUser.value.id || 1
})


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


const calendarValue = shallowRef(new CalendarDate(2022, 1, 10))


const df = new DateFormatter('en-US', {
  dateStyle: 'medium'
})

function saveWorkout() {

}


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
