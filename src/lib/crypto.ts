import crypto from 'crypto';

// Generate a secret key for encryption and decryption.
const secretKey = crypto.randomBytes(32);

// Generate an initialization vector
const iv = crypto.randomBytes(16);

export function encrypt(text: string): string {
  // Create cipher object
  const cipher = crypto.createCipheriv('aes-256-cbc', secretKey, iv);

  // Encrypt the data
  let encryptedText = cipher.update(text, 'utf-8', 'hex');

  // Finalize the encryption
  encryptedText += cipher.final('hex');

  return encryptedText;
}

export function decrypt(encryptedText: string): string {
  const decipher = crypto.createDecipheriv('aes-256-cbc', secretKey, iv);

  // Decrypt the data
  let decryptedText = decipher.update(encryptedText, 'hex', 'utf-8');

  // Finalize the decryption
  decryptedText += decipher.final('utf-8');

  return decryptedText;
}

