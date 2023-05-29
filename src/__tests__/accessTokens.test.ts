import { app } from '../app';
import { hashText } from '../lib/crypto';
import { createPatientPayload } from './mocks';
import supertest from 'supertest';
import clientCtrl from '../controllers/clients';

describe('access tokens', () => {
  describe('access tokens', () => {
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
});
