part of 'sahakara.dart';

class UpdateAttendanceRecordVariablesBuilder {
  String id;
  Timestamp checkIn;
  Optional<Timestamp> _checkOut = Optional.optional((json) => json['checkOut'] = Timestamp.fromJson(json['checkOut']), defaultSerializer);
  AttendanceDayType dayType;
  double overtimeHours;
  Optional<String> _note = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateAttendanceRecordVariablesBuilder checkOut(Timestamp? t) {
   _checkOut.value = t;
   return this;
  }
  UpdateAttendanceRecordVariablesBuilder note(String? t) {
   _note.value = t;
   return this;
  }

  UpdateAttendanceRecordVariablesBuilder(this._dataConnect, {required  this.id,required  this.checkIn,required  this.dayType,required  this.overtimeHours,});
  Deserializer<UpdateAttendanceRecordData> dataDeserializer = (dynamic json)  => UpdateAttendanceRecordData.fromJson(jsonDecode(json));
  Serializer<UpdateAttendanceRecordVariables> varsSerializer = (UpdateAttendanceRecordVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateAttendanceRecordData, UpdateAttendanceRecordVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateAttendanceRecordData, UpdateAttendanceRecordVariables> ref() {
    UpdateAttendanceRecordVariables vars= UpdateAttendanceRecordVariables(id: id,checkIn: checkIn,checkOut: _checkOut,dayType: dayType,overtimeHours: overtimeHours,note: _note,);
    return _dataConnect.mutation("UpdateAttendanceRecord", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateAttendanceRecordAttendanceUpdate {
  final String id;
  UpdateAttendanceRecordAttendanceUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateAttendanceRecordAttendanceUpdate otherTyped = other as UpdateAttendanceRecordAttendanceUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateAttendanceRecordAttendanceUpdate({
    required this.id,
  });
}

@immutable
class UpdateAttendanceRecordData {
  final UpdateAttendanceRecordAttendanceUpdate? attendance_update;
  UpdateAttendanceRecordData.fromJson(dynamic json):
  
  attendance_update = json['attendance_update'] == null ? null : UpdateAttendanceRecordAttendanceUpdate.fromJson(json['attendance_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateAttendanceRecordData otherTyped = other as UpdateAttendanceRecordData;
    return attendance_update == otherTyped.attendance_update;
    
  }
  @override
  int get hashCode => attendance_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (attendance_update != null) {
      json['attendance_update'] = attendance_update!.toJson();
    }
    return json;
  }

  UpdateAttendanceRecordData({
    this.attendance_update,
  });
}

@immutable
class UpdateAttendanceRecordVariables {
  final String id;
  final Timestamp checkIn;
  late final Optional<Timestamp>checkOut;
  final AttendanceDayType dayType;
  final double overtimeHours;
  late final Optional<String>note;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateAttendanceRecordVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
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

    final UpdateAttendanceRecordVariables otherTyped = other as UpdateAttendanceRecordVariables;
    return id == otherTyped.id && 
    checkIn == otherTyped.checkIn && 
    checkOut == otherTyped.checkOut && 
    dayType == otherTyped.dayType && 
    overtimeHours == otherTyped.overtimeHours && 
    note == otherTyped.note;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, checkIn.hashCode, checkOut.hashCode, dayType.hashCode, overtimeHours.hashCode, note.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
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

  UpdateAttendanceRecordVariables({
    required this.id,
    required this.checkIn,
    required this.checkOut,
    required this.dayType,
    required this.overtimeHours,
    required this.note,
  });
}

