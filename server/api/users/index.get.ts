import { prisma } from "~/prisma"

export default defineEventHandler(async () => {
  return await prisma.user.findMany()
})
