import { PrismaClient } from './generated/prisma'

const prisma = new PrismaClient()

async function main() {
    const user = await prisma.user.createMany({
        data: [
            {
                name: 'Pit',
                email: 'pit@prisma.io',
            },
            {
                name: 'John',
                email: 'john@prisma.io',
            }
        ],
    })
    console.log(user)
}

main()
    .then(async () => {
        await prisma.$disconnect()
    })
    .catch(async (e) => {
        console.error(e)
        await prisma.$disconnect()
        process.exit(1)
    })