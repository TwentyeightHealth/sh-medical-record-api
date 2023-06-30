import { cache } from '../app';
import consultationCtrl from './consultations';
import insuranceCtrl from './insurances';
import patientCtrl from './patients';
import prescriptionCtrl from './prescriptions';
import regex from '../lib/regex';
import type { Request, Response } from 'express';

/*
 * Check that email and dob are present and confirm that their
 * formats are valid
 */
async function validateMedicalRecordInput({
  email,
  dob
}: {
  email: string | void;
  dob: string | void;
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
  if (dob === undefined) {
    validationErrors.push({
      key: 'dob',
      message: 'is missing'
    });
  } else if (!regex.yyyymmddFormat.test(dob)) {
    // Validate dob is YYYY-MM-DD
    validationErrors.push({
      key: 'dob',
      message: `Expected YYYY-MM-DD format, but got ${dob.toString()}`
    });
  }

  return validationErrors;
}

/*
 * This function:
 *   - authenticates the request by searching for the access token in node-cache
 *   - validates email and dob
 *   - returns the medical record for the patient
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

  const { email, dob } = req.body;

  // Make sure we have all the input needed
  const validationErrors = await validateMedicalRecordInput({
    email,
    dob
  });

  if (validationErrors.length) {
    return res.status(400).json({
      status: 'error',
      statusCode: 400,
      error: 'Bad Request',
      errorDetails: validationErrors
    });
  }

  return getMedicalRecordsByEmailAndDob({ email, dob, res });
}

// Get the medical record by email and dob
async function getMedicalRecordsByEmailAndDob({ email, dob, res }: { email: string; dob: string; res: Response }) {
  const patient = await patientCtrl.getByEmailAndDob({
    email,
    dob
  });

  if (patient === null) {
    return res.status(404).json({ status: 'error', statusCode: 404, error: 'Patient not found.' });
  }

  // TODO: Should we take out internal id?
  const prescriptions = await prescriptionCtrl.getByPatientId(patient.id);
  const consultations = await consultationCtrl.getByPatientId(patient.id);
  const insurancePolicies = await insuranceCtrl.getByPatientId(patient.id);

  const results = { ...patient, prescriptions, consultations, insurancePolicies };

  return res.json({ status: 'success', statusCode: 200, patient: results });
}

export default {
  getMedicalRecordsByEmailAndDob,
  handleIncomingRequests
};
