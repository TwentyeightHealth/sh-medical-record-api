import express from 'express';
import medicalRecordCtrl from './../controllers/medicalRecords';

// Create router
const router = express.Router();

router.post('/', medicalRecordCtrl.handleIncomingRequests);

// Export router
export default router;
