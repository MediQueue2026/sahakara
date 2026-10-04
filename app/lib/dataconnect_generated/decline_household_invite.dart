part of 'sahakara.dart';

class DeclineHouseholdInviteVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeclineHouseholdInviteVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeclineHouseholdInviteData> dataDeserializer = (dynamic json)  => DeclineHouseholdInviteData.fromJson(jsonDecode(json));
  Serializer<DeclineHouseholdInviteVariables> varsSerializer = (DeclineHouseholdInviteVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeclineHouseholdInviteData, DeclineHouseholdInviteVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeclineHouseholdInviteData, DeclineHouseholdInviteVariables> ref() {
    DeclineHouseholdInviteVariables vars= DeclineHouseholdInviteVariables(id: id,);
    return _dataConnect.mutation("DeclineHouseholdInvite", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeclineHouseholdInviteHouseholdMemberUpdate {
  final String id;
  DeclineHouseholdInviteHouseholdMemberUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeclineHouseholdInviteHouseholdMemberUpdate otherTyped = other as DeclineHouseholdInviteHouseholdMemberUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeclineHouseholdInviteHouseholdMemberUpdate({
    required this.id,
  });
}

@immutable
class DeclineHouseholdInviteData {
  final DeclineHouseholdInviteHouseholdMemberUpdate? householdMember_update;
  DeclineHouseholdInviteData.fromJson(dynamic json):
  
  householdMember_update = json['householdMember_update'] == null ? null : DeclineHouseholdInviteHouseholdMemberUpdate.fromJson(json['householdMember_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeclineHouseholdInviteData otherTyped = other as DeclineHouseholdInviteData;
    return householdMember_update == otherTyped.householdMember_update;
    
  }
  @override
  int get hashCode => householdMember_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (householdMember_update != null) {
      json['householdMember_update'] = householdMember_update!.toJson();
    }
    return json;
  }

  DeclineHouseholdInviteData({
    this.householdMember_update,
  });
}

@immutable
class DeclineHouseholdInviteVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeclineHouseholdInviteVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeclineHouseholdInviteVariables otherTyped = other as DeclineHouseholdInviteVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeclineHouseholdInviteVariables({
    required this.id,
  });
}

