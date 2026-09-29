part of 'sahakara.dart';

class UpdateMyTaskStatusVariablesBuilder {
  String id;
  TaskStatus status;
  TaskLogAction action;
  Optional<CantDoReason> _cantDoReason = Optional.optional((data) => CantDoReason.values.byName(data), enumSerializer);

  final FirebaseDataConnect _dataConnect;  UpdateMyTaskStatusVariablesBuilder cantDoReason(CantDoReason? t) {
   _cantDoReason.value = t;
   return this;
  }

  UpdateMyTaskStatusVariablesBuilder(this._dataConnect, {required  this.id,required  this.status,required  this.action,});
  Deserializer<UpdateMyTaskStatusData> dataDeserializer = (dynamic json)  => UpdateMyTaskStatusData.fromJson(jsonDecode(json));
  Serializer<UpdateMyTaskStatusVariables> varsSerializer = (UpdateMyTaskStatusVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMyTaskStatusData, UpdateMyTaskStatusVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMyTaskStatusData, UpdateMyTaskStatusVariables> ref() {
    UpdateMyTaskStatusVariables vars= UpdateMyTaskStatusVariables(id: id,status: status,action: action,cantDoReason: _cantDoReason,);
    return _dataConnect.mutation("UpdateMyTaskStatus", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMyTaskStatusTaskUpdate {
  final String id;
  UpdateMyTaskStatusTaskUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMyTaskStatusTaskUpdate otherTyped = other as UpdateMyTaskStatusTaskUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMyTaskStatusTaskUpdate({
    required this.id,
  });
}

@immutable
class UpdateMyTaskStatusTaskLogInsert {
  final String id;
  UpdateMyTaskStatusTaskLogInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMyTaskStatusTaskLogInsert otherTyped = other as UpdateMyTaskStatusTaskLogInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMyTaskStatusTaskLogInsert({
    required this.id,
  });
}

@immutable
class UpdateMyTaskStatusData {
  final UpdateMyTaskStatusTaskUpdate? task_update;
  final int done;
  final int notDone;
  final UpdateMyTaskStatusTaskLogInsert taskLog_insert;
  UpdateMyTaskStatusData.fromJson(dynamic json):
  
  task_update = json['task_update'] == null ? null : UpdateMyTaskStatusTaskUpdate.fromJson(json['task_update']),
  done = nativeFromJson<int>(json['done']),
  notDone = nativeFromJson<int>(json['notDone']),
  taskLog_insert = UpdateMyTaskStatusTaskLogInsert.fromJson(json['taskLog_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMyTaskStatusData otherTyped = other as UpdateMyTaskStatusData;
    return task_update == otherTyped.task_update && 
    done == otherTyped.done && 
    notDone == otherTyped.notDone && 
    taskLog_insert == otherTyped.taskLog_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([task_update.hashCode, done.hashCode, notDone.hashCode, taskLog_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (task_update != null) {
      json['task_update'] = task_update!.toJson();
    }
    json['done'] = nativeToJson<int>(done);
    json['notDone'] = nativeToJson<int>(notDone);
    json['taskLog_insert'] = taskLog_insert.toJson();
    return json;
  }

  UpdateMyTaskStatusData({
    this.task_update,
    required this.done,
    required this.notDone,
    required this.taskLog_insert,
  });
}

@immutable
class UpdateMyTaskStatusVariables {
  final String id;
  final TaskStatus status;
  final TaskLogAction action;
  late final Optional<CantDoReason>cantDoReason;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMyTaskStatusVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  status = TaskStatus.values.byName(json['status']),
  action = TaskLogAction.values.byName(json['action']) {
  
  
  
  
  
    cantDoReason = Optional.optional((data) => CantDoReason.values.byName(data), enumSerializer);
    cantDoReason.value = json['cantDoReason'] == null ? null : CantDoReason.values.byName(json['cantDoReason']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMyTaskStatusVariables otherTyped = other as UpdateMyTaskStatusVariables;
    return id == otherTyped.id && 
    status == otherTyped.status && 
    action == otherTyped.action && 
    cantDoReason == otherTyped.cantDoReason;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, status.hashCode, action.hashCode, cantDoReason.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['status'] = 
    status.name
    ;
    json['action'] = 
    action.name
    ;
    if(cantDoReason.state == OptionalState.set) {
      json['cantDoReason'] = cantDoReason.toJson();
    }
    return json;
  }

  UpdateMyTaskStatusVariables({
    required this.id,
    required this.status,
    required this.action,
    required this.cantDoReason,
  });
}

