import { PrismaClient, Patient } from '@prisma/client';

const prisma = new PrismaClient();

const patient = prisma.patient.findMany();

console.log('patient', patient);
