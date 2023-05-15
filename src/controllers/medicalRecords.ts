// Get the medical record by email and dob
async function getMedicalRecordsByEmailAndDob(req, res) {
  console.log('request received!', req.body);

  return res.json({});
}

export default {
  getMedicalRecordsByEmailAndDob,
};
