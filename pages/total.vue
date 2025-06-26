<template>
  <main class="wrapper center">
    <h1 class="center">Сводка (пока в разработке)</h1>

    <CountUp :end-val="300" :duration="2" />
    <h2 class="mb-10">Подтягиваний за сегодня</h2>

    <CountUp :end-val="300" :duration="2" />
    <h2 class="mb-10">Отжиманий за сегодня</h2>

    <CountUp :end-val="300" :duration="2" />
    <h2 class="mb-10">Подтягиваний за месяц</h2>

    <CountUp :end-val="300" :duration="2" />
    <h2 class="mb-20">Отжиманий за месяц</h2>
  </main>
</template>

<script setup lang="ts">
import CountUp from 'vue-countup-v3'
</script>

<style lang="scss" scoped>
.countup-wrap {
  font-size: 4rem;
}
</style>
