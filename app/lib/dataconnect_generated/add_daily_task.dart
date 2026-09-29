part of 'sahakara.dart';

class AddDailyTaskVariablesBuilder {
  String householdId;
  Optional<String> _assignedToId = Optional.optional(nativeFromJson, nativeToJson);
  DateTime dueDate;
  Optional<String> _libraryId = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _customTitle = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _estMinutes = Optional.optional(nativeFromJson, nativeToJson);
  TaskPriority priority;

  final FirebaseDataConnect _dataConnect;  AddDailyTaskVariablesBuilder assignedToId(String? t) {
   _assignedToId.value = t;
   return this;
  }
  AddDailyTaskVariablesBuilder libraryId(String? t) {
   _libraryId.value = t;
   return this;
  }
  AddDailyTaskVariablesBuilder customTitle(String? t) {
   _customTitle.value = t;
   return this;
  }
  AddDailyTaskVariablesBuilder estMinutes(int? t) {
   _estMinutes.value = t;
   return this;
  }

  AddDailyTaskVariablesBuilder(this._dataConnect, {required  this.householdId,required  this.dueDate,required  this.priority,});
  Deserializer<AddDailyTaskData> dataDeserializer = (dynamic json)  => AddDailyTaskData.fromJson(jsonDecode(json));
  Serializer<AddDailyTaskVariables> varsSerializer = (AddDailyTaskVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddDailyTaskData, AddDailyTaskVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddDailyTaskData, AddDailyTaskVariables> ref() {
    AddDailyTaskVariables vars= AddDailyTaskVariables(householdId: householdId,assignedToId: _assignedToId,dueDate: dueDate,libraryId: _libraryId,customTitle: _customTitle,estMinutes: _estMinutes,priority: priority,);
    return _dataConnect.mutation("AddDailyTask", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddDailyTaskTaskTemplateInsert {
  final String id;
  AddDailyTaskTaskTemplateInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddDailyTaskTaskTemplateInsert otherTyped = other as AddDailyTaskTaskTemplateInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddDailyTaskTaskTemplateInsert({
    required this.id,
  });
}

@immutable
class AddDailyTaskTaskInsert {
  final String id;
  AddDailyTaskTaskInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddDailyTaskTaskInsert otherTyped = other as AddDailyTaskTaskInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddDailyTaskTaskInsert({
    required this.id,
  });
}

@immutable
class AddDailyTaskData {
  final AddDailyTaskTaskTemplateInsert taskTemplate_insert;
  final AddDailyTaskTaskInsert task_insert;
  AddDailyTaskData.fromJson(dynamic json):
  
  taskTemplate_insert = AddDailyTaskTaskTemplateInsert.fromJson(json['taskTemplate_insert']),
  task_insert = AddDailyTaskTaskInsert.fromJson(json['task_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddDailyTaskData otherTyped = other as AddDailyTaskData;
    return taskTemplate_insert == otherTyped.taskTemplate_insert && 
    task_insert == otherTyped.task_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([taskTemplate_insert.hashCode, task_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['taskTemplate_insert'] = taskTemplate_insert.toJson();
    json['task_insert'] = task_insert.toJson();
    return json;
  }

  AddDailyTaskData({
    required this.taskTemplate_insert,
    required this.task_insert,
  });
}

@immutable
class AddDailyTaskVariables {
  final String householdId;
  late final Optional<String>assignedToId;
  final DateTime dueDate;
  late final Optional<String>libraryId;
  late final Optional<String>customTitle;
  late final Optional<int>estMinutes;
  final TaskPriority priority;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddDailyTaskVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']),
  dueDate = nativeFromJson<DateTime>(json['dueDate']),
  priority = TaskPriority.values.byName(json['priority']) {
  
  
  
    assignedToId = Optional.optional(nativeFromJson, nativeToJson);
    assignedToId.value = json['assignedToId'] == null ? null : nativeFromJson<String>(json['assignedToId']);
  
  
  
    libraryId = Optional.optional(nativeFromJson, nativeToJson);
    libraryId.value = json['libraryId'] == null ? null : nativeFromJson<String>(json['libraryId']);
  
  
    customTitle = Optional.optional(nativeFromJson, nativeToJson);
    customTitle.value = json['customTitle'] == null ? null : nativeFromJson<String>(json['customTitle']);
  
  
    estMinutes = Optional.optional(nativeFromJson, nativeToJson);
    estMinutes.value = json['estMinutes'] == null ? null : nativeFromJson<int>(json['estMinutes']);
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddDailyTaskVariables otherTyped = other as AddDailyTaskVariables;
    return householdId == otherTyped.householdId && 
    assignedToId == otherTyped.assignedToId && 
    dueDate == otherTyped.dueDate && 
    libraryId == otherTyped.libraryId && 
    customTitle == otherTyped.customTitle && 
    estMinutes == otherTyped.estMinutes && 
    priority == otherTyped.priority;
    
  }
  @override
  int get hashCode => Object.hashAll([householdId.hashCode, assignedToId.hashCode, dueDate.hashCode, libraryId.hashCode, customTitle.hashCode, estMinutes.hashCode, priority.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    if(assignedToId.state == OptionalState.set) {
      json['assignedToId'] = assignedToId.toJson();
    }
    json['dueDate'] = nativeToJson<DateTime>(dueDate);
    if(libraryId.state == OptionalState.set) {
      json['libraryId'] = libraryId.toJson();
    }
    if(customTitle.state == OptionalState.set) {
      json['customTitle'] = customTitle.toJson();
    }
    if(estMinutes.state == OptionalState.set) {
      json['estMinutes'] = estMinutes.toJson();
    }
    json['priority'] = 
    priority.name
    ;
    return json;
  }

  AddDailyTaskVariables({
    required this.householdId,
    required this.assignedToId,
    required this.dueDate,
    required this.libraryId,
    required this.customTitle,
    required this.estMinutes,
    required this.priority,
  });
}

