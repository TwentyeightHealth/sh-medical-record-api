let paymentType = 'INSURANCE' as const;

export const createPatientPayload = {
  externalPatientId: 'sdf3434',
  firstName: 'Mock',
  lastName: 'Patient',
  dateOfBirth: new Date('1997-08-12'),
  stateCode: 'NY',
  email: 'mock_patient@gmail.com',
  phone: '(209) 332-4466',
  addressLine1: '344 McKinley Avenue',
  addressLine2: null,
  city: 'New York',
  state: 'NY',
  postalCode: '10010',
  paymentType,
  dateOfConsent: new Date('2023-05-22'),
  truepillPatientToken: 'truepillPatientToken534534',
  stripeCustomerId: 'stripe_mock_445'
};
