part of 'sahakara.dart';

class DeleteLeaveRequestVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteLeaveRequestVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteLeaveRequestData> dataDeserializer = (dynamic json)  => DeleteLeaveRequestData.fromJson(jsonDecode(json));
  Serializer<DeleteLeaveRequestVariables> varsSerializer = (DeleteLeaveRequestVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteLeaveRequestData, DeleteLeaveRequestVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteLeaveRequestData, DeleteLeaveRequestVariables> ref() {
    DeleteLeaveRequestVariables vars= DeleteLeaveRequestVariables(id: id,);
    return _dataConnect.mutation("DeleteLeaveRequest", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteLeaveRequestLeaveRequestDelete {
  final String id;
  DeleteLeaveRequestLeaveRequestDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteLeaveRequestLeaveRequestDelete otherTyped = other as DeleteLeaveRequestLeaveRequestDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteLeaveRequestLeaveRequestDelete({
    required this.id,
  });
}

@immutable
class DeleteLeaveRequestData {
  final DeleteLeaveRequestLeaveRequestDelete? leaveRequest_delete;
  DeleteLeaveRequestData.fromJson(dynamic json):
  
  leaveRequest_delete = json['leaveRequest_delete'] == null ? null : DeleteLeaveRequestLeaveRequestDelete.fromJson(json['leaveRequest_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteLeaveRequestData otherTyped = other as DeleteLeaveRequestData;
    return leaveRequest_delete == otherTyped.leaveRequest_delete;
    
  }
  @override
  int get hashCode => leaveRequest_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (leaveRequest_delete != null) {
      json['leaveRequest_delete'] = leaveRequest_delete!.toJson();
    }
    return json;
  }

  DeleteLeaveRequestData({
    this.leaveRequest_delete,
  });
}

@immutable
class DeleteLeaveRequestVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteLeaveRequestVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteLeaveRequestVariables otherTyped = other as DeleteLeaveRequestVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteLeaveRequestVariables({
    required this.id,
  });
}

