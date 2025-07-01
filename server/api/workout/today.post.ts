import type {Discipline} from "~/prisma/prisma.enum";
import {prisma} from "~/prisma";

export type WorkoutPost = {
    userId: number
    discipline: Discipline
    setsReps: string
    total: number
    date?: Date
}

export default defineEventHandler(async (event) => {
    const {userId, discipline} = await readBody(event)

    console.log('userId, discipline', userId, discipline)

    const now = new Date()
    const startOfToday = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate()))
    const startOfTomorrow = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() + 1))

    const workout = await prisma.workout.findFirst({
        where: {
            userId,
            discipline,
            date: {
                gte: startOfToday,
                lt: startOfTomorrow,
            },
        }
    })

    return workout
})
