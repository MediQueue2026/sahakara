part of 'sahakara.dart';

class AssignDailyTaskVariablesBuilder {
  String id;
  String assignedToId;

  final FirebaseDataConnect _dataConnect;
  AssignDailyTaskVariablesBuilder(this._dataConnect, {required  this.id,required  this.assignedToId,});
  Deserializer<AssignDailyTaskData> dataDeserializer = (dynamic json)  => AssignDailyTaskData.fromJson(jsonDecode(json));
  Serializer<AssignDailyTaskVariables> varsSerializer = (AssignDailyTaskVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AssignDailyTaskData, AssignDailyTaskVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AssignDailyTaskData, AssignDailyTaskVariables> ref() {
    AssignDailyTaskVariables vars= AssignDailyTaskVariables(id: id,assignedToId: assignedToId,);
    return _dataConnect.mutation("AssignDailyTask", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AssignDailyTaskTaskUpdate {
  final String id;
  AssignDailyTaskTaskUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AssignDailyTaskTaskUpdate otherTyped = other as AssignDailyTaskTaskUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AssignDailyTaskTaskUpdate({
    required this.id,
  });
}

@immutable
class AssignDailyTaskData {
  final AssignDailyTaskTaskUpdate? task_update;
  AssignDailyTaskData.fromJson(dynamic json):
  
  task_update = json['task_update'] == null ? null : AssignDailyTaskTaskUpdate.fromJson(json['task_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AssignDailyTaskData otherTyped = other as AssignDailyTaskData;
    return task_update == otherTyped.task_update;
    
  }
  @override
  int get hashCode => task_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (task_update != null) {
      json['task_update'] = task_update!.toJson();
    }
    return json;
  }

  AssignDailyTaskData({
    this.task_update,
  });
}

@immutable
class AssignDailyTaskVariables {
  final String id;
  final String assignedToId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AssignDailyTaskVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  assignedToId = nativeFromJson<String>(json['assignedToId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AssignDailyTaskVariables otherTyped = other as AssignDailyTaskVariables;
    return id == otherTyped.id && 
    assignedToId == otherTyped.assignedToId;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, assignedToId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['assignedToId'] = nativeToJson<String>(assignedToId);
    return json;
  }

  AssignDailyTaskVariables({
    required this.id,
    required this.assignedToId,
  });
}

