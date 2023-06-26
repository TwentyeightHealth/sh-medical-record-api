import express from 'express';
import userCtrl from './../controllers/users';

// Create router
const router = express.Router();

router.post('/', userCtrl.handleIncomingRequests);

// Export router
export default router;
