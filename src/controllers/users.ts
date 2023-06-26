import { cache } from '../app';
import { PrismaClient, User } from '@prisma/client';
import type { Request, Response } from 'express';

const prisma = new PrismaClient();

/*
 * TODO: explain this function
 */
async function handleIncomingRequests(req: Request, res: Response) {
  const auth = req.headers.authorization;
  const accessToken = auth?.split(' ');
  const tokenValue = accessToken?.length === 2 ? accessToken[1] : undefined;

  if (tokenValue === undefined) {
    return res.status(401).json({
      status: 'error',
      statusCode: 401,
      error: 'Access Token required'
    });
  }

  const tokenExists = cache.get(tokenValue);

  if (!tokenExists) {
    return res.status(401).json({
      status: 'error',
      statusCode: 401,
      error: 'Access Token not found, please generate a new one'
    });
  }

  const email = req.body.email;

  if (!email) {
    return res.status(400).json({
      status: 'error',
      statusCode: 400,
      error: 'Email is missing from the request body'
    });
  }

  const user = await getUser(email);

  console.log('user', user);

  if (user === null) {
    return res.status(404).json({
      status: 'error',
      statusCode: 404,
      error: 'User not found'
    });
  }

  return res.status(200).json({
    status: 'success',
    statusCode: 200,
    user
  });
}

async function getUser(email: string): Promise<User | null> {
  const user = await prisma.user.findUnique({
    where: {
      email
    }
  });

  return user;
}

export default { handleIncomingRequests };
