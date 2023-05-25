import otpGenerator from 'otp-generator';
import { hashText } from '../lib/crypto';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

function generateClientIdAndSecret(): { id: string; secret: string } {
  const id = otpGenerator.generate(12, { specialChars: false, lowerCaseAlphabets: false, upperCaseAlphabets: false });
  const secret = otpGenerator.generate(24, { specialChars: false });

  return { id, secret };
}

async function isAuthenticated({
  clientId,
  clientSecret
}: {
  clientId: string;
  clientSecret: string;
}): Promise<boolean> {
  const client = await prisma.client.findUnique({
    where: {
      id: clientId
    }
  });

  if (!client) {
    return false;
  }

  const { secret } = client;

  const hashedIncomingSecret = hashText(clientSecret);

  if (hashedIncomingSecret !== secret) {
    return false;
  }

  return true;
}

export default {
  generateClientIdAndSecret,
  isAuthenticated
};
