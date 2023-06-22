# SH Medical Records API

An API that gives access to medical records that belong SimpleHealth patients. These medical records include consultation data, doctor and patient messages, prescriptions issued, and any insurance policies.

## Usage

### Client ids and client secrets

In order to access medical records for a patient, you must have a client id and client secret. You can obtain a client id and client secret by [instructions here].

### Access Tokens

Once you have a client id and client secret, you can get an access token that is valid for 24 hours.

```
fetch('<base_url>/access-token', {
  method: 'POST',
  body: {
    "client_id": "some_client_id",
    "client_secret": "some_client_secret"
  }
})
```

**API Response When Client Id or Client Secret is Valid**

```
{
    "status": "success",
    "statusCode": 200,
    "accessToken": "4ZwT1bvUTP",
    "expiration": 1685658349356
}
```

**API Response When Client Id or Client Secret is Invalid**

```
{
    "status": "error",
    "statusCode": 401,
    "error": "Unauthorized"
}
```

**API Response When Client Id or Client Secret is Missing**

```
{
    "status": "error",
    "statusCode": 400,
    "error": "Bad Request",
    "errors": [
        {
            "key": "client_id",
            "message": "is missing"
        },
        {
            "key": "client_secret",
            "message": "is missing"
        }
    ]
}
```

### Medical Records

Once an access token is granted, you can use it to obtain patient medical records.

```
fetch('<base_url>/medical-records', {
  method: 'POST',
  headers: {
    Authorization: 'AccessToken [YOUR ACCESS TOKEN]',
    'Content-Type': 'application/json'
  },
  body: {
    "email": "alice@gmail.com",
    "dob": "1988-09-30" // YYYY-MM-DD format
  }
})
```

**API Response When Access Token is Valid**

```
{
    "status": "success",
    "statusCode": 200,
    "patient": {
        "id": 1,
        "externalPatientId": "12345",
        "firstName": "Alice",
        "lastName": "Liddell",
        "sex": "FEMALE",
        "dateOfBirth": "1988-09-30T00:00:00.000Z",
        "stateCode": "CA",
        "email": "alice@gmail.com",
        "phone": "(209) 777-4547",
        "addressLine1": "123 Main Street",
        "addressLine2": null,
        "city": "Merced",
        "state": "CA",
        "postalCode": "95348",
        "paymentType": "CASH",
        "dateOfConsent": "2020-08-30T00:00:00.000Z",
        "truepillPatientToken": "truepillPatientToken123",
        "stripeCustomerId": "stripe_123",
        "prescriptions": [
            {
                "id": 1,
                "prescriberCompany": "MedLife",
                "prescriberAddressLine1": "333 J Street",
                "prescriberAddressLine2": null,
                "prescriberCity": "San Francisco",
                "prescriberState": "CA",
                "prescriberPostalCode": "95443",
                "prescriberPhone": "(415) 333-8899",
                "prescriberLicenseNumber": "3sd34dds",
                "prescriberSignature": "M Dawson",
                "deaNumber": "3dkf3f",
                "npi": "3223425",
                "rxSignature": "1$23409dfu0902945323094234",
                "dateWritten": "2023-05-25T22:36:38.550Z",
                "ndc": "0645345245",
                "medication": "Sprintec",
                "quantity": 4,
                "unit": "Pack(s)",
                "sig": "One at a time",
                "indication": "some indication",
                "refills": 4,
                "daw": true,
                "truepillRxToken": "truepillRxToken23234",
                "patientId": 1
            }
        ],
        "consultations": [
            {
                "id": 1,
                "abdominalOrPelvicSurgeries": null,
                "alcoholUsage": "NEVER",
                "allergies": true,
                "allergiesNote": "Peanuts",
                "averageMenstrualCycle": "VARIES",
                "bloating": false,
                "bloodClots": null,
                "bloodClotsNote": null,
                "bloodPressure": "100-139/60-89",
                "breastPainBeforePeriod": null,
                "cervicalDysplasiaOrAbnormalPaps": null,
                "coldSoresFrequency": null,
                "consentToTelehealth": "Agree",
                "currentBirthControl": null,
                "currentBirthControlNote": null,
                "currentColdSoresOutbreak": null,
                "currentGenitalHerpesOutbreak": null,
                "decreasedLibido": null,
                "diabetes": false,
                "diabetesNote": null,
                "difficultySleeping": false,
                "drospirenoneWaiver": null,
                "endometriosis": null,
                "excessHairGrowth": null,
                "exerciseFrequency": null,
                "fibroids": null,
                "genitalHerpesFrequency": null,
                "givenBirth": true,
                "hadPeriodInPastYear": true,
                "hairLoss": null,
                "heartConditions": null,
                "heartConditionsNote": null,
                "height": "68",
                "herpesConsultConditions": null,
                "herpesConsultMedications": null,
                "highBloodPressure": false,
                "highBloodPressureNote": null,
                "highProlactinLevel": null,
                "hivOrAids": null,
                "hotFlashesOrNightSweats": null,
                "irritabilityAnxietyDepressionOrWorseningPMS": null,
                "isBreastfeeding": false,
                "isGenericOk": false,
                "liverConditions": null,
                "liverConditionsNote": null,
                "loseBalanceOrTripEasily": null,
                "medications": null,
                "medicationsNote": null,
                "menstrualCycleDetails": null,
                "migraines": false,
                "monthlyMenstrualCycles": true,
                "otherConditions": false,
                "otherConditionsNote": null,
                "ovarianCysts": null,
                "painBowelMovements": null,
                "painDeepPenetrativeSex": null,
                "painPelvic": null,
                "patchesOfThickenedDarkenedSkin": null,
                "periodPreference": "MONTHLY",
                "polycysticOvarianSyndrome": null,
                "pregnant": false,
                "previousBirthControlPart1": false,
                "previousBirthControlPart2": null,
                "previousBirthControlPart2Note": null,
                "previouslyDiagnosedColdSores": null,
                "previouslyDiagnosedGenitalHerpes": null,
                "primaryReason": null,
                "progestinOnlyPillQuestions": null,
                "questionsForDoctor": null,
                "questionsForDoctorNote": null,
                "recentVaricellaOrZosterVaccination": null,
                "regularMenstrualCycles": true,
                "rheumatologicOrAutoimmuneDisorder": null,
                "severeAcne": null,
                "severeMenstrualCramping": null,
                "sexuallyTransmittedInfection": null,
                "sideEffectConcerns": null,
                "sideEffectConcernsNote": null,
                "stateCode": "CA",
                "supplements": null,
                "surgeries": null,
                "surgeriesNote": null,
                "thyroidDisorder": true,
                "tobacco": null,
                "tobaccoNote": null,
                "tobaccoUsage": null,
                "usingHormonalBirthControl": null,
                "uterinePolyps": null,
                "vaginalDrynessOrPainWithSex": null,
                "weight": "130",
                "weightGain": false,
                "patientId": 1
            }
        ],
        "insurancePolicies": [
            {
                "id": 1,
                "memberName": "Alice Liddel",
                "memberId": "122132342345GHGK",
                "planName": "Aetna",
                "rxGroup": "WSG",
                "rxBin": "009214",
                "pcn": "IS",
                "isMedicaid": false,
                "patientId": 1
            }
        ]
    }
}
```

**API Response When Access Token is Invalid**

```
{
    "status": "error",
    "statusCode": 401,
    "error": "Access Token is not valid, please generate a new one"
}
```

**API Response When Access Token is Missing**

```
{
    "status": "error",
    "statusCode": 401,
    "error": "Access Token required"
}
```

**API Response When Patient is Not Found**

```
{
    "status": "error",
    "statusCode": 404,
    "error": "Patient not found."
}
```

**API Response When DOB or Email is Missing**

```
{
    "status": "error",
    "statusCode": 400,
    "error": "Bad Request",
    "validation_errors": [
        {
            "key": "email",
            "message": "is missing"
        },
        {
            "key": "dob",
            "message": "is missing"
        }
    ]
}
```

**API Response When DOB is Not in YYYY-MM-DD Format**

```
{
    "status": "error",
    "statusCode": 400,
    "error": "Bad Request",
    "validation_errors": [
        {
            "key": "dob",
            "message": "Expected yyyy-mm-dd format, but got 1988/09/10"
        }
    ]
}

```

**API Response When Email is Not Valid**

```
{
    "status": "error",
    "statusCode": 400,
    "error": "Bad Request",
    "validation_errors": [
        {
            "key": "email",
            "message": "Email is not in a valid format: alicecom"
        }
    ]
}
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
