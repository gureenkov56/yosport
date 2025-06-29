import { createError, sendError } from 'h3'
import type {Discipline} from "~/prisma/prisma.enum";

type WorkoutPost = {
    userId: number
    discipline: Discipline
    setsReps: string
    total: number
}

export default defineEventHandler(async (event) => {
    const {userId, discipline, setsReps, total} = await readBody<WorkoutPost>(event)

    console.log('userId, discipline, setsReps, total', userId, discipline, setsReps, total)

    // if (!name) {
    //     return sendError(event, createError({ statusCode: 400, message: 'Введите имя' }))
    // }
    //
    // console.log('name', name)
    //
    // const isUserExist = await prisma.user.findFirst({ where: { name } })
    //
    // if (isUserExist) {
    //     console.log('user already exists')
    //
    //     return sendError(event, createError({ statusCode: 409, message: 'Пользователь с таким именем уже существует' }))
    //
    // }
    //
    // const newUser = await prisma.user.create({data: {name, RecordDips, RecordPullUps}})
    //
    // setCookie(event, 'userId', `${newUser.id}`)
    //
    // return {success: true, ...newUser}
})
