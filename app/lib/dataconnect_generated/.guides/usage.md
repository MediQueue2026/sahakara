# Basic Usage

```dart
SahakaraConnector.instance.ClaimInvitedProfile().execute();
SahakaraConnector.instance.CreateMyProfile(createMyProfileVariables).execute();
SahakaraConnector.instance.SetMyName(setMyNameVariables).execute();
SahakaraConnector.instance.SetMyLanguage(setMyLanguageVariables).execute();
SahakaraConnector.instance.CreateHousehold(createHouseholdVariables).execute();
SahakaraConnector.instance.AddHouseholdMember(addHouseholdMemberVariables).execute();
SahakaraConnector.instance.InviteHouseholdMember(inviteHouseholdMemberVariables).execute();
SahakaraConnector.instance.SaveContract(saveContractVariables).execute();
SahakaraConnector.instance.AddDailyTask(addDailyTaskVariables).execute();
SahakaraConnector.instance.AssignDailyTask(assignDailyTaskVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await SahakaraConnector.instance.SubmitLeaveRequest({ ... })
.reason(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

