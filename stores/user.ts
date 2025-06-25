export const useUserStore = defineStore('user', () => {
    const id = ref(useCookie('userId'))

    // const fetchUserId = () => {
    //     const cookieId = useCookie<string | null>('userId')
    //     id.value = cookieId.value
    // }

    return { id }
})
