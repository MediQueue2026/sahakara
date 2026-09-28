part of 'sahakara.dart';

class CreateMyProfileVariablesBuilder {
  String name;
  AccountType accountType;

  final FirebaseDataConnect _dataConnect;
  CreateMyProfileVariablesBuilder(this._dataConnect, {required  this.name,required  this.accountType,});
  Deserializer<CreateMyProfileData> dataDeserializer = (dynamic json)  => CreateMyProfileData.fromJson(jsonDecode(json));
  Serializer<CreateMyProfileVariables> varsSerializer = (CreateMyProfileVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateMyProfileData, CreateMyProfileVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateMyProfileData, CreateMyProfileVariables> ref() {
    CreateMyProfileVariables vars= CreateMyProfileVariables(name: name,accountType: accountType,);
    return _dataConnect.mutation("CreateMyProfile", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateMyProfileUserInsert {
  final String id;
  CreateMyProfileUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMyProfileUserInsert otherTyped = other as CreateMyProfileUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateMyProfileUserInsert({
    required this.id,
  });
}

@immutable
class CreateMyProfileData {
  final CreateMyProfileUserInsert user_insert;
  CreateMyProfileData.fromJson(dynamic json):
  
  user_insert = CreateMyProfileUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMyProfileData otherTyped = other as CreateMyProfileData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  CreateMyProfileData({
    required this.user_insert,
  });
}

@immutable
class CreateMyProfileVariables {
  final String name;
  final AccountType accountType;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateMyProfileVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  accountType = AccountType.values.byName(json['accountType']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMyProfileVariables otherTyped = other as CreateMyProfileVariables;
    return name == otherTyped.name && 
    accountType == otherTyped.accountType;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, accountType.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['accountType'] = 
    accountType.name
    ;
    return json;
  }

  CreateMyProfileVariables({
    required this.name,
    required this.accountType,
  });
}

