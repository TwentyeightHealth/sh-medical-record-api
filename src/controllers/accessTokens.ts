import clientCtrl from './clients';
import otpGenerator from 'otp-generator';
import type { Request, Response } from 'express';

async function handleIncomingRequests(req: Request, res: Response) {
  const { client_id: clientId, client_secret: clientSecret } = req.body;

  // Check that the clientId and clientSecret were sent
  if (clientId === undefined || clientSecret === undefined) {
    const errors = [];

    if (clientId === undefined) {
      errors.push({
        key: 'client_id',
        message: 'is missing'
      });
    }

    if (clientSecret === undefined) {
      errors.push({
        key: 'client_secret',
        message: 'is missing'
      });
    }

    return res.status(400).json({
      statusCode: 400,
      error: 'Bad Request',
      errors
    });
  }

  // Verify that the clientId and clientSecret are correct
  const isAuthenticated = await clientCtrl.isAuthenticated({ clientId, clientSecret });

  if (!isAuthenticated) {
    return res.status(401).json({ statusCode: 401, error: 'Unauthorized' });
  }

  // If authenticated, grant an accessToken
  const accessToken = otpGenerator.generate(10, { specialChars: false });
  const now = new Date();
  // Token is good for 24 hours
  const expiration = now.getTime() + 24 * 60 * 60 * 1000;

  // TODO: where do we save the accessToken?

  return res.status(200).json({ statusCode: 200, accessToken, expiration });
}

export default {
  handleIncomingRequests
};
