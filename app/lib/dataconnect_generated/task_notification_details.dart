part of 'sahakara.dart';

class TaskNotificationDetailsVariablesBuilder {
  String taskId;

  final FirebaseDataConnect _dataConnect;
  TaskNotificationDetailsVariablesBuilder(this._dataConnect, {required  this.taskId,});
  Deserializer<TaskNotificationDetailsData> dataDeserializer = (dynamic json)  => TaskNotificationDetailsData.fromJson(jsonDecode(json));
  Serializer<TaskNotificationDetailsVariables> varsSerializer = (TaskNotificationDetailsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<TaskNotificationDetailsData, TaskNotificationDetailsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<TaskNotificationDetailsData, TaskNotificationDetailsVariables> ref() {
    TaskNotificationDetailsVariables vars= TaskNotificationDetailsVariables(taskId: taskId,);
    return _dataConnect.query("TaskNotificationDetails", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class TaskNotificationDetailsTasks {
  final String id;
  final TaskNotificationDetailsTasksAssignedTo? assignedTo;
  final TaskNotificationDetailsTasksTemplate template;
  TaskNotificationDetailsTasks.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  assignedTo = json['assignedTo'] == null ? null : TaskNotificationDetailsTasksAssignedTo.fromJson(json['assignedTo']),
  template = TaskNotificationDetailsTasksTemplate.fromJson(json['template']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final TaskNotificationDetailsTasks otherTyped = other as TaskNotificationDetailsTasks;
    return id == otherTyped.id && 
    assignedTo == otherTyped.assignedTo && 
    template == otherTyped.template;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, assignedTo.hashCode, template.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (assignedTo != null) {
      json['assignedTo'] = assignedTo!.toJson();
    }
    json['template'] = template.toJson();
    return json;
  }

  TaskNotificationDetailsTasks({
    required this.id,
    this.assignedTo,
    required this.template,
  });
}

@immutable
class TaskNotificationDetailsTasksAssignedTo {
  final String id;
  final TaskNotificationDetailsTasksAssignedToUser user;
  TaskNotificationDetailsTasksAssignedTo.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  user = TaskNotificationDetailsTasksAssignedToUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final TaskNotificationDetailsTasksAssignedTo otherTyped = other as TaskNotificationDetailsTasksAssignedTo;
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

  TaskNotificationDetailsTasksAssignedTo({
    required this.id,
    required this.user,
  });
}

@immutable
class TaskNotificationDetailsTasksAssignedToUser {
  final EnumValue<AppLanguage> language;
  final List<TaskNotificationDetailsTasksAssignedToUserUserDeviceTokensOnUser> userDeviceTokens_on_user;
  TaskNotificationDetailsTasksAssignedToUser.fromJson(dynamic json):
  
  language = appLanguageDeserializer(json['language']),
  userDeviceTokens_on_user = (json['userDeviceTokens_on_user'] as List<dynamic>)
        .map((e) => TaskNotificationDetailsTasksAssignedToUserUserDeviceTokensOnUser.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final TaskNotificationDetailsTasksAssignedToUser otherTyped = other as TaskNotificationDetailsTasksAssignedToUser;
    return language == otherTyped.language && 
    userDeviceTokens_on_user == otherTyped.userDeviceTokens_on_user;
    
  }
  @override
  int get hashCode => Object.hashAll([language.hashCode, userDeviceTokens_on_user.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['language'] = 
    appLanguageSerializer(language)
    ;
    json['userDeviceTokens_on_user'] = userDeviceTokens_on_user.map((e) => e.toJson()).toList();
    return json;
  }

  TaskNotificationDetailsTasksAssignedToUser({
    required this.language,
    required this.userDeviceTokens_on_user,
  });
}

@immutable
class TaskNotificationDetailsTasksAssignedToUserUserDeviceTokensOnUser {
  final String token;
  TaskNotificationDetailsTasksAssignedToUserUserDeviceTokensOnUser.fromJson(dynamic json):
  
  token = nativeFromJson<String>(json['token']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final TaskNotificationDetailsTasksAssignedToUserUserDeviceTokensOnUser otherTyped = other as TaskNotificationDetailsTasksAssignedToUserUserDeviceTokensOnUser;
    return token == otherTyped.token;
    
  }
  @override
  int get hashCode => token.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['token'] = nativeToJson<String>(token);
    return json;
  }

  TaskNotificationDetailsTasksAssignedToUserUserDeviceTokensOnUser({
    required this.token,
  });
}

@immutable
class TaskNotificationDetailsTasksTemplate {
  final String? customTitle;
  final String? customTitleSi;
  final String? customTitleTa;
  final TaskNotificationDetailsTasksTemplateLibrary? library;
  final TaskNotificationDetailsTasksTemplateHousehold household;
  TaskNotificationDetailsTasksTemplate.fromJson(dynamic json):
  
  customTitle = json['customTitle'] == null ? null : nativeFromJson<String>(json['customTitle']),
  customTitleSi = json['customTitleSi'] == null ? null : nativeFromJson<String>(json['customTitleSi']),
  customTitleTa = json['customTitleTa'] == null ? null : nativeFromJson<String>(json['customTitleTa']),
  library = json['library'] == null ? null : TaskNotificationDetailsTasksTemplateLibrary.fromJson(json['library']),
  household = TaskNotificationDetailsTasksTemplateHousehold.fromJson(json['household']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final TaskNotificationDetailsTasksTemplate otherTyped = other as TaskNotificationDetailsTasksTemplate;
    return customTitle == otherTyped.customTitle && 
    customTitleSi == otherTyped.customTitleSi && 
    customTitleTa == otherTyped.customTitleTa && 
    library == otherTyped.library && 
    household == otherTyped.household;
    
  }
  @override
  int get hashCode => Object.hashAll([customTitle.hashCode, customTitleSi.hashCode, customTitleTa.hashCode, library.hashCode, household.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (customTitle != null) {
      json['customTitle'] = nativeToJson<String?>(customTitle);
    }
    if (customTitleSi != null) {
      json['customTitleSi'] = nativeToJson<String?>(customTitleSi);
    }
    if (customTitleTa != null) {
      json['customTitleTa'] = nativeToJson<String?>(customTitleTa);
    }
    if (library != null) {
      json['library'] = library!.toJson();
    }
    json['household'] = household.toJson();
    return json;
  }

  TaskNotificationDetailsTasksTemplate({
    this.customTitle,
    this.customTitleSi,
    this.customTitleTa,
    this.library,
    required this.household,
  });
}

@immutable
class TaskNotificationDetailsTasksTemplateLibrary {
  final String nameEn;
  final String? nameSi;
  final String? nameTa;
  TaskNotificationDetailsTasksTemplateLibrary.fromJson(dynamic json):
  
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

    final TaskNotificationDetailsTasksTemplateLibrary otherTyped = other as TaskNotificationDetailsTasksTemplateLibrary;
    return nameEn == otherTyped.nameEn && 
    nameSi == otherTyped.nameSi && 
    nameTa == otherTyped.nameTa;
    
  }
  @override
  int get hashCode => Object.hashAll([nameEn.hashCode, nameSi.hashCode, nameTa.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nameEn'] = nativeToJson<String>(nameEn);
    if (nameSi != null) {
      json['nameSi'] = nativeToJson<String?>(nameSi);
    }
    if (nameTa != null) {
      json['nameTa'] = nativeToJson<String?>(nameTa);
    }
    return json;
  }

  TaskNotificationDetailsTasksTemplateLibrary({
    required this.nameEn,
    this.nameSi,
    this.nameTa,
  });
}

@immutable
class TaskNotificationDetailsTasksTemplateHousehold {
  final String name;
  TaskNotificationDetailsTasksTemplateHousehold.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final TaskNotificationDetailsTasksTemplateHousehold otherTyped = other as TaskNotificationDetailsTasksTemplateHousehold;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  TaskNotificationDetailsTasksTemplateHousehold({
    required this.name,
  });
}

@immutable
class TaskNotificationDetailsData {
  final List<TaskNotificationDetailsTasks> tasks;
  TaskNotificationDetailsData.fromJson(dynamic json):
  
  tasks = (json['tasks'] as List<dynamic>)
        .map((e) => TaskNotificationDetailsTasks.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final TaskNotificationDetailsData otherTyped = other as TaskNotificationDetailsData;
    return tasks == otherTyped.tasks;
    
  }
  @override
  int get hashCode => tasks.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tasks'] = tasks.map((e) => e.toJson()).toList();
    return json;
  }

  TaskNotificationDetailsData({
    required this.tasks,
  });
}

@immutable
class TaskNotificationDetailsVariables {
  final String taskId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  TaskNotificationDetailsVariables.fromJson(Map<String, dynamic> json):
  
  taskId = nativeFromJson<String>(json['taskId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final TaskNotificationDetailsVariables otherTyped = other as TaskNotificationDetailsVariables;
    return taskId == otherTyped.taskId;
    
  }
  @override
  int get hashCode => taskId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['taskId'] = nativeToJson<String>(taskId);
    return json;
  }

  TaskNotificationDetailsVariables({
    required this.taskId,
  });
}

