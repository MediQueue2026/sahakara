part of 'sahakara.dart';

class ClaimInvitedProfileVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ClaimInvitedProfileVariablesBuilder(this._dataConnect, );
  Deserializer<ClaimInvitedProfileData> dataDeserializer = (dynamic json)  => ClaimInvitedProfileData.fromJson(jsonDecode(json));
  
  Future<OperationResult<ClaimInvitedProfileData, void>> execute() {
    return ref().execute();
  }

  MutationRef<ClaimInvitedProfileData, void> ref() {
    
    return _dataConnect.mutation("ClaimInvitedProfile", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ClaimInvitedProfileData {
  final int user_updateMany;
  ClaimInvitedProfileData.fromJson(dynamic json):
  
  user_updateMany = nativeFromJson<int>(json['user_updateMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ClaimInvitedProfileData otherTyped = other as ClaimInvitedProfileData;
    return user_updateMany == otherTyped.user_updateMany;
    
  }
  @override
  int get hashCode => user_updateMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_updateMany'] = nativeToJson<int>(user_updateMany);
    return json;
  }

  ClaimInvitedProfileData({
    required this.user_updateMany,
  });
}

