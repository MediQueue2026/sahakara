part of 'sahakara.dart';

class HouseholdAttendanceVariablesBuilder {
  String householdId;

  final FirebaseDataConnect _dataConnect;
  HouseholdAttendanceVariablesBuilder(this._dataConnect, {required  this.householdId,});
  Deserializer<HouseholdAttendanceData> dataDeserializer = (dynamic json)  => HouseholdAttendanceData.fromJson(jsonDecode(json));
  Serializer<HouseholdAttendanceVariables> varsSerializer = (HouseholdAttendanceVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<HouseholdAttendanceData, HouseholdAttendanceVariables>> execute() {
    return ref().execute();
  }

  QueryRef<HouseholdAttendanceData, HouseholdAttendanceVariables> ref() {
    HouseholdAttendanceVariables vars= HouseholdAttendanceVariables(householdId: householdId,);
    return _dataConnect.query("HouseholdAttendance", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class HouseholdAttendanceAttendances {
  final String id;
  final DateTime day;
  final Timestamp? checkIn;
  final Timestamp? checkOut;
  final EnumValue<AttendanceDayType> dayType;
  final double overtimeHours;
  final String? note;
  final HouseholdAttendanceAttendancesMember member;
  HouseholdAttendanceAttendances.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  day = nativeFromJson<DateTime>(json['day']),
  checkIn = json['checkIn'] == null ? null : Timestamp.fromJson(json['checkIn']),
  checkOut = json['checkOut'] == null ? null : Timestamp.fromJson(json['checkOut']),
  dayType = attendanceDayTypeDeserializer(json['dayType']),
  overtimeHours = nativeFromJson<double>(json['overtimeHours']),
  note = json['note'] == null ? null : nativeFromJson<String>(json['note']),
  member = HouseholdAttendanceAttendancesMember.fromJson(json['member']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdAttendanceAttendances otherTyped = other as HouseholdAttendanceAttendances;
    return id == otherTyped.id && 
    day == otherTyped.day && 
    checkIn == otherTyped.checkIn && 
    checkOut == otherTyped.checkOut && 
    dayType == otherTyped.dayType && 
    overtimeHours == otherTyped.overtimeHours && 
    note == otherTyped.note && 
    member == otherTyped.member;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, day.hashCode, checkIn.hashCode, checkOut.hashCode, dayType.hashCode, overtimeHours.hashCode, note.hashCode, member.hashCode]);
  

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
    json['member'] = member.toJson();
    return json;
  }

  HouseholdAttendanceAttendances({
    required this.id,
    required this.day,
    this.checkIn,
    this.checkOut,
    required this.dayType,
    required this.overtimeHours,
    this.note,
    required this.member,
  });
}

@immutable
class HouseholdAttendanceAttendancesMember {
  final String id;
  final HouseholdAttendanceAttendancesMemberUser user;
  HouseholdAttendanceAttendancesMember.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  user = HouseholdAttendanceAttendancesMemberUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdAttendanceAttendancesMember otherTyped = other as HouseholdAttendanceAttendancesMember;
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

  HouseholdAttendanceAttendancesMember({
    required this.id,
    required this.user,
  });
}

@immutable
class HouseholdAttendanceAttendancesMemberUser {
  final String name;
  HouseholdAttendanceAttendancesMemberUser.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdAttendanceAttendancesMemberUser otherTyped = other as HouseholdAttendanceAttendancesMemberUser;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  HouseholdAttendanceAttendancesMemberUser({
    required this.name,
  });
}

@immutable
class HouseholdAttendanceData {
  final List<HouseholdAttendanceAttendances> attendances;
  HouseholdAttendanceData.fromJson(dynamic json):
  
  attendances = (json['attendances'] as List<dynamic>)
        .map((e) => HouseholdAttendanceAttendances.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdAttendanceData otherTyped = other as HouseholdAttendanceData;
    return attendances == otherTyped.attendances;
    
  }
  @override
  int get hashCode => attendances.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['attendances'] = attendances.map((e) => e.toJson()).toList();
    return json;
  }

  HouseholdAttendanceData({
    required this.attendances,
  });
}

@immutable
class HouseholdAttendanceVariables {
  final String householdId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  HouseholdAttendanceVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdAttendanceVariables otherTyped = other as HouseholdAttendanceVariables;
    return householdId == otherTyped.householdId;
    
  }
  @override
  int get hashCode => householdId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    return json;
  }

  HouseholdAttendanceVariables({
    required this.householdId,
  });
}

