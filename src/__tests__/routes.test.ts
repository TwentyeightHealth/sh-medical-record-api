import { app } from '../app';
import { createPatientPayload } from './mocks';
import accessTokenCtrl from '../controllers/accessTokens';
import supertest from 'supertest';
import clientCtrl from '../controllers/clients';
import patientCtrl from '../controllers/patients';

describe('medical records route', () => {
  describe('given the access token is not valid', () => {
    it('should return a 401', async () => {
      const { accessToken } = await accessTokenCtrl.generateAccessToken();

      await supertest(app)
        .post(`/medical-records`)
        .set('authorization', `AccessToken some_access_token`)
        .send({ dob: '1987-08-22', email: 'nonexistent_patient@gmail.com' })
        .expect(401);
    });
  });

  describe('given the patient does not exist', () => {
    it('should return a 404', async () => {
      const { accessToken } = await accessTokenCtrl.generateAccessToken();

      await supertest(app)
        .post(`/medical-records`)
        .set('authorization', `AccessToken ${accessToken}`)
        .send({ dob: '1987-08-22', email: 'nonexistent_patient@gmail.com' })
        .expect(404);
    });
  });

  describe('given the patient does exist', () => {
    it('should return a json body and a 200', async () => {
      const { accessToken } = await accessTokenCtrl.generateAccessToken();

      await patientCtrl.createPatient(createPatientPayload);

      await supertest(app)
        .post(`/medical-records`)
        .set('authorization', `AccessToken ${accessToken}`)
        .send({ dob: '1997-08-12', email: 'mock_patient@gmail.com' })
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200);
    });
  });
});

describe('given email is not provided', () => {
  it('should return a 400', async () => {
    const { accessToken } = await accessTokenCtrl.generateAccessToken();

    await supertest(app)
      .post(`/medical-records`)
      .set('authorization', `AccessToken ${accessToken}`)
      .send({ dob: '1997-08-12' })
      .expect(400);
  });
});

describe('given dob is not provided', () => {
  it('should return a 400', async () => {
    const { accessToken } = await accessTokenCtrl.generateAccessToken();

    await supertest(app)
      .post(`/medical-records`)
      .set('authorization', `AccessToken ${accessToken}`)
      .send({ email: 'mock_patient@gmail.com' })
      .expect(400);
  });
});

describe('given email is not a real email', () => {
  it('should return a 400', async () => {
    const { accessToken } = await accessTokenCtrl.generateAccessToken();

    await supertest(app)
      .post(`/medical-records`)
      .set('authorization', `AccessToken ${accessToken}`)
      .send({ email: 'this_is_not_an_email', dob: '1997-08-12' })
      .expect(400);
  });
});

describe('dob is not in YYYY-MM-DD format', () => {
  it('should return a 400', async () => {
    const { accessToken } = await accessTokenCtrl.generateAccessToken();

    await supertest(app)
      .post(`/medical-records`)
      .set('authorization', `AccessToken ${accessToken}`)
      .send({ email: 'mock_patient@gmail.com', dob: '08-12-1997' })
      .expect(400);
  });
});

describe('access token route', () => {
  describe('given the client does not exist', () => {
    it('should return a 401', async () => {
      await supertest(app)
        .post(`/access-token`)
        .send({ client_id: 'some_fake_id', client_secret: 'some_fake_secret' })
        .expect(401);
    });
  });

  describe('given the patient does exist', () => {
    it('should return a json body and a 200', async () => {
      const { id, secret } = clientCtrl.generateClientIdAndSecret();

      await clientCtrl.create({
        id,
        secret
      });

      await supertest(app)
        .post(`/access-token`)
        .send({ client_id: id, client_secret: secret })
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200);
    });
  });
});

describe('given client_id is not provided', () => {
  it('should return a 400', async () => {
    await supertest(app).post(`/access-token`).send({ client_secret: 'some_secret' }).expect(400);
  });
});

describe('given client_secret is not provided', () => {
  it('should return a 400', async () => {
    await supertest(app).post(`/access-token`).send({ client_id: 'some_id' }).expect(400);
  });
});
