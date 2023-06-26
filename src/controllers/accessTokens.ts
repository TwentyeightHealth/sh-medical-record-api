import { cache } from '../app';
import clientCtrl from './clients';
import otpGenerator from 'otp-generator';
import type { Request, Response } from 'express';

async function handleIncomingRequests(req: Request, res: Response) {
  const { client_id: clientId, client_secret: clientSecret } = req.body;
  // Check that the clientId and clientSecret were sent
  if (clientId === undefined || clientSecret === undefined) {
    const errorDetails = [];

    if (clientId === undefined) {
      errorDetails.push({
        key: 'client_id',
        message: 'is missing'
      });
    }

    if (clientSecret === undefined) {
      errorDetails.push({
        key: 'client_secret',
        message: 'is missing'
      });
    }

    return res.status(400).json({
      status: 'error',
      statusCode: 400,
      error: 'Bad Request',
      errorDetails
    });
  }

  // Verify that the clientId and clientSecret are correct
  const isAuthenticated = await clientCtrl.isAuthenticated({ clientId, clientSecret });

  if (!isAuthenticated) {
    return res.status(401).json({ status: 'error', statusCode: 401, error: 'Unauthorized' });
  }

  const { accessToken, expiration } = await generateAccessToken();

  return res.status(200).json({ status: 'success', statusCode: 200, accessToken, expiration });
}

async function generateAccessToken(): Promise<{ accessToken: string; expiration: number }> {
  // If authenticated, grant an accessToken
  const accessToken = otpGenerator.generate(10, { specialChars: false });
  const now = new Date();

  // Tell the user the expiration time in milliseconds
  const expiration = now.getTime() + 86400 * 1000;

  // Save the accessToken in the node-cache for 24 hours
  await cache.set(accessToken, true, 86400);

  return { accessToken, expiration };
}

function getAccessTokenStatus(auth: string): string {
  const accessToken = auth?.split(' ');
  const tokenValue = accessToken?.length === 2 ? accessToken[1] : undefined;

  if (tokenValue === undefined) {
    return 'MISSING_FROM_AUTH';
  }

  const tokenExists = cache.get(tokenValue);

  if (!tokenExists) {
    return 'MISSING_FROM_CACHE';
  }

  return 'VERIFIED';
}

export default {
  generateAccessToken,
  handleIncomingRequests,
  getAccessTokenStatus
};
