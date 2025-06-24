export default defineNuxtRouteMiddleware((to) => {
  const allowed = useCookie('access_key')

  const correctKey = useRuntimeConfig().public.accessKey

  // Allow access to homepage and API routes
  if (to.path === '/' && allowed.value === correctKey) {
    return navigateTo('/leaderboard')
  }

  if (allowed.value !== correctKey) {
    return navigateTo('/')
  }

  
})