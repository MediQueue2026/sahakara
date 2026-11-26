part of 'sahakara.dart';

class RemoveMyFcmTokenVariablesBuilder {
  String token;

  final FirebaseDataConnect _dataConnect;
  RemoveMyFcmTokenVariablesBuilder(this._dataConnect, {required  this.token,});
  Deserializer<RemoveMyFcmTokenData> dataDeserializer = (dynamic json)  => RemoveMyFcmTokenData.fromJson(jsonDecode(json));
  Serializer<RemoveMyFcmTokenVariables> varsSerializer = (RemoveMyFcmTokenVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RemoveMyFcmTokenData, RemoveMyFcmTokenVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RemoveMyFcmTokenData, RemoveMyFcmTokenVariables> ref() {
    RemoveMyFcmTokenVariables vars= RemoveMyFcmTokenVariables(token: token,);
    return _dataConnect.mutation("RemoveMyFcmToken", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class RemoveMyFcmTokenData {
  final int userDeviceToken_deleteMany;
  RemoveMyFcmTokenData.fromJson(dynamic json):
  
  userDeviceToken_deleteMany = nativeFromJson<int>(json['userDeviceToken_deleteMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveMyFcmTokenData otherTyped = other as RemoveMyFcmTokenData;
    return userDeviceToken_deleteMany == otherTyped.userDeviceToken_deleteMany;
    
  }
  @override
  int get hashCode => userDeviceToken_deleteMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userDeviceToken_deleteMany'] = nativeToJson<int>(userDeviceToken_deleteMany);
    return json;
  }

  RemoveMyFcmTokenData({
    required this.userDeviceToken_deleteMany,
  });
}

@immutable
class RemoveMyFcmTokenVariables {
  final String token;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RemoveMyFcmTokenVariables.fromJson(Map<String, dynamic> json):
  
  token = nativeFromJson<String>(json['token']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RemoveMyFcmTokenVariables otherTyped = other as RemoveMyFcmTokenVariables;
    return token == otherTyped.token;
    
  }
  @override
  int get hashCode => token.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['token'] = nativeToJson<String>(token);
    return json;
  }

  RemoveMyFcmTokenVariables({
    required this.token,
  });
}

