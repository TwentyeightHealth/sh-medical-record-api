import { PrismaClient, Patient } from '@prisma/client';

const prisma = new PrismaClient();

const patient = prisma.patient.findMany();

async function getByEmailAndDob({
  email,
  dob,
}: {
  email: string;
  dob: string;
}): Promise<Patient | null> {
  return prisma.patient.findUnique({
    where: {
      email_dateOfBirth: {
        email,
        dateOfBirth: new Date(dob),
      },
    },
  });
}

export default {
  getByEmailAndDob,
};
