export default defineEventHandler((event) => {
    const accessKey = getCookie(event, 'access_key')
    const secret = useRuntimeConfig().public.secretKey

    if (accessKey !== secret) {
        throw createError({ statusCode: 401, message: 'Unauthorized' })
    }
})
