part of 'sahakara.dart';

class CreateMyProfileVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  CreateMyProfileVariablesBuilder(this._dataConnect, );
  Deserializer<CreateMyProfileData> dataDeserializer = (dynamic json)  => CreateMyProfileData.fromJson(jsonDecode(json));
  
  Future<OperationResult<CreateMyProfileData, void>> execute() {
    return ref().execute();
  }

  MutationRef<CreateMyProfileData, void> ref() {
    
    return _dataConnect.mutation("CreateMyProfile", dataDeserializer, emptySerializer, null);
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

