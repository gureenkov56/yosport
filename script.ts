import { PrismaClient } from './generated/prisma'

const prisma = new PrismaClient()

// npx tsx script.ts

const users = [
    {
        name: 'Pit',
    },
    {
        name: 'John',
    }
]

const records = [
    {
        userId: 1,
        pullUps: 22
    }
]

async function createMockData() {
    const user = await prisma.user.createMany({data: users})
    const record = await prisma.records.createMany({data: records})
    console.log(user, record)
}

createMockData()
    .then(async () => {
        await prisma.$disconnect()
    })
    .catch(async (e) => {
        console.error(e)
        await prisma.$disconnect()
        process.exit(1)
    })