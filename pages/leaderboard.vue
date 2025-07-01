<template>
  <main class="wrapper">
    <h1>🏆 Leaderboard</h1>

    <div>
      <select id="discipline" v-model="selectedDiscipline" :class="{width120: selectedDiscipline === 'pullups'}">
        <option value="pullups" selected>Подтягивания</option>
        <option value="dips">Отжимания на брусьях</option>
      </select>
    </div>

    <UTable v-if="sortedTableData.length" :data="sortedTableData" class="flex-1 mt-3" :columns="columns"/>

    <div>
      <ULink to="/edit-record">
        <UButton class="mt-5" color="secondary">Изменить личный рекорд</UButton>
      </ULink>
    </div>

    <ULink to="/create-user">
      <UButton class="mt-2" variant="outline" color="neutral">Добавить пользователя</UButton>
    </ULink>
  </main>
</template>

<script lang='ts' setup>
import type {User} from "~/generated/prisma";
import {UButton} from "#components";

const selectedDiscipline = ref('pullups')

const {data} = await useFetch<User[]>('/api/users')

if (!data.value || !data.value.length) {
   navigateTo('/create-user')
}

const sortedTableData = computed(() => {
  if (!data.value || !data.value.length) {
    return []
  }

  const sorted = [...data.value].sort((a, b) => {
    const resultA = selectedDiscipline.value === 'pullups' ? a.RecordPullUps : a.RecordDips;
    const resultB = selectedDiscipline.value === 'pullups' ? b.RecordPullUps : b.RecordDips;

    return resultA > resultB ? -1 : 1
  }).map((user) => {
    const nameWords = user.name.split(' ');
    nameWords.length = 2;
    user.name = nameWords.join(' ');
    return user;
  })

  // console.log('sorted')

  // console.log('data.value', data.value)
  sorted[0].name = sorted[0].name + ' 🏆';
  sorted[1].name = sorted[1].name + ' 🥈';
  sorted[2].name = sorted[2].name + ' 🥉';

  return sorted
})

const columns = [
  {
    accessorKey: 'name',
    header: ''
  },
  {
    accessorKey: 'RecordPullUps',
    header: () => h(UButton, {
      color: 'neutral',
      variant: 'ghost',
      label: 'Турник',
      icon: selectedDiscipline.value === 'pullups' ? 'i-lucide-arrow-up' : '',
      class: '-mx-2.5',
      onClick: () => selectedDiscipline.value = 'pullups'
    })
  },
  {
    accessorKey: 'RecordDips',
    header: () => h(UButton, {
      color: 'neutral',
      variant: 'ghost',
      label: 'Брусья',
      icon: selectedDiscipline.value === 'dips' ? 'i-lucide-arrow-up' : '',
      class: '-mx-2.5',
      onClick: () => selectedDiscipline.value = 'dips'
    }),
  },
]

const userStore = useUserStore()

const userId = computed(() => userStore.id)
</script>

<style lang="scss" scoped>
main {
  h1 {
    text-align: center;
    margin-bottom: 0;
  }

  select {
    -webkit-appearance: none;
    -moz-appearance: none;

    -webkit-user-select: none; /* Safari */
    -moz-user-select: none; /* Firefox */
    -ms-user-select: none; /* Internet Explorer/Edge */
    user-select: none; /* Standard */

    display: block;
    margin: 0 auto;

    &::-ms-expand {
      display: none;
    }

    &:focus {
      outline: none;
    }

    &.width120 {
      width: 120px;
    }
  }


}
</style>
