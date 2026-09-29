part of 'sahakara.dart';

class DeleteDailyTaskVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteDailyTaskVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteDailyTaskData> dataDeserializer = (dynamic json)  => DeleteDailyTaskData.fromJson(jsonDecode(json));
  Serializer<DeleteDailyTaskVariables> varsSerializer = (DeleteDailyTaskVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteDailyTaskData, DeleteDailyTaskVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteDailyTaskData, DeleteDailyTaskVariables> ref() {
    DeleteDailyTaskVariables vars= DeleteDailyTaskVariables(id: id,);
    return _dataConnect.mutation("DeleteDailyTask", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteDailyTaskTaskDelete {
  final String id;
  DeleteDailyTaskTaskDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteDailyTaskTaskDelete otherTyped = other as DeleteDailyTaskTaskDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteDailyTaskTaskDelete({
    required this.id,
  });
}

@immutable
class DeleteDailyTaskData {
  final DeleteDailyTaskTaskDelete? task_delete;
  final int taskTemplate_deleteMany;
  DeleteDailyTaskData.fromJson(dynamic json):
  
  task_delete = json['task_delete'] == null ? null : DeleteDailyTaskTaskDelete.fromJson(json['task_delete']),
  taskTemplate_deleteMany = nativeFromJson<int>(json['taskTemplate_deleteMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteDailyTaskData otherTyped = other as DeleteDailyTaskData;
    return task_delete == otherTyped.task_delete && 
    taskTemplate_deleteMany == otherTyped.taskTemplate_deleteMany;
    
  }
  @override
  int get hashCode => Object.hashAll([task_delete.hashCode, taskTemplate_deleteMany.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (task_delete != null) {
      json['task_delete'] = task_delete!.toJson();
    }
    json['taskTemplate_deleteMany'] = nativeToJson<int>(taskTemplate_deleteMany);
    return json;
  }

  DeleteDailyTaskData({
    this.task_delete,
    required this.taskTemplate_deleteMany,
  });
}

@immutable
class DeleteDailyTaskVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteDailyTaskVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteDailyTaskVariables otherTyped = other as DeleteDailyTaskVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteDailyTaskVariables({
    required this.id,
  });
}

