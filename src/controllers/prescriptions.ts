import { PrismaClient, Prescription } from '@prisma/client';

const prisma = new PrismaClient();

async function getByPatientId(patientId: number): Promise<Prescription[]> {
  return prisma.prescription.findMany({ where: { patientId } });
}

export default { getByPatientId };
