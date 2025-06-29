<template>
  <nav class="menu">
    <hr>
    <ul>
      <li class="margin-bottom">
        <ULink to="/leaderboard">
          🏆 Leaderboard
        </ULink>
      </li>

      <li>
        <ULink to="/add-workout" >
          ✏️ Записать тренировку
        </ULink>
      </li>
      <li>
        <ULink to="/create-user">
          👋 Добавить пользователя
        </ULink>
      </li>
      <!--      TODO: Профиль-->
<!--      <li>-->
<!--        <ULink to="/leaderboard">-->
<!--          👤 Профиль-->
<!--        </ULink>-->
<!--      </li>-->
<!--      TODO: СВОДКА-->
<!--      <li>-->
<!--        <ULink to="/leaderboard">-->
<!--          🗓️ Сводка-->
<!--        </ULink>-->
<!--      </li>-->

    </ul>
  </nav>
</template>

<script setup lang="ts">
</script>
<style scoped lang="scss">
nav {
  padding: 1rem;
  max-width: 800px;
  margin: 0 auto;

  hr {
    color: var(--ui-border-accented);
  }

  a {
    color: var(--ui-text-muted);

    &:hover {
      text-decoration: underline;
      color: white;
    }
  }

  ul {
    margin: 10px;
    li {
      margin-bottom: 5px;

      &.margin-bottom{
        margin-bottom: 25px;
      }
    }
  }


}
</style>
