import { cache } from '../app';
import { PrismaClient, User } from '@prisma/client';
import type { Request, Response } from 'express';

const prisma = new PrismaClient();

interface VerificationResults {
  statusCode?: number; 
  error: string | null; 
}

/*
 * Verifies that the access token is in the stored cache 
 */
function verifyAccessToken(req: Request): VerificationResults {
  const auth = req.headers.authorization;
  const accessToken = auth?.split(' ');
  const tokenValue = accessToken?.length === 2 ? accessToken[1] : undefined;

  if (tokenValue === undefined) {
    return {
      statusCode: 401,
      error: 'Access Token required'
    };
  }

  const tokenExists = cache.get(tokenValue);

  if (!tokenExists) {
    return {
      statusCode: 401,
      error: 'Access Token not found, please generate a new one'
    };
  }

  // Access token is valid 
  return {
    error: null 
  }; 
}

/*
 * Handles incoming requests to the /get-user route 
 */
async function handleGetUserRequest(req: Request, res: Response) {
  const verificationResults = verifyAccessToken(req);
  
  if (verificationResults.error) {
    const statusCode = verificationResults.statusCode ?? 500; 

    return res.status(statusCode).json({ 
      status: 'error', 
      statusCode, 
      error: verificationResults.error, 
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

/*
 * Handles incoming requests to the /get-all route 
 */
async function handleGetAllUsersRequest(req: Request, res: Response) {
  const verificationResults = verifyAccessToken(req);
  
  if (verificationResults.error) {
    const statusCode = verificationResults.statusCode ?? 500; 

    return res.status(statusCode).json({ 
      status: 'error', 
      statusCode, 
      error: verificationResults.error, 
    });
  }

  const users = await getAllUsers(); 

  return res.status(200).json({
    status: 'success',
    statusCode: 200,
    users
  });
}

async function getAllUsers(): Promise<User[]> {
  return prisma.user.findMany(); 
}

async function getUser(email: string): Promise<User | null> {
  const user = await prisma.user.findUnique({
    where: {
      email
    }
  });

  return user;
}

export default { handleGetUserRequest, handleGetAllUsersRequest };
