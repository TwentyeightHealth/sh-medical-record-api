import regex from '../lib/regex';
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
      error: verificationResults.error
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
      error: verificationResults.error
    });
  }

  const users = await getAllUsers();

  return res.status(200).json({
    status: 'success',
    statusCode: 200,
    users
  });
}

/*
 * Handles incoming requests to the /add-user route
 */
async function handleAddUserRequest(req: Request, res: Response) {
  const verificationResults = verifyAccessToken(req);

  if (verificationResults.error) {
    const statusCode = verificationResults.statusCode ?? 500;

    return res.status(statusCode).json({
      status: 'error',
      statusCode,
      error: verificationResults.error
    });
  }

  const { email, role } = req.body;

  // Make sure we have all the input needed
  const validationErrors = await validateAddUserInput({
    email,
    role
  });

  if (validationErrors.length) {
    return res.status(400).json({
      status: 'error',
      statusCode: 400,
      error: 'Bad Request',
      errorDetails: validationErrors
    });
  }

  await addUser({ email, role });

  return res.status(200).json({
    status: 'success',
    statusCode: 200,
  });
}

/*
 * Check that email and dob are present, and confirm that their
 * formats are valid
 */
async function validateAddUserInput({
  email,
  role
}: {
  email: string | void;
  role: string | void;
}): Promise<{ key: string; message: string }[]> {
  const validationErrors = [];

  // Validate email
  if (email === undefined) {
    validationErrors.push({
      key: 'email',
      message: 'is missing'
    });
  } else if (!regex.emailFormat.test(email)) {
    // Validate email format
    validationErrors.push({
      key: 'email',
      message: `Email is not in a valid format: ${email}`
    });
  }

  // Validate dob
  if (role === undefined) {
    validationErrors.push({
      key: 'role',
      message: 'is missing'
    });
  }

  return validationErrors;
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

async function addUser({ email, role }: { email: string, role: string }): Promise<User | null> {
  const user = await prisma.user.create({
    data: {
      email,
      // I know this is redundant, it's here for Typescript
      role: role === 'USER' ? 'USER': 'ADMIN'
    }
  });

  return user; 
}

export default { handleAddUserRequest, handleGetUserRequest, handleGetAllUsersRequest };
