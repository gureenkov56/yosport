import { prisma } from "~/prisma"


export default defineEventHandler(async (event) => {
  // todo
  const body = await readBody(event)

  console.log('body', body);

  const users = await prisma.user.findFirst({ where: { name: body.name } })

  return users
})
