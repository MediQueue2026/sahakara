part of 'sahakara.dart';

class InviteHouseholdMemberVariablesBuilder {
  String householdId;
  String phone;
  MemberRole role;

  final FirebaseDataConnect _dataConnect;
  InviteHouseholdMemberVariablesBuilder(this._dataConnect, {required  this.householdId,required  this.phone,required  this.role,});
  Deserializer<InviteHouseholdMemberData> dataDeserializer = (dynamic json)  => InviteHouseholdMemberData.fromJson(jsonDecode(json));
  Serializer<InviteHouseholdMemberVariables> varsSerializer = (InviteHouseholdMemberVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InviteHouseholdMemberData, InviteHouseholdMemberVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InviteHouseholdMemberData, InviteHouseholdMemberVariables> ref() {
    InviteHouseholdMemberVariables vars= InviteHouseholdMemberVariables(householdId: householdId,phone: phone,role: role,);
    return _dataConnect.mutation("InviteHouseholdMember", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InviteHouseholdMemberUserInsert {
  final String id;
  InviteHouseholdMemberUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InviteHouseholdMemberUserInsert otherTyped = other as InviteHouseholdMemberUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InviteHouseholdMemberUserInsert({
    required this.id,
  });
}

@immutable
class InviteHouseholdMemberHouseholdMemberInsert {
  final String id;
  InviteHouseholdMemberHouseholdMemberInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InviteHouseholdMemberHouseholdMemberInsert otherTyped = other as InviteHouseholdMemberHouseholdMemberInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InviteHouseholdMemberHouseholdMemberInsert({
    required this.id,
  });
}

@immutable
class InviteHouseholdMemberData {
  final InviteHouseholdMemberUserInsert user_insert;
  final InviteHouseholdMemberHouseholdMemberInsert householdMember_insert;
  InviteHouseholdMemberData.fromJson(dynamic json):
  
  user_insert = InviteHouseholdMemberUserInsert.fromJson(json['user_insert']),
  householdMember_insert = InviteHouseholdMemberHouseholdMemberInsert.fromJson(json['householdMember_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InviteHouseholdMemberData otherTyped = other as InviteHouseholdMemberData;
    return user_insert == otherTyped.user_insert && 
    householdMember_insert == otherTyped.householdMember_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([user_insert.hashCode, householdMember_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    json['householdMember_insert'] = householdMember_insert.toJson();
    return json;
  }

  InviteHouseholdMemberData({
    required this.user_insert,
    required this.householdMember_insert,
  });
}

@immutable
class InviteHouseholdMemberVariables {
  final String householdId;
  final String phone;
  final MemberRole role;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InviteHouseholdMemberVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']),
  phone = nativeFromJson<String>(json['phone']),
  role = MemberRole.values.byName(json['role']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InviteHouseholdMemberVariables otherTyped = other as InviteHouseholdMemberVariables;
    return householdId == otherTyped.householdId && 
    phone == otherTyped.phone && 
    role == otherTyped.role;
    
  }
  @override
  int get hashCode => Object.hashAll([householdId.hashCode, phone.hashCode, role.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    json['phone'] = nativeToJson<String>(phone);
    json['role'] = 
    role.name
    ;
    return json;
  }

  InviteHouseholdMemberVariables({
    required this.householdId,
    required this.phone,
    required this.role,
  });
}

