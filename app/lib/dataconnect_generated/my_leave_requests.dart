part of 'sahakara.dart';

class MyLeaveRequestsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MyLeaveRequestsVariablesBuilder(this._dataConnect, );
  Deserializer<MyLeaveRequestsData> dataDeserializer = (dynamic json)  => MyLeaveRequestsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<MyLeaveRequestsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<MyLeaveRequestsData, void> ref() {
    
    return _dataConnect.query("MyLeaveRequests", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class MyLeaveRequestsLeaveRequests {
  final String id;
  final DateTime fromDate;
  final DateTime toDate;
  final EnumValue<LeaveType> leaveType;
  final bool isHalfDay;
  final String? reason;
  final EnumValue<LeaveStatus> status;
  final Timestamp createdAt;
  MyLeaveRequestsLeaveRequests.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  fromDate = nativeFromJson<DateTime>(json['fromDate']),
  toDate = nativeFromJson<DateTime>(json['toDate']),
  leaveType = leaveTypeDeserializer(json['leaveType']),
  isHalfDay = nativeFromJson<bool>(json['isHalfDay']),
  reason = json['reason'] == null ? null : nativeFromJson<String>(json['reason']),
  status = leaveStatusDeserializer(json['status']),
  createdAt = Timestamp.fromJson(json['createdAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyLeaveRequestsLeaveRequests otherTyped = other as MyLeaveRequestsLeaveRequests;
    return id == otherTyped.id && 
    fromDate == otherTyped.fromDate && 
    toDate == otherTyped.toDate && 
    leaveType == otherTyped.leaveType && 
    isHalfDay == otherTyped.isHalfDay && 
    reason == otherTyped.reason && 
    status == otherTyped.status && 
    createdAt == otherTyped.createdAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, fromDate.hashCode, toDate.hashCode, leaveType.hashCode, isHalfDay.hashCode, reason.hashCode, status.hashCode, createdAt.hashCode]);
  

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
    return json;
  }

  MyLeaveRequestsLeaveRequests({
    required this.id,
    required this.fromDate,
    required this.toDate,
    required this.leaveType,
    required this.isHalfDay,
    this.reason,
    required this.status,
    required this.createdAt,
  });
}

@immutable
class MyLeaveRequestsData {
  final List<MyLeaveRequestsLeaveRequests> leaveRequests;
  MyLeaveRequestsData.fromJson(dynamic json):
  
  leaveRequests = (json['leaveRequests'] as List<dynamic>)
        .map((e) => MyLeaveRequestsLeaveRequests.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyLeaveRequestsData otherTyped = other as MyLeaveRequestsData;
    return leaveRequests == otherTyped.leaveRequests;
    
  }
  @override
  int get hashCode => leaveRequests.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['leaveRequests'] = leaveRequests.map((e) => e.toJson()).toList();
    return json;
  }

  MyLeaveRequestsData({
    required this.leaveRequests,
  });
}

