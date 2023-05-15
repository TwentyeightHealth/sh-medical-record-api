import express from 'express';
import medicalRecordCtrl from './../controllers/medicalRecords.ts';

// Create router
const router = express.Router();

router.post('/', medicalRecordCtrl.getMedicalRecordsByEmailAndDob);

// Export router
export default router;
