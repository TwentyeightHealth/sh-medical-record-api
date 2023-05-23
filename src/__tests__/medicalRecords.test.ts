import { app } from '../app';
import { createPatientPayload } from './mocks';
import supertest from 'supertest';
import patientCtrl from '../controllers/patients';

describe('medical records', () => {
  describe('get medical records route', () => {
    describe('given the patient does not exist', () => {
      it('should return a 404', async () => {
        await supertest(app)
          .post(`/medical-records`)
          .send({ dob: '1987-08-22', email: 'nonexistent_patient@gmail.com' })
          .expect(404);
      });
    });

    describe('given the patient does exist', () => {
      it('should return a json body and a 200', async () => {
        await patientCtrl.createPatient(createPatientPayload);

        await supertest(app)
          .post(`/medical-records`)
          .send({ dob: '1997-08-12', email: 'mock_patient@gmail.com' })
          .set('Accept', 'application/json')
          .expect('Content-Type', /json/)
          .expect(200);
      });
    });
  });
});
