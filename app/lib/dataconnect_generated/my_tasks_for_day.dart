part of 'sahakara.dart';

class MyTasksForDayVariablesBuilder {
  DateTime dueDate;

  final FirebaseDataConnect _dataConnect;
  MyTasksForDayVariablesBuilder(this._dataConnect, {required  this.dueDate,});
  Deserializer<MyTasksForDayData> dataDeserializer = (dynamic json)  => MyTasksForDayData.fromJson(jsonDecode(json));
  Serializer<MyTasksForDayVariables> varsSerializer = (MyTasksForDayVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<MyTasksForDayData, MyTasksForDayVariables>> execute() {
    return ref().execute();
  }

  QueryRef<MyTasksForDayData, MyTasksForDayVariables> ref() {
    MyTasksForDayVariables vars= MyTasksForDayVariables(dueDate: dueDate,);
    return _dataConnect.query("MyTasksForDay", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class MyTasksForDayTasks {
  final String id;
  final EnumValue<TaskStatus> status;
  final EnumValue<CantDoReason>? cantDoReason;
  final Timestamp? completedAt;
  final MyTasksForDayTasksTemplate template;
  MyTasksForDayTasks.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  status = taskStatusDeserializer(json['status']),
  cantDoReason = json['cantDoReason'] == null ? null : cantDoReasonDeserializer(json['cantDoReason']),
  completedAt = json['completedAt'] == null ? null : Timestamp.fromJson(json['completedAt']),
  template = MyTasksForDayTasksTemplate.fromJson(json['template']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyTasksForDayTasks otherTyped = other as MyTasksForDayTasks;
    return id == otherTyped.id && 
    status == otherTyped.status && 
    cantDoReason == otherTyped.cantDoReason && 
    completedAt == otherTyped.completedAt && 
    template == otherTyped.template;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, status.hashCode, cantDoReason.hashCode, completedAt.hashCode, template.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['status'] = 
    taskStatusSerializer(status)
    ;
    if (cantDoReason != null) {
      json['cantDoReason'] = 
    cantDoReasonSerializer(cantDoReason!)
    ;
    }
    if (completedAt != null) {
      json['completedAt'] = completedAt!.toJson();
    }
    json['template'] = template.toJson();
    return json;
  }

  MyTasksForDayTasks({
    required this.id,
    required this.status,
    this.cantDoReason,
    this.completedAt,
    required this.template,
  });
}

@immutable
class MyTasksForDayTasksTemplate {
  final String? customTitle;
  final int? estMinutes;
  final EnumValue<TaskPriority> priority;
  final MyTasksForDayTasksTemplateLibrary? library;
  MyTasksForDayTasksTemplate.fromJson(dynamic json):
  
  customTitle = json['customTitle'] == null ? null : nativeFromJson<String>(json['customTitle']),
  estMinutes = json['estMinutes'] == null ? null : nativeFromJson<int>(json['estMinutes']),
  priority = taskPriorityDeserializer(json['priority']),
  library = json['library'] == null ? null : MyTasksForDayTasksTemplateLibrary.fromJson(json['library']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyTasksForDayTasksTemplate otherTyped = other as MyTasksForDayTasksTemplate;
    return customTitle == otherTyped.customTitle && 
    estMinutes == otherTyped.estMinutes && 
    priority == otherTyped.priority && 
    library == otherTyped.library;
    
  }
  @override
  int get hashCode => Object.hashAll([customTitle.hashCode, estMinutes.hashCode, priority.hashCode, library.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (customTitle != null) {
      json['customTitle'] = nativeToJson<String?>(customTitle);
    }
    if (estMinutes != null) {
      json['estMinutes'] = nativeToJson<int?>(estMinutes);
    }
    json['priority'] = 
    taskPrioritySerializer(priority)
    ;
    if (library != null) {
      json['library'] = library!.toJson();
    }
    return json;
  }

  MyTasksForDayTasksTemplate({
    this.customTitle,
    this.estMinutes,
    required this.priority,
    this.library,
  });
}

@immutable
class MyTasksForDayTasksTemplateLibrary {
  final EnumValue<TaskCategory> category;
  final String nameEn;
  final String? nameSi;
  final String? nameTa;
  MyTasksForDayTasksTemplateLibrary.fromJson(dynamic json):
  
  category = taskCategoryDeserializer(json['category']),
  nameEn = nativeFromJson<String>(json['nameEn']),
  nameSi = json['nameSi'] == null ? null : nativeFromJson<String>(json['nameSi']),
  nameTa = json['nameTa'] == null ? null : nativeFromJson<String>(json['nameTa']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyTasksForDayTasksTemplateLibrary otherTyped = other as MyTasksForDayTasksTemplateLibrary;
    return category == otherTyped.category && 
    nameEn == otherTyped.nameEn && 
    nameSi == otherTyped.nameSi && 
    nameTa == otherTyped.nameTa;
    
  }
  @override
  int get hashCode => Object.hashAll([category.hashCode, nameEn.hashCode, nameSi.hashCode, nameTa.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category'] = 
    taskCategorySerializer(category)
    ;
    json['nameEn'] = nativeToJson<String>(nameEn);
    if (nameSi != null) {
      json['nameSi'] = nativeToJson<String?>(nameSi);
    }
    if (nameTa != null) {
      json['nameTa'] = nativeToJson<String?>(nameTa);
    }
    return json;
  }

  MyTasksForDayTasksTemplateLibrary({
    required this.category,
    required this.nameEn,
    this.nameSi,
    this.nameTa,
  });
}

@immutable
class MyTasksForDayData {
  final List<MyTasksForDayTasks> tasks;
  MyTasksForDayData.fromJson(dynamic json):
  
  tasks = (json['tasks'] as List<dynamic>)
        .map((e) => MyTasksForDayTasks.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyTasksForDayData otherTyped = other as MyTasksForDayData;
    return tasks == otherTyped.tasks;
    
  }
  @override
  int get hashCode => tasks.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tasks'] = tasks.map((e) => e.toJson()).toList();
    return json;
  }

  MyTasksForDayData({
    required this.tasks,
  });
}

@immutable
class MyTasksForDayVariables {
  final DateTime dueDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  MyTasksForDayVariables.fromJson(Map<String, dynamic> json):
  
  dueDate = nativeFromJson<DateTime>(json['dueDate']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyTasksForDayVariables otherTyped = other as MyTasksForDayVariables;
    return dueDate == otherTyped.dueDate;
    
  }
  @override
  int get hashCode => dueDate.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['dueDate'] = nativeToJson<DateTime>(dueDate);
    return json;
  }

  MyTasksForDayVariables({
    required this.dueDate,
  });
}

