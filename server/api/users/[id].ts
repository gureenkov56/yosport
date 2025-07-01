import {prisma} from "~/prisma"

export default defineEventHandler(async (event) => {
    const id = getRouterParam(event, 'id') || 0

    // if (!Number.isInteger(id)) {
    //     throw createError({
    //         statusCode: 400,
    //         statusMessage: 'ID should be an integer',
    //     })
    // }

    if (+id === 0) {
        const user = await prisma.user.findFirst()
        setCookie(event, 'userId', '1', {path: '/', sameSite: 'lax'})
        return user
    }

    let user = await prisma.user.findUnique({where: {id: +id}})

    if (!user)  {
        user = await prisma.user.findFirst()
    }


    setCookie(event, 'userId', `${user?.id || 0}`)

    return user
})
