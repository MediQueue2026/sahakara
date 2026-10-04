part of 'sahakara.dart';

class CheckInVariablesBuilder {
  String memberId;
  DateTime day;
  AttendanceDayType dayType;

  final FirebaseDataConnect _dataConnect;
  CheckInVariablesBuilder(this._dataConnect, {required  this.memberId,required  this.day,required  this.dayType,});
  Deserializer<CheckInData> dataDeserializer = (dynamic json)  => CheckInData.fromJson(jsonDecode(json));
  Serializer<CheckInVariables> varsSerializer = (CheckInVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CheckInData, CheckInVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CheckInData, CheckInVariables> ref() {
    CheckInVariables vars= CheckInVariables(memberId: memberId,day: day,dayType: dayType,);
    return _dataConnect.mutation("CheckIn", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CheckInAttendanceInsert {
  final String id;
  CheckInAttendanceInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CheckInAttendanceInsert otherTyped = other as CheckInAttendanceInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CheckInAttendanceInsert({
    required this.id,
  });
}

@immutable
class CheckInData {
  final CheckInAttendanceInsert attendance_insert;
  CheckInData.fromJson(dynamic json):
  
  attendance_insert = CheckInAttendanceInsert.fromJson(json['attendance_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CheckInData otherTyped = other as CheckInData;
    return attendance_insert == otherTyped.attendance_insert;
    
  }
  @override
  int get hashCode => attendance_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['attendance_insert'] = attendance_insert.toJson();
    return json;
  }

  CheckInData({
    required this.attendance_insert,
  });
}

@immutable
class CheckInVariables {
  final String memberId;
  final DateTime day;
  final AttendanceDayType dayType;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CheckInVariables.fromJson(Map<String, dynamic> json):
  
  memberId = nativeFromJson<String>(json['memberId']),
  day = nativeFromJson<DateTime>(json['day']),
  dayType = AttendanceDayType.values.byName(json['dayType']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CheckInVariables otherTyped = other as CheckInVariables;
    return memberId == otherTyped.memberId && 
    day == otherTyped.day && 
    dayType == otherTyped.dayType;
    
  }
  @override
  int get hashCode => Object.hashAll([memberId.hashCode, day.hashCode, dayType.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['memberId'] = nativeToJson<String>(memberId);
    json['day'] = nativeToJson<DateTime>(day);
    json['dayType'] = 
    dayType.name
    ;
    return json;
  }

  CheckInVariables({
    required this.memberId,
    required this.day,
    required this.dayType,
  });
}

