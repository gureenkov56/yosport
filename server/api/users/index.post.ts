import { prisma } from "~/prisma"
import { createError, sendError } from 'h3'


export default defineEventHandler(async (event) => {
  const {name, RecordDips, RecordPullUps} = await readBody(event)


  if (!name) {
    return sendError(event, createError({ statusCode: 400, message: 'Введите имя' }))
  }

  const isUserExist = await prisma.user.findFirst({ where: { name } })

  if (isUserExist) {

    return sendError(event, createError({ statusCode: 409, message: 'Пользователь с таким именем уже существует' }))

  }

  const newUser = await prisma.user.create({data: {name, RecordDips, RecordPullUps}})

  setCookie(event, 'userId', `${newUser.id}`)

  return {success: true, ...newUser}
})
