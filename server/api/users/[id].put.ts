import { prisma } from "~/prisma"

export default defineEventHandler(async (event) => {
  const id = parseInt(event.context.params!.id)
  const body = await readBody(event)

  return await prisma.user.update({
    where: { id },
    data: {
      name: body.name,
    }
  })
})
