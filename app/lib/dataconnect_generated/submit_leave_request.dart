part of 'sahakara.dart';

class SubmitLeaveRequestVariablesBuilder {
  String memberId;
  DateTime fromDate;
  DateTime toDate;
  LeaveType leaveType;
  bool isHalfDay;
  Optional<String> _reason = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  SubmitLeaveRequestVariablesBuilder reason(String? t) {
   _reason.value = t;
   return this;
  }

  SubmitLeaveRequestVariablesBuilder(this._dataConnect, {required  this.memberId,required  this.fromDate,required  this.toDate,required  this.leaveType,required  this.isHalfDay,});
  Deserializer<SubmitLeaveRequestData> dataDeserializer = (dynamic json)  => SubmitLeaveRequestData.fromJson(jsonDecode(json));
  Serializer<SubmitLeaveRequestVariables> varsSerializer = (SubmitLeaveRequestVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SubmitLeaveRequestData, SubmitLeaveRequestVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SubmitLeaveRequestData, SubmitLeaveRequestVariables> ref() {
    SubmitLeaveRequestVariables vars= SubmitLeaveRequestVariables(memberId: memberId,fromDate: fromDate,toDate: toDate,leaveType: leaveType,isHalfDay: isHalfDay,reason: _reason,);
    return _dataConnect.mutation("SubmitLeaveRequest", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SubmitLeaveRequestLeaveRequestInsert {
  final String id;
  SubmitLeaveRequestLeaveRequestInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SubmitLeaveRequestLeaveRequestInsert otherTyped = other as SubmitLeaveRequestLeaveRequestInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SubmitLeaveRequestLeaveRequestInsert({
    required this.id,
  });
}

@immutable
class SubmitLeaveRequestData {
  final SubmitLeaveRequestLeaveRequestInsert leaveRequest_insert;
  SubmitLeaveRequestData.fromJson(dynamic json):
  
  leaveRequest_insert = SubmitLeaveRequestLeaveRequestInsert.fromJson(json['leaveRequest_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SubmitLeaveRequestData otherTyped = other as SubmitLeaveRequestData;
    return leaveRequest_insert == otherTyped.leaveRequest_insert;
    
  }
  @override
  int get hashCode => leaveRequest_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['leaveRequest_insert'] = leaveRequest_insert.toJson();
    return json;
  }

  SubmitLeaveRequestData({
    required this.leaveRequest_insert,
  });
}

@immutable
class SubmitLeaveRequestVariables {
  final String memberId;
  final DateTime fromDate;
  final DateTime toDate;
  final LeaveType leaveType;
  final bool isHalfDay;
  late final Optional<String>reason;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SubmitLeaveRequestVariables.fromJson(Map<String, dynamic> json):
  
  memberId = nativeFromJson<String>(json['memberId']),
  fromDate = nativeFromJson<DateTime>(json['fromDate']),
  toDate = nativeFromJson<DateTime>(json['toDate']),
  leaveType = LeaveType.values.byName(json['leaveType']),
  isHalfDay = nativeFromJson<bool>(json['isHalfDay']) {
  
  
  
  
  
  
  
    reason = Optional.optional(nativeFromJson, nativeToJson);
    reason.value = json['reason'] == null ? null : nativeFromJson<String>(json['reason']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SubmitLeaveRequestVariables otherTyped = other as SubmitLeaveRequestVariables;
    return memberId == otherTyped.memberId && 
    fromDate == otherTyped.fromDate && 
    toDate == otherTyped.toDate && 
    leaveType == otherTyped.leaveType && 
    isHalfDay == otherTyped.isHalfDay && 
    reason == otherTyped.reason;
    
  }
  @override
  int get hashCode => Object.hashAll([memberId.hashCode, fromDate.hashCode, toDate.hashCode, leaveType.hashCode, isHalfDay.hashCode, reason.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['memberId'] = nativeToJson<String>(memberId);
    json['fromDate'] = nativeToJson<DateTime>(fromDate);
    json['toDate'] = nativeToJson<DateTime>(toDate);
    json['leaveType'] = 
    leaveType.name
    ;
    json['isHalfDay'] = nativeToJson<bool>(isHalfDay);
    if(reason.state == OptionalState.set) {
      json['reason'] = reason.toJson();
    }
    return json;
  }

  SubmitLeaveRequestVariables({
    required this.memberId,
    required this.fromDate,
    required this.toDate,
    required this.leaveType,
    required this.isHalfDay,
    required this.reason,
  });
}

