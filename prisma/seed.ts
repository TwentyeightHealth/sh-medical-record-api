import clientCtrl from '../src/controllers/clients';
import { hashText } from '../src/lib/crypto';

import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  const alice = await prisma.patient.upsert({
    where: { email: 'alice@gmail.com' },
    update: {},
    create: {
      externalPatientId: '12345',
      firstName: 'Alice',
      lastName: 'Liddell',
      sex: 'FEMALE',
      dateOfBirth: '1988-09-30',
      stateCode: 'CA',
      email: 'alice@gmail.com',
      phone: '(209) 777-4547',
      addressLine1: '123 Main Street',
      addressLine2: null,
      city: 'Merced',
      state: 'CA',
      postalCode: '95348',
      paymentType: 'CASH',
      dateOfConsent: new Date('2020-08-30'),
      truepillPatientToken: 'truepillPatientToken123',
      stripeCustomerId: 'stripe_123',
      prescriptions: {
        create: {
          prescriberCompany: 'MedLife',
          prescriberAddressLine1: '333 J Street',
          prescriberAddressLine2: null,
          prescriberCity: 'San Francisco',
          prescriberState: 'CA',
          prescriberPostalCode: '95443',
          prescriberPhone: '(415) 333-8899',
          prescriberLicenseNumber: '3sd34dds',
          prescriberSignature: 'M Dawson',
          deaNumber: '3dkf3f',
          npi: '3223425',
          rxSignature: '1$23409dfu0902945323094234',
          dateWritten: new Date(),
          ndc: '0645345245',
          medication: 'Sprintec',
          quantity: 4,
          unit: 'Pack(s)',
          sig: 'One at a time',
          indication: 'some indication',
          refills: 4,
          daw: true,
          truepillRxToken: 'truepillRxToken23234'
        }
      },
      insurances: {
        create: {
          memberName: 'Alice Liddel',
          memberId: '122132342345GHGK',
          planName: 'Aetna',
          rxGroup: 'WSG',
          rxBin: '009214',
          pcn: 'IS',
          isMedicaid: false
        }
      },
      consultations: {
        create: {
          abdominalOrPelvicSurgeries: null,
          alcoholUsage: 'NEVER',
          allergies: true,
          allergiesNote: 'Peanuts',
          averageMenstrualCycle: 'VARIES',
          bloating: false,
          bloodClots: null,
          bloodClotsNote: null,
          bloodPressure: '100-139/60-89',
          breastPainBeforePeriod: null,
          cervicalDysplasiaOrAbnormalPaps: null,
          coldSoresFrequency: null,
          consentToTelehealth: 'Agree',
          currentBirthControl: null,
          currentBirthControlNote: null,
          currentColdSoresOutbreak: null,
          currentGenitalHerpesOutbreak: null,
          decreasedLibido: null,
          diabetes: false,
          diabetesNote: null,
          difficultySleeping: false,
          drospirenoneWaiver: null,
          endometriosis: null,
          excessHairGrowth: null,
          fibroids: null,
          genitalHerpesFrequency: null,
          givenBirth: true,
          hadPeriodInPastYear: true,
          hairLoss: null,
          height: 68,
          highBloodPressure: false,
          highBloodPressureNote: null,
          highProlactinLevel: null,
          hivOrAids: null,
          hotFlashesOrNightSweats: null,
          irritabilityAnxietyDepressionOrWorseningPMS: null,
          isBreastfeeding: false,
          isGenericOk: false,
          liverConditions: null,
          liverConditionsNote: null,
          loseBalanceOrTripEasily: null,
          medications: null,
          medicationsNote: null,
          menstrualCycleDetails: null,
          migraines: false,
          monthlyMenstrualCycles: true,
          otherConditions: false,
          otherConditionsNote: null,
          ovarianCysts: null,
          painBowelMovements: null,
          painDeepPenetrativeSex: null,
          painPelvic: null,
          patchesOfThickenedDarkenedSkin: null,
          periodPreference: 'MONTHLY',
          polycysticOvarianSyndrome: null,
          pregnant: false,
          previousBirthControlPart1: false,
          previousBirthControlPart2: null,
          previousBirthControlPart2Note: null,
          previouslyDiagnosedColdSores: null,
          previouslyDiagnosedGenitalHerpes: null,
          primaryReason: null,
          progestinOnlyPillQuestions: null,
          questionsForDoctor: null,
          questionsForDoctorNote: null,
          recentVaricellaOrZosterVaccination: null,
          regularMenstrualCycles: true,
          rheumatologicOrAutoimmuneDisorder: null,
          severeAcne: null,
          severeMenstrualCramping: null,
          sexuallyTransmittedInfection: null,
          sideEffectConcerns: null,
          sideEffectConcernsNote: null,
          stateCode: 'CA',
          supplements: null,
          surgeries: null,
          surgeriesNote: null,
          thyroidDisorder: true,
          tobacco: null,
          tobaccoNote: null,
          tobaccoUsage: null,
          usingHormonalBirthControl: null,
          uterinePolyps: null,
          vaginalDrynessOrPainWithSex: null,
          weight: 130,
          weightGain: false
        }
      }
    }
  });

  const megan = await prisma.user.upsert({
    where: { email: 'meg.eli.smi@gmail.com' },
    update: {},
    create: {
      email: 'meg.eli.smi@gmail.com',
      role: 'ADMIN'
    }
  });

  const { id, secret } = clientCtrl.generateClientIdAndSecret();
  console.log('id', id, 'secret', secret);
  const hashedSecret = hashText(secret);

  const client = await prisma.client.create({
    data: {
      id,
      secret: hashedSecret
    }
  });

  console.log({ alice, megan, client });
}
main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async e => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
