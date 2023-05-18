import { PrismaClient, Prescription } from '@prisma/client';

const prisma = new PrismaClient();

const prescription = prisma.prescription.findMany();

console.log('prescription', prescription);
