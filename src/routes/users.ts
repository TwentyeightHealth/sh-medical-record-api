import express from 'express';
import userCtrl from './../controllers/users';

// Create router
const router = express.Router();

router.post('/get-user', userCtrl.handleGetUserRequest);
router.post('/get-all', userCtrl.handleGetAllUsersRequest);
router.post('/add-user', userCtrl.handleAddUserRequest);

// Export router
export default router;
