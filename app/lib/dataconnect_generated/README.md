# sahakara SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
SahakaraConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### MyProfile
#### Required Arguments
```dart
// No required arguments
SahakaraConnector.instance.myProfile().execute();
```



#### Return Type
`execute()` returns a `QueryResult<MyProfileData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await SahakaraConnector.instance.myProfile();
MyProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = SahakaraConnector.instance.myProfile().ref();
ref.execute();

ref.subscribe(...);
```


### MyMembership
#### Required Arguments
```dart
// No required arguments
SahakaraConnector.instance.myMembership().execute();
```



#### Return Type
`execute()` returns a `QueryResult<MyMembershipData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await SahakaraConnector.instance.myMembership();
MyMembershipData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = SahakaraConnector.instance.myMembership().ref();
ref.execute();

ref.subscribe(...);
```


### HouseholdMembers
#### Required Arguments
```dart
String householdId = ...;
SahakaraConnector.instance.householdMembers(
  householdId: householdId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<HouseholdMembersData, HouseholdMembersVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await SahakaraConnector.instance.householdMembers(
  householdId: householdId,
);
HouseholdMembersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String householdId = ...;

final ref = SahakaraConnector.instance.householdMembers(
  householdId: householdId,
).ref();
ref.execute();

ref.subscribe(...);
```


### UserIdByEmail
#### Required Arguments
```dart
String email = ...;
SahakaraConnector.instance.userIdByEmail(
  email: email,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<UserIdByEmailData, UserIdByEmailVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await SahakaraConnector.instance.userIdByEmail(
  email: email,
);
UserIdByEmailData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;

final ref = SahakaraConnector.instance.userIdByEmail(
  email: email,
).ref();
ref.execute();

ref.subscribe(...);
```


### CurrentContract
#### Required Arguments
```dart
String memberId = ...;
SahakaraConnector.instance.currentContract(
  memberId: memberId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<CurrentContractData, CurrentContractVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await SahakaraConnector.instance.currentContract(
  memberId: memberId,
);
CurrentContractData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String memberId = ...;

final ref = SahakaraConnector.instance.currentContract(
  memberId: memberId,
).ref();
ref.execute();

ref.subscribe(...);
```


### LibraryTasks
#### Required Arguments
```dart
// No required arguments
SahakaraConnector.instance.libraryTasks().execute();
```



#### Return Type
`execute()` returns a `QueryResult<LibraryTasksData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await SahakaraConnector.instance.libraryTasks();
LibraryTasksData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = SahakaraConnector.instance.libraryTasks().ref();
ref.execute();

ref.subscribe(...);
```


### Holidays
#### Required Arguments
```dart
// No required arguments
SahakaraConnector.instance.holidays().execute();
```



#### Return Type
`execute()` returns a `QueryResult<HolidaysData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await SahakaraConnector.instance.holidays();
HolidaysData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = SahakaraConnector.instance.holidays().ref();
ref.execute();

ref.subscribe(...);
```


### AdminHouseholds
#### Required Arguments
```dart
// No required arguments
SahakaraConnector.instance.adminHouseholds().execute();
```



#### Return Type
`execute()` returns a `QueryResult<AdminHouseholdsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await SahakaraConnector.instance.adminHouseholds();
AdminHouseholdsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = SahakaraConnector.instance.adminHouseholds().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### ClaimInvitedProfile
#### Required Arguments
```dart
// No required arguments
SahakaraConnector.instance.claimInvitedProfile().execute();
```



#### Return Type
`execute()` returns a `OperationResult<ClaimInvitedProfileData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.claimInvitedProfile();
ClaimInvitedProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = SahakaraConnector.instance.claimInvitedProfile().ref();
ref.execute();
```


### CreateMyProfile
#### Required Arguments
```dart
// No required arguments
SahakaraConnector.instance.createMyProfile().execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateMyProfileData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.createMyProfile();
CreateMyProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = SahakaraConnector.instance.createMyProfile().ref();
ref.execute();
```


### SetMyLanguage
#### Required Arguments
```dart
AppLanguage language = ...;
SahakaraConnector.instance.setMyLanguage(
  language: language,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<SetMyLanguageData, SetMyLanguageVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.setMyLanguage(
  language: language,
);
SetMyLanguageData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
AppLanguage language = ...;

final ref = SahakaraConnector.instance.setMyLanguage(
  language: language,
).ref();
ref.execute();
```


### CreateHousehold
#### Required Arguments
```dart
String name = ...;
SahakaraConnector.instance.createHousehold(
  name: name,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateHousehold, we created `CreateHouseholdBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateHouseholdVariablesBuilder {
  ...
   CreateHouseholdVariablesBuilder address(String? t) {
   _address.value = t;
   return this;
  }

  ...
}
SahakaraConnector.instance.createHousehold(
  name: name,
)
.address(address)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateHouseholdData, CreateHouseholdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.createHousehold(
  name: name,
);
CreateHouseholdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;

final ref = SahakaraConnector.instance.createHousehold(
  name: name,
).ref();
ref.execute();
```


### AddHouseholdMember
#### Required Arguments
```dart
String householdId = ...;
String userId = ...;
MemberRole role = ...;
SahakaraConnector.instance.addHouseholdMember(
  householdId: householdId,
  userId: userId,
  role: role,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AddHouseholdMemberData, AddHouseholdMemberVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.addHouseholdMember(
  householdId: householdId,
  userId: userId,
  role: role,
);
AddHouseholdMemberData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String householdId = ...;
String userId = ...;
MemberRole role = ...;

final ref = SahakaraConnector.instance.addHouseholdMember(
  householdId: householdId,
  userId: userId,
  role: role,
).ref();
ref.execute();
```


### InviteHouseholdMember
#### Required Arguments
```dart
String householdId = ...;
String email = ...;
MemberRole role = ...;
SahakaraConnector.instance.inviteHouseholdMember(
  householdId: householdId,
  email: email,
  role: role,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InviteHouseholdMemberData, InviteHouseholdMemberVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.inviteHouseholdMember(
  householdId: householdId,
  email: email,
  role: role,
);
InviteHouseholdMemberData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String householdId = ...;
String email = ...;
MemberRole role = ...;

final ref = SahakaraConnector.instance.inviteHouseholdMember(
  householdId: householdId,
  email: email,
  role: role,
).ref();
ref.execute();
```


### SaveContract
#### Required Arguments
```dart
String memberId = ...;
PayType payType = ...;
double rate = ...;
SahakaraConnector.instance.saveContract(
  memberId: memberId,
  payType: payType,
  rate: rate,
).execute();
```

#### Optional Arguments
We return a builder for each query. For SaveContract, we created `SaveContractBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class SaveContractVariablesBuilder {
  ...
   SaveContractVariablesBuilder offDays(String? t) {
   _offDays.value = t;
   return this;
  }
  SaveContractVariablesBuilder workingHours(String? t) {
   _workingHours.value = t;
   return this;
  }

  ...
}
SahakaraConnector.instance.saveContract(
  memberId: memberId,
  payType: payType,
  rate: rate,
)
.offDays(offDays)
.workingHours(workingHours)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<SaveContractData, SaveContractVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.saveContract(
  memberId: memberId,
  payType: payType,
  rate: rate,
);
SaveContractData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String memberId = ...;
PayType payType = ...;
double rate = ...;

final ref = SahakaraConnector.instance.saveContract(
  memberId: memberId,
  payType: payType,
  rate: rate,
).ref();
ref.execute();
```


### AddLibraryTask
#### Required Arguments
```dart
TaskCategory category = ...;
String nameEn = ...;
SahakaraConnector.instance.addLibraryTask(
  category: category,
  nameEn: nameEn,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AddLibraryTask, we created `AddLibraryTaskBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AddLibraryTaskVariablesBuilder {
  ...
   AddLibraryTaskVariablesBuilder nameSi(String? t) {
   _nameSi.value = t;
   return this;
  }
  AddLibraryTaskVariablesBuilder nameTa(String? t) {
   _nameTa.value = t;
   return this;
  }

  ...
}
SahakaraConnector.instance.addLibraryTask(
  category: category,
  nameEn: nameEn,
)
.nameSi(nameSi)
.nameTa(nameTa)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AddLibraryTaskData, AddLibraryTaskVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.addLibraryTask(
  category: category,
  nameEn: nameEn,
);
AddLibraryTaskData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
TaskCategory category = ...;
String nameEn = ...;

final ref = SahakaraConnector.instance.addLibraryTask(
  category: category,
  nameEn: nameEn,
).ref();
ref.execute();
```


### DeleteLibraryTask
#### Required Arguments
```dart
String id = ...;
SahakaraConnector.instance.deleteLibraryTask(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteLibraryTaskData, DeleteLibraryTaskVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.deleteLibraryTask(
  id: id,
);
DeleteLibraryTaskData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = SahakaraConnector.instance.deleteLibraryTask(
  id: id,
).ref();
ref.execute();
```


### AddHoliday
#### Required Arguments
```dart
DateTime date = ...;
HolidayType type = ...;
String nameEn = ...;
SahakaraConnector.instance.addHoliday(
  date: date,
  type: type,
  nameEn: nameEn,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AddHoliday, we created `AddHolidayBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AddHolidayVariablesBuilder {
  ...
   AddHolidayVariablesBuilder nameSi(String? t) {
   _nameSi.value = t;
   return this;
  }
  AddHolidayVariablesBuilder nameTa(String? t) {
   _nameTa.value = t;
   return this;
  }

  ...
}
SahakaraConnector.instance.addHoliday(
  date: date,
  type: type,
  nameEn: nameEn,
)
.nameSi(nameSi)
.nameTa(nameTa)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AddHolidayData, AddHolidayVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.addHoliday(
  date: date,
  type: type,
  nameEn: nameEn,
);
AddHolidayData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
HolidayType type = ...;
String nameEn = ...;

final ref = SahakaraConnector.instance.addHoliday(
  date: date,
  type: type,
  nameEn: nameEn,
).ref();
ref.execute();
```


### DeleteHoliday
#### Required Arguments
```dart
String id = ...;
SahakaraConnector.instance.deleteHoliday(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteHolidayData, DeleteHolidayVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SahakaraConnector.instance.deleteHoliday(
  id: id,
);
DeleteHolidayData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = SahakaraConnector.instance.deleteHoliday(
  id: id,
).ref();
ref.execute();
```

