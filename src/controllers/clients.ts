import crypto from 'crypto';
import otpGenerator from 'otp-generator';

function generateClientIdAndSecret(): { id: string; secret: string } {
  const id = otpGenerator.generate(12, { specialChars: false, lowerCaseAlphabets: false, upperCaseAlphabets: false });
  const secret = otpGenerator.generate(24, { specialChars: false });

  return { id, secret };
}

export default {
  generateClientIdAndSecret
};
