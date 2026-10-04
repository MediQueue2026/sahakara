part of 'sahakara.dart';

class MyAttendanceVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MyAttendanceVariablesBuilder(this._dataConnect, );
  Deserializer<MyAttendanceData> dataDeserializer = (dynamic json)  => MyAttendanceData.fromJson(jsonDecode(json));
  
  Future<QueryResult<MyAttendanceData, void>> execute() {
    return ref().execute();
  }

  QueryRef<MyAttendanceData, void> ref() {
    
    return _dataConnect.query("MyAttendance", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class MyAttendanceAttendances {
  final String id;
  final DateTime day;
  final Timestamp? checkIn;
  final Timestamp? checkOut;
  final EnumValue<AttendanceDayType> dayType;
  final double overtimeHours;
  final String? note;
  MyAttendanceAttendances.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  day = nativeFromJson<DateTime>(json['day']),
  checkIn = json['checkIn'] == null ? null : Timestamp.fromJson(json['checkIn']),
  checkOut = json['checkOut'] == null ? null : Timestamp.fromJson(json['checkOut']),
  dayType = attendanceDayTypeDeserializer(json['dayType']),
  overtimeHours = nativeFromJson<double>(json['overtimeHours']),
  note = json['note'] == null ? null : nativeFromJson<String>(json['note']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyAttendanceAttendances otherTyped = other as MyAttendanceAttendances;
    return id == otherTyped.id && 
    day == otherTyped.day && 
    checkIn == otherTyped.checkIn && 
    checkOut == otherTyped.checkOut && 
    dayType == otherTyped.dayType && 
    overtimeHours == otherTyped.overtimeHours && 
    note == otherTyped.note;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, day.hashCode, checkIn.hashCode, checkOut.hashCode, dayType.hashCode, overtimeHours.hashCode, note.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['day'] = nativeToJson<DateTime>(day);
    if (checkIn != null) {
      json['checkIn'] = checkIn!.toJson();
    }
    if (checkOut != null) {
      json['checkOut'] = checkOut!.toJson();
    }
    json['dayType'] = 
    attendanceDayTypeSerializer(dayType)
    ;
    json['overtimeHours'] = nativeToJson<double>(overtimeHours);
    if (note != null) {
      json['note'] = nativeToJson<String?>(note);
    }
    return json;
  }

  MyAttendanceAttendances({
    required this.id,
    required this.day,
    this.checkIn,
    this.checkOut,
    required this.dayType,
    required this.overtimeHours,
    this.note,
  });
}

@immutable
class MyAttendanceData {
  final List<MyAttendanceAttendances> attendances;
  MyAttendanceData.fromJson(dynamic json):
  
  attendances = (json['attendances'] as List<dynamic>)
        .map((e) => MyAttendanceAttendances.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyAttendanceData otherTyped = other as MyAttendanceData;
    return attendances == otherTyped.attendances;
    
  }
  @override
  int get hashCode => attendances.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['attendances'] = attendances.map((e) => e.toJson()).toList();
    return json;
  }

  MyAttendanceData({
    required this.attendances,
  });
}

