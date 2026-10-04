part of 'sahakara.dart';

class CheckOutVariablesBuilder {
  String memberId;
  DateTime day;

  final FirebaseDataConnect _dataConnect;
  CheckOutVariablesBuilder(this._dataConnect, {required  this.memberId,required  this.day,});
  Deserializer<CheckOutData> dataDeserializer = (dynamic json)  => CheckOutData.fromJson(jsonDecode(json));
  Serializer<CheckOutVariables> varsSerializer = (CheckOutVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CheckOutData, CheckOutVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CheckOutData, CheckOutVariables> ref() {
    CheckOutVariables vars= CheckOutVariables(memberId: memberId,day: day,);
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
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CheckOutVariables.fromJson(Map<String, dynamic> json):
  
  memberId = nativeFromJson<String>(json['memberId']),
  day = nativeFromJson<DateTime>(json['day']);
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
    day == otherTyped.day;
    
  }
  @override
  int get hashCode => Object.hashAll([memberId.hashCode, day.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['memberId'] = nativeToJson<String>(memberId);
    json['day'] = nativeToJson<DateTime>(day);
    return json;
  }

  CheckOutVariables({
    required this.memberId,
    required this.day,
  });
}

