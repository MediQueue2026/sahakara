part of 'sahakara.dart';

class AddAttendanceRecordVariablesBuilder {
  String memberId;
  DateTime day;
  Timestamp checkIn;
  Optional<Timestamp> _checkOut = Optional.optional((json) => json['checkOut'] = Timestamp.fromJson(json['checkOut']), defaultSerializer);
  AttendanceDayType dayType;
  double overtimeHours;
  Optional<String> _note = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AddAttendanceRecordVariablesBuilder checkOut(Timestamp? t) {
   _checkOut.value = t;
   return this;
  }
  AddAttendanceRecordVariablesBuilder note(String? t) {
   _note.value = t;
   return this;
  }

  AddAttendanceRecordVariablesBuilder(this._dataConnect, {required  this.memberId,required  this.day,required  this.checkIn,required  this.dayType,required  this.overtimeHours,});
  Deserializer<AddAttendanceRecordData> dataDeserializer = (dynamic json)  => AddAttendanceRecordData.fromJson(jsonDecode(json));
  Serializer<AddAttendanceRecordVariables> varsSerializer = (AddAttendanceRecordVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddAttendanceRecordData, AddAttendanceRecordVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddAttendanceRecordData, AddAttendanceRecordVariables> ref() {
    AddAttendanceRecordVariables vars= AddAttendanceRecordVariables(memberId: memberId,day: day,checkIn: checkIn,checkOut: _checkOut,dayType: dayType,overtimeHours: overtimeHours,note: _note,);
    return _dataConnect.mutation("AddAttendanceRecord", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddAttendanceRecordAttendanceInsert {
  final String id;
  AddAttendanceRecordAttendanceInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddAttendanceRecordAttendanceInsert otherTyped = other as AddAttendanceRecordAttendanceInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddAttendanceRecordAttendanceInsert({
    required this.id,
  });
}

@immutable
class AddAttendanceRecordData {
  final AddAttendanceRecordAttendanceInsert attendance_insert;
  AddAttendanceRecordData.fromJson(dynamic json):
  
  attendance_insert = AddAttendanceRecordAttendanceInsert.fromJson(json['attendance_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddAttendanceRecordData otherTyped = other as AddAttendanceRecordData;
    return attendance_insert == otherTyped.attendance_insert;
    
  }
  @override
  int get hashCode => attendance_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['attendance_insert'] = attendance_insert.toJson();
    return json;
  }

  AddAttendanceRecordData({
    required this.attendance_insert,
  });
}

@immutable
class AddAttendanceRecordVariables {
  final String memberId;
  final DateTime day;
  final Timestamp checkIn;
  late final Optional<Timestamp>checkOut;
  final AttendanceDayType dayType;
  final double overtimeHours;
  late final Optional<String>note;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddAttendanceRecordVariables.fromJson(Map<String, dynamic> json):
  
  memberId = nativeFromJson<String>(json['memberId']),
  day = nativeFromJson<DateTime>(json['day']),
  checkIn = Timestamp.fromJson(json['checkIn']),
  dayType = AttendanceDayType.values.byName(json['dayType']),
  overtimeHours = nativeFromJson<double>(json['overtimeHours']) {
  
  
  
  
  
    checkOut = Optional.optional((json) => json['checkOut'] = Timestamp.fromJson(json['checkOut']), defaultSerializer);
    checkOut.value = json['checkOut'] == null ? null : Timestamp.fromJson(json['checkOut']);
  
  
  
  
    note = Optional.optional(nativeFromJson, nativeToJson);
    note.value = json['note'] == null ? null : nativeFromJson<String>(json['note']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddAttendanceRecordVariables otherTyped = other as AddAttendanceRecordVariables;
    return memberId == otherTyped.memberId && 
    day == otherTyped.day && 
    checkIn == otherTyped.checkIn && 
    checkOut == otherTyped.checkOut && 
    dayType == otherTyped.dayType && 
    overtimeHours == otherTyped.overtimeHours && 
    note == otherTyped.note;
    
  }
  @override
  int get hashCode => Object.hashAll([memberId.hashCode, day.hashCode, checkIn.hashCode, checkOut.hashCode, dayType.hashCode, overtimeHours.hashCode, note.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['memberId'] = nativeToJson<String>(memberId);
    json['day'] = nativeToJson<DateTime>(day);
    json['checkIn'] = checkIn.toJson();
    if(checkOut.state == OptionalState.set) {
      json['checkOut'] = checkOut.toJson();
    }
    json['dayType'] = 
    dayType.name
    ;
    json['overtimeHours'] = nativeToJson<double>(overtimeHours);
    if(note.state == OptionalState.set) {
      json['note'] = note.toJson();
    }
    return json;
  }

  AddAttendanceRecordVariables({
    required this.memberId,
    required this.day,
    required this.checkIn,
    required this.checkOut,
    required this.dayType,
    required this.overtimeHours,
    required this.note,
  });
}

