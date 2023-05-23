import { PrismaClient, InsurancePolicy } from '@prisma/client';

const prisma = new PrismaClient();

async function getByPatientId(patientId: number): Promise<InsurancePolicy[]> {
  return prisma.insurancePolicy.findMany({ where: { patientId } });
}

export default { getByPatientId };
