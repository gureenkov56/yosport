import { prisma } from "~/prisma"

export default defineEventHandler(async () => {
  return prisma.user.findMany()
})
