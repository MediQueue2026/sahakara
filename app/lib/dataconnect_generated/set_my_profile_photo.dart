part of 'sahakara.dart';

class SetMyProfilePhotoVariablesBuilder {
  Optional<String> _profilePhoto = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  SetMyProfilePhotoVariablesBuilder profilePhoto(String? t) {
   _profilePhoto.value = t;
   return this;
  }

  SetMyProfilePhotoVariablesBuilder(this._dataConnect, );
  Deserializer<SetMyProfilePhotoData> dataDeserializer = (dynamic json)  => SetMyProfilePhotoData.fromJson(jsonDecode(json));
  Serializer<SetMyProfilePhotoVariables> varsSerializer = (SetMyProfilePhotoVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SetMyProfilePhotoData, SetMyProfilePhotoVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SetMyProfilePhotoData, SetMyProfilePhotoVariables> ref() {
    SetMyProfilePhotoVariables vars= SetMyProfilePhotoVariables(profilePhoto: _profilePhoto,);
    return _dataConnect.mutation("SetMyProfilePhoto", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SetMyProfilePhotoData {
  final int user_updateMany;
  SetMyProfilePhotoData.fromJson(dynamic json):
  
  user_updateMany = nativeFromJson<int>(json['user_updateMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetMyProfilePhotoData otherTyped = other as SetMyProfilePhotoData;
    return user_updateMany == otherTyped.user_updateMany;
    
  }
  @override
  int get hashCode => user_updateMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_updateMany'] = nativeToJson<int>(user_updateMany);
    return json;
  }

  SetMyProfilePhotoData({
    required this.user_updateMany,
  });
}

@immutable
class SetMyProfilePhotoVariables {
  late final Optional<String>profilePhoto;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SetMyProfilePhotoVariables.fromJson(Map<String, dynamic> json) {
  
  
    profilePhoto = Optional.optional(nativeFromJson, nativeToJson);
    profilePhoto.value = json['profilePhoto'] == null ? null : nativeFromJson<String>(json['profilePhoto']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetMyProfilePhotoVariables otherTyped = other as SetMyProfilePhotoVariables;
    return profilePhoto == otherTyped.profilePhoto;
    
  }
  @override
  int get hashCode => profilePhoto.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(profilePhoto.state == OptionalState.set) {
      json['profilePhoto'] = profilePhoto.toJson();
    }
    return json;
  }

  SetMyProfilePhotoVariables({
    required this.profilePhoto,
  });
}

