part of 'sahakara.dart';

class RemoveInvalidFcmTokenVariablesBuilder {
  String token;

  final FirebaseDataConnect _dataConnect;
  RemoveInvalidFcmTokenVariablesBuilder(this._dataConnect, {required  this.token,});
  Deserializer<RemoveInvalidFcmTokenData> dataDeserializer = (dynamic json)  => RemoveInvalidFcmTokenData.fromJson(jsonDecode(json));
  Serializer<RemoveInvalidFcmTokenVariables> varsSerializer = (RemoveInvalidFcmTokenVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RemoveInvalidFcmTokenData, RemoveInvalidFcmTokenVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RemoveInvalidFcmTokenData, RemoveInvalidFcmTokenVariables> ref() {
    RemoveInvalidFcmTokenVariables vars= RemoveInvalidFcmTokenVariables(token: token,);
    return _dataConnect.mutation("RemoveInvalidFcmToken", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class RemoveInvalidFcmTokenData {
  final int userDeviceToken_deleteMany;
  RemoveInvalidFcmTokenData.fromJson(dynamic json):
  
  userDeviceToken_deleteMany = nativeFromJson<int>(json['userDeviceToken_deleteMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveInvalidFcmTokenData otherTyped = other as RemoveInvalidFcmTokenData;
    return userDeviceToken_deleteMany == otherTyped.userDeviceToken_deleteMany;
    
  }
  @override
  int get hashCode => userDeviceToken_deleteMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userDeviceToken_deleteMany'] = nativeToJson<int>(userDeviceToken_deleteMany);
    return json;
  }

  RemoveInvalidFcmTokenData({
    required this.userDeviceToken_deleteMany,
  });
}

@immutable
class RemoveInvalidFcmTokenVariables {
  final String token;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RemoveInvalidFcmTokenVariables.fromJson(Map<String, dynamic> json):
  
  token = nativeFromJson<String>(json['token']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveInvalidFcmTokenVariables otherTyped = other as RemoveInvalidFcmTokenVariables;
    return token == otherTyped.token;
    
  }
  @override
  int get hashCode => token.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['token'] = nativeToJson<String>(token);
    return json;
  }

  RemoveInvalidFcmTokenVariables({
    required this.token,
  });
}

