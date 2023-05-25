import express from 'express';
import accessTokenCtrl from './../controllers/accessTokens';

// Create router
const router = express.Router();

router.post('/', accessTokenCtrl.handleIncomingRequests);

// Export router
export default router;
