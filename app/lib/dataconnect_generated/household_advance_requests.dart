part of 'sahakara.dart';

class HouseholdAdvanceRequestsVariablesBuilder {
  String householdId;

  final FirebaseDataConnect _dataConnect;
  HouseholdAdvanceRequestsVariablesBuilder(this._dataConnect, {required  this.householdId,});
  Deserializer<HouseholdAdvanceRequestsData> dataDeserializer = (dynamic json)  => HouseholdAdvanceRequestsData.fromJson(jsonDecode(json));
  Serializer<HouseholdAdvanceRequestsVariables> varsSerializer = (HouseholdAdvanceRequestsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<HouseholdAdvanceRequestsData, HouseholdAdvanceRequestsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<HouseholdAdvanceRequestsData, HouseholdAdvanceRequestsVariables> ref() {
    HouseholdAdvanceRequestsVariables vars= HouseholdAdvanceRequestsVariables(householdId: householdId,);
    return _dataConnect.query("HouseholdAdvanceRequests", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class HouseholdAdvanceRequestsAdvanceRequests {
  final String id;
  final double amount;
  final String? reason;
  final EnumValue<AdvanceRequestStatus> status;
  final Timestamp requestedAt;
  final Timestamp? reviewedAt;
  final HouseholdAdvanceRequestsAdvanceRequestsMember member;
  HouseholdAdvanceRequestsAdvanceRequests.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  amount = nativeFromJson<double>(json['amount']),
  reason = json['reason'] == null ? null : nativeFromJson<String>(json['reason']),
  status = advanceRequestStatusDeserializer(json['status']),
  requestedAt = Timestamp.fromJson(json['requestedAt']),
  reviewedAt = json['reviewedAt'] == null ? null : Timestamp.fromJson(json['reviewedAt']),
  member = HouseholdAdvanceRequestsAdvanceRequestsMember.fromJson(json['member']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdAdvanceRequestsAdvanceRequests otherTyped = other as HouseholdAdvanceRequestsAdvanceRequests;
    return id == otherTyped.id && 
    amount == otherTyped.amount && 
    reason == otherTyped.reason && 
    status == otherTyped.status && 
    requestedAt == otherTyped.requestedAt && 
    reviewedAt == otherTyped.reviewedAt && 
    member == otherTyped.member;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, amount.hashCode, reason.hashCode, status.hashCode, requestedAt.hashCode, reviewedAt.hashCode, member.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['amount'] = nativeToJson<double>(amount);
    if (reason != null) {
      json['reason'] = nativeToJson<String?>(reason);
    }
    json['status'] = 
    advanceRequestStatusSerializer(status)
    ;
    json['requestedAt'] = requestedAt.toJson();
    if (reviewedAt != null) {
      json['reviewedAt'] = reviewedAt!.toJson();
    }
    json['member'] = member.toJson();
    return json;
  }

  HouseholdAdvanceRequestsAdvanceRequests({
    required this.id,
    required this.amount,
    this.reason,
    required this.status,
    required this.requestedAt,
    this.reviewedAt,
    required this.member,
  });
}

@immutable
class HouseholdAdvanceRequestsAdvanceRequestsMember {
  final String id;
  final HouseholdAdvanceRequestsAdvanceRequestsMemberUser user;
  HouseholdAdvanceRequestsAdvanceRequestsMember.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  user = HouseholdAdvanceRequestsAdvanceRequestsMemberUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdAdvanceRequestsAdvanceRequestsMember otherTyped = other as HouseholdAdvanceRequestsAdvanceRequestsMember;
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

  HouseholdAdvanceRequestsAdvanceRequestsMember({
    required this.id,
    required this.user,
  });
}

@immutable
class HouseholdAdvanceRequestsAdvanceRequestsMemberUser {
  final String name;
  HouseholdAdvanceRequestsAdvanceRequestsMemberUser.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdAdvanceRequestsAdvanceRequestsMemberUser otherTyped = other as HouseholdAdvanceRequestsAdvanceRequestsMemberUser;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  HouseholdAdvanceRequestsAdvanceRequestsMemberUser({
    required this.name,
  });
}

@immutable
class HouseholdAdvanceRequestsData {
  final List<HouseholdAdvanceRequestsAdvanceRequests> advanceRequests;
  HouseholdAdvanceRequestsData.fromJson(dynamic json):
  
  advanceRequests = (json['advanceRequests'] as List<dynamic>)
        .map((e) => HouseholdAdvanceRequestsAdvanceRequests.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdAdvanceRequestsData otherTyped = other as HouseholdAdvanceRequestsData;
    return advanceRequests == otherTyped.advanceRequests;
    
  }
  @override
  int get hashCode => advanceRequests.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['advanceRequests'] = advanceRequests.map((e) => e.toJson()).toList();
    return json;
  }

  HouseholdAdvanceRequestsData({
    required this.advanceRequests,
  });
}

@immutable
class HouseholdAdvanceRequestsVariables {
  final String householdId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  HouseholdAdvanceRequestsVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdAdvanceRequestsVariables otherTyped = other as HouseholdAdvanceRequestsVariables;
    return householdId == otherTyped.householdId;
    
  }
  @override
  int get hashCode => householdId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    return json;
  }

  HouseholdAdvanceRequestsVariables({
    required this.householdId,
  });
}

