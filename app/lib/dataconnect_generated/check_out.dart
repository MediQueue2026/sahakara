part of 'sahakara.dart';

class CheckOutVariablesBuilder {
  String memberId;
  DateTime day;
  double overtimeHours;

  final FirebaseDataConnect _dataConnect;
  CheckOutVariablesBuilder(this._dataConnect, {required  this.memberId,required  this.day,required  this.overtimeHours,});
  Deserializer<CheckOutData> dataDeserializer = (dynamic json)  => CheckOutData.fromJson(jsonDecode(json));
  Serializer<CheckOutVariables> varsSerializer = (CheckOutVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CheckOutData, CheckOutVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CheckOutData, CheckOutVariables> ref() {
    CheckOutVariables vars= CheckOutVariables(memberId: memberId,day: day,overtimeHours: overtimeHours,);
    return _dataConnect.mutation("CheckOut", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CheckOutData {
  final int attendance_updateMany;
  CheckOutData.fromJson(dynamic json):
  
  attendance_updateMany = nativeFromJson<int>(json['attendance_updateMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CheckOutData otherTyped = other as CheckOutData;
    return attendance_updateMany == otherTyped.attendance_updateMany;
    
  }
  @override
  int get hashCode => attendance_updateMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['attendance_updateMany'] = nativeToJson<int>(attendance_updateMany);
    return json;
  }

  CheckOutData({
    required this.attendance_updateMany,
  });
}

@immutable
class CheckOutVariables {
  final String memberId;
  final DateTime day;
  final double overtimeHours;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CheckOutVariables.fromJson(Map<String, dynamic> json):
  
  memberId = nativeFromJson<String>(json['memberId']),
  day = nativeFromJson<DateTime>(json['day']),
  overtimeHours = nativeFromJson<double>(json['overtimeHours']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CheckOutVariables otherTyped = other as CheckOutVariables;
    return memberId == otherTyped.memberId && 
    day == otherTyped.day && 
    overtimeHours == otherTyped.overtimeHours;
    
  }
  @override
  int get hashCode => Object.hashAll([memberId.hashCode, day.hashCode, overtimeHours.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['memberId'] = nativeToJson<String>(memberId);
    json['day'] = nativeToJson<DateTime>(day);
    json['overtimeHours'] = nativeToJson<double>(overtimeHours);
    return json;
  }

  CheckOutVariables({
    required this.memberId,
    required this.day,
    required this.overtimeHours,
  });
}

