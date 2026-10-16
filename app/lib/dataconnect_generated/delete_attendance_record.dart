part of 'sahakara.dart';

class DeleteAttendanceRecordVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteAttendanceRecordVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteAttendanceRecordData> dataDeserializer = (dynamic json)  => DeleteAttendanceRecordData.fromJson(jsonDecode(json));
  Serializer<DeleteAttendanceRecordVariables> varsSerializer = (DeleteAttendanceRecordVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteAttendanceRecordData, DeleteAttendanceRecordVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteAttendanceRecordData, DeleteAttendanceRecordVariables> ref() {
    DeleteAttendanceRecordVariables vars= DeleteAttendanceRecordVariables(id: id,);
    return _dataConnect.mutation("DeleteAttendanceRecord", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteAttendanceRecordAttendanceDelete {
  final String id;
  DeleteAttendanceRecordAttendanceDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteAttendanceRecordAttendanceDelete otherTyped = other as DeleteAttendanceRecordAttendanceDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteAttendanceRecordAttendanceDelete({
    required this.id,
  });
}

@immutable
class DeleteAttendanceRecordData {
  final DeleteAttendanceRecordAttendanceDelete? attendance_delete;
  DeleteAttendanceRecordData.fromJson(dynamic json):
  
  attendance_delete = json['attendance_delete'] == null ? null : DeleteAttendanceRecordAttendanceDelete.fromJson(json['attendance_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteAttendanceRecordData otherTyped = other as DeleteAttendanceRecordData;
    return attendance_delete == otherTyped.attendance_delete;
    
  }
  @override
  int get hashCode => attendance_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (attendance_delete != null) {
      json['attendance_delete'] = attendance_delete!.toJson();
    }
    return json;
  }

  DeleteAttendanceRecordData({
    this.attendance_delete,
  });
}

@immutable
class DeleteAttendanceRecordVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteAttendanceRecordVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteAttendanceRecordVariables otherTyped = other as DeleteAttendanceRecordVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteAttendanceRecordVariables({
    required this.id,
  });
}

