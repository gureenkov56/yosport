import type {Discipline} from "~/prisma/prisma.enum";
import {createError, sendError} from "h3";
import {prisma} from "~/prisma";

export type WorkoutPost = {
    id?: number,
    userId: number
    discipline: Discipline
    setsReps: string
    total: number
    date?: Date
}

export default defineEventHandler(async (event) => {
    const {id, userId, discipline, setsReps, total, date} = await readBody<WorkoutPost>(event)

    if (!userId || discipline === undefined || !setsReps || !total) {
        return sendError(event, createError({statusCode: 400}))
    }

    if (id) {
        const workout = await prisma.workout.update({
            where: {
                id
            },
            data: {
                setsReps,
                total,
            }
        })

        return {success: true, ...workout}
    }


    const workout = await prisma.workout.create({
        data: {
            discipline,
            setsReps,
            total,
            date,
            user: {
                connect: {id: userId},
            }
        }
    })

    return {success: true, ...workout}
})
