import { PrismaClient, Consultation } from '@prisma/client';

const prisma = new PrismaClient();

async function getByPatientId(patientId: number): Promise<Consultation[]> {
    return prisma.consultation.findMany({ where: { patientId } });
}

export default { getByPatientId }