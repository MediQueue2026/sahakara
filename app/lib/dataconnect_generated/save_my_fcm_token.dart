part of 'sahakara.dart';

class SaveMyFcmTokenVariablesBuilder {
  String token;
  Optional<String> _previousToken = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  SaveMyFcmTokenVariablesBuilder previousToken(String? t) {
   _previousToken.value = t;
   return this;
  }

  SaveMyFcmTokenVariablesBuilder(this._dataConnect, {required  this.token,});
  Deserializer<SaveMyFcmTokenData> dataDeserializer = (dynamic json)  => SaveMyFcmTokenData.fromJson(jsonDecode(json));
  Serializer<SaveMyFcmTokenVariables> varsSerializer = (SaveMyFcmTokenVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SaveMyFcmTokenData, SaveMyFcmTokenVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SaveMyFcmTokenData, SaveMyFcmTokenVariables> ref() {
    SaveMyFcmTokenVariables vars= SaveMyFcmTokenVariables(token: token,previousToken: _previousToken,);
    return _dataConnect.mutation("SaveMyFcmToken", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SaveMyFcmTokenUserDeviceTokenInsert {
  final String id;
  SaveMyFcmTokenUserDeviceTokenInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SaveMyFcmTokenUserDeviceTokenInsert otherTyped = other as SaveMyFcmTokenUserDeviceTokenInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SaveMyFcmTokenUserDeviceTokenInsert({
    required this.id,
  });
}

@immutable
class SaveMyFcmTokenData {
  final int userDeviceToken_deleteMany;
  final SaveMyFcmTokenUserDeviceTokenInsert userDeviceToken_insert;
  SaveMyFcmTokenData.fromJson(dynamic json):
  
  userDeviceToken_deleteMany = nativeFromJson<int>(json['userDeviceToken_deleteMany']),
  userDeviceToken_insert = SaveMyFcmTokenUserDeviceTokenInsert.fromJson(json['userDeviceToken_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SaveMyFcmTokenData otherTyped = other as SaveMyFcmTokenData;
    return userDeviceToken_deleteMany == otherTyped.userDeviceToken_deleteMany && 
    userDeviceToken_insert == otherTyped.userDeviceToken_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([userDeviceToken_deleteMany.hashCode, userDeviceToken_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userDeviceToken_deleteMany'] = nativeToJson<int>(userDeviceToken_deleteMany);
    json['userDeviceToken_insert'] = userDeviceToken_insert.toJson();
    return json;
  }

  SaveMyFcmTokenData({
    required this.userDeviceToken_deleteMany,
    required this.userDeviceToken_insert,
  });
}

@immutable
class SaveMyFcmTokenVariables {
  final String token;
  late final Optional<String>previousToken;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SaveMyFcmTokenVariables.fromJson(Map<String, dynamic> json):
  
  token = nativeFromJson<String>(json['token']) {
  
  
  
    previousToken = Optional.optional(nativeFromJson, nativeToJson);
    previousToken.value = json['previousToken'] == null ? null : nativeFromJson<String>(json['previousToken']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SaveMyFcmTokenVariables otherTyped = other as SaveMyFcmTokenVariables;
    return token == otherTyped.token && 
    previousToken == otherTyped.previousToken;
    
  }
  @override
  int get hashCode => Object.hashAll([token.hashCode, previousToken.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['token'] = nativeToJson<String>(token);
    if(previousToken.state == OptionalState.set) {
      json['previousToken'] = previousToken.toJson();
    }
    return json;
  }

  SaveMyFcmTokenVariables({
    required this.token,
    required this.previousToken,
  });
}

