// Import dependencies
import express from 'express';
import bodyParser from 'body-parser';
import compression from 'compression';
import cors from 'cors';
import helmet from 'helmet';
import type { NextFunction as Next, Request, Response } from 'express';

// Import routes
import accessTokenRouter from './routes/accessToken';
import medicalRecordsRouter from './routes/medicalRecords';

// Set default port for express app
const PORT = process.env.PORT || 7000;

// Create express app
export const app = express();

// Apply middleware
// Note: Keep this at the top, above routes
app.use(cors());
app.use(helmet());
app.use(compression());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Implement routes
app.use('/access-token', accessTokenRouter);
app.use('/medical-records', medicalRecordsRouter);

// Implement 500 error route
app.use(function (req: Request, res: Response, next: Next) {
  res.status(500).send('Something is broken.');
});

// Implement 404 error route
app.use(function (req, res, next) {
  res.status(404).send('Sorry we could not find that.');
});

// Start express app
app.listen(PORT, function () {
  console.log(`Server is running on: ${PORT}`);
});
