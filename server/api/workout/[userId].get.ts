import {prisma} from "~/prisma"

export default defineEventHandler(async (event) => {
    const userId = parseInt(event.context.params!.userId)

    return prisma.workout.findMany({
        where: {userId},
        orderBy: [{date: 'desc'}]
    });
})
