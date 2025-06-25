import {prisma} from "~/prisma"

export default defineEventHandler(async (event) => {
    const id = parseInt(event.context.params!.id)
    const body = await readBody(event)

    setCookie(event, 'userId', `${id}`)

    return prisma.user.update({
        where: {id},
        data: {
            RecordDips: body.RecordDips,
            RecordPullUps: body.RecordPullUps
        }
    });
})
