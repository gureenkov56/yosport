export default defineNuxtRouteMiddleware((to) => {
  const cookieKey = useCookie('access_key')?.value || '';
  const validKey = useRuntimeConfig().public.accessKey

  const isHome = to.path === '/'
  const isAuthorized = cookieKey === validKey

  if (isHome && isAuthorized) {
    // Already authorized, redirect to /leaderboard
    return navigateTo('/leaderboard')
  }

  if (!isHome && !isAuthorized) {
    // Not authorized and trying to access another page — redirect to home
    return navigateTo('/')
  }
})
