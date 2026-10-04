part of 'sahakara.dart';

class HouseholdLeaveRequestsVariablesBuilder {
  String householdId;

  final FirebaseDataConnect _dataConnect;
  HouseholdLeaveRequestsVariablesBuilder(this._dataConnect, {required  this.householdId,});
  Deserializer<HouseholdLeaveRequestsData> dataDeserializer = (dynamic json)  => HouseholdLeaveRequestsData.fromJson(jsonDecode(json));
  Serializer<HouseholdLeaveRequestsVariables> varsSerializer = (HouseholdLeaveRequestsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<HouseholdLeaveRequestsData, HouseholdLeaveRequestsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<HouseholdLeaveRequestsData, HouseholdLeaveRequestsVariables> ref() {
    HouseholdLeaveRequestsVariables vars= HouseholdLeaveRequestsVariables(householdId: householdId,);
    return _dataConnect.query("HouseholdLeaveRequests", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class HouseholdLeaveRequestsLeaveRequests {
  final String id;
  final DateTime fromDate;
  final DateTime toDate;
  final EnumValue<LeaveType> leaveType;
  final bool isHalfDay;
  final String? reason;
  final EnumValue<LeaveStatus> status;
  final Timestamp createdAt;
  final HouseholdLeaveRequestsLeaveRequestsMember member;
  HouseholdLeaveRequestsLeaveRequests.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  fromDate = nativeFromJson<DateTime>(json['fromDate']),
  toDate = nativeFromJson<DateTime>(json['toDate']),
  leaveType = leaveTypeDeserializer(json['leaveType']),
  isHalfDay = nativeFromJson<bool>(json['isHalfDay']),
  reason = json['reason'] == null ? null : nativeFromJson<String>(json['reason']),
  status = leaveStatusDeserializer(json['status']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  member = HouseholdLeaveRequestsLeaveRequestsMember.fromJson(json['member']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdLeaveRequestsLeaveRequests otherTyped = other as HouseholdLeaveRequestsLeaveRequests;
    return id == otherTyped.id && 
    fromDate == otherTyped.fromDate && 
    toDate == otherTyped.toDate && 
    leaveType == otherTyped.leaveType && 
    isHalfDay == otherTyped.isHalfDay && 
    reason == otherTyped.reason && 
    status == otherTyped.status && 
    createdAt == otherTyped.createdAt && 
    member == otherTyped.member;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, fromDate.hashCode, toDate.hashCode, leaveType.hashCode, isHalfDay.hashCode, reason.hashCode, status.hashCode, createdAt.hashCode, member.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['fromDate'] = nativeToJson<DateTime>(fromDate);
    json['toDate'] = nativeToJson<DateTime>(toDate);
    json['leaveType'] = 
    leaveTypeSerializer(leaveType)
    ;
    json['isHalfDay'] = nativeToJson<bool>(isHalfDay);
    if (reason != null) {
      json['reason'] = nativeToJson<String?>(reason);
    }
    json['status'] = 
    leaveStatusSerializer(status)
    ;
    json['createdAt'] = createdAt.toJson();
    json['member'] = member.toJson();
    return json;
  }

  HouseholdLeaveRequestsLeaveRequests({
    required this.id,
    required this.fromDate,
    required this.toDate,
    required this.leaveType,
    required this.isHalfDay,
    this.reason,
    required this.status,
    required this.createdAt,
    required this.member,
  });
}

@immutable
class HouseholdLeaveRequestsLeaveRequestsMember {
  final String id;
  final HouseholdLeaveRequestsLeaveRequestsMemberUser user;
  HouseholdLeaveRequestsLeaveRequestsMember.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  user = HouseholdLeaveRequestsLeaveRequestsMemberUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdLeaveRequestsLeaveRequestsMember otherTyped = other as HouseholdLeaveRequestsLeaveRequestsMember;
    return id == otherTyped.id && 
    user == otherTyped.user;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, user.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['user'] = user.toJson();
    return json;
  }

  HouseholdLeaveRequestsLeaveRequestsMember({
    required this.id,
    required this.user,
  });
}

@immutable
class HouseholdLeaveRequestsLeaveRequestsMemberUser {
  final String name;
  HouseholdLeaveRequestsLeaveRequestsMemberUser.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdLeaveRequestsLeaveRequestsMemberUser otherTyped = other as HouseholdLeaveRequestsLeaveRequestsMemberUser;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  HouseholdLeaveRequestsLeaveRequestsMemberUser({
    required this.name,
  });
}

@immutable
class HouseholdLeaveRequestsData {
  final List<HouseholdLeaveRequestsLeaveRequests> leaveRequests;
  HouseholdLeaveRequestsData.fromJson(dynamic json):
  
  leaveRequests = (json['leaveRequests'] as List<dynamic>)
        .map((e) => HouseholdLeaveRequestsLeaveRequests.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdLeaveRequestsData otherTyped = other as HouseholdLeaveRequestsData;
    return leaveRequests == otherTyped.leaveRequests;
    
  }
  @override
  int get hashCode => leaveRequests.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['leaveRequests'] = leaveRequests.map((e) => e.toJson()).toList();
    return json;
  }

  HouseholdLeaveRequestsData({
    required this.leaveRequests,
  });
}

@immutable
class HouseholdLeaveRequestsVariables {
  final String householdId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  HouseholdLeaveRequestsVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdLeaveRequestsVariables otherTyped = other as HouseholdLeaveRequestsVariables;
    return householdId == otherTyped.householdId;
    
  }
  @override
  int get hashCode => householdId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    return json;
  }

  HouseholdLeaveRequestsVariables({
    required this.householdId,
  });
}

