import { PrismaClient, Patient, Prisma } from '@prisma/client';

const prisma = new PrismaClient();

enum SexType {
  MALE,
  FEMALE,
  INTERSEX
}

async function createPatient(payload: Prisma.PatientCreateInput): Promise<Patient> {
  const existingPatient = await getByEmailAndDob({ email: payload.email, dob: new Date(payload.dateOfBirth) });

  if (existingPatient) {
    return existingPatient;
  }

  const patient = prisma.patient.create({
    data: payload
  });

  return patient;
}

async function getByEmailAndDob({ email, dob }: { email: string; dob: Date }): Promise<Patient | null> {
  return prisma.patient.findUnique({
    where: {
      email_dateOfBirth: {
        email,
        dateOfBirth: dob
      }
    }
  });
}

export default {
  createPatient,
  getByEmailAndDob
};
