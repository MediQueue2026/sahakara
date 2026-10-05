part of 'sahakara.dart';

class HouseholdTasksForDayVariablesBuilder {
  String householdId;
  DateTime dueDate;

  final FirebaseDataConnect _dataConnect;
  HouseholdTasksForDayVariablesBuilder(this._dataConnect, {required  this.householdId,required  this.dueDate,});
  Deserializer<HouseholdTasksForDayData> dataDeserializer = (dynamic json)  => HouseholdTasksForDayData.fromJson(jsonDecode(json));
  Serializer<HouseholdTasksForDayVariables> varsSerializer = (HouseholdTasksForDayVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<HouseholdTasksForDayData, HouseholdTasksForDayVariables>> execute() {
    return ref().execute();
  }

  QueryRef<HouseholdTasksForDayData, HouseholdTasksForDayVariables> ref() {
    HouseholdTasksForDayVariables vars= HouseholdTasksForDayVariables(householdId: householdId,dueDate: dueDate,);
    return _dataConnect.query("HouseholdTasksForDay", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class HouseholdTasksForDayTasks {
  final String id;
  final EnumValue<TaskStatus> status;
  final EnumValue<CantDoReason>? cantDoReason;
  final String? statusNote;
  final String? statusPhoto;
  final Timestamp? completedAt;
  final HouseholdTasksForDayTasksAssignedTo? assignedTo;
  final HouseholdTasksForDayTasksTemplate template;
  HouseholdTasksForDayTasks.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  status = taskStatusDeserializer(json['status']),
  cantDoReason = json['cantDoReason'] == null ? null : cantDoReasonDeserializer(json['cantDoReason']),
  statusNote = json['statusNote'] == null ? null : nativeFromJson<String>(json['statusNote']),
  statusPhoto = json['statusPhoto'] == null ? null : nativeFromJson<String>(json['statusPhoto']),
  completedAt = json['completedAt'] == null ? null : Timestamp.fromJson(json['completedAt']),
  assignedTo = json['assignedTo'] == null ? null : HouseholdTasksForDayTasksAssignedTo.fromJson(json['assignedTo']),
  template = HouseholdTasksForDayTasksTemplate.fromJson(json['template']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdTasksForDayTasks otherTyped = other as HouseholdTasksForDayTasks;
    return id == otherTyped.id && 
    status == otherTyped.status && 
    cantDoReason == otherTyped.cantDoReason && 
    statusNote == otherTyped.statusNote && 
    statusPhoto == otherTyped.statusPhoto && 
    completedAt == otherTyped.completedAt && 
    assignedTo == otherTyped.assignedTo && 
    template == otherTyped.template;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, status.hashCode, cantDoReason.hashCode, statusNote.hashCode, statusPhoto.hashCode, completedAt.hashCode, assignedTo.hashCode, template.hashCode]);
  

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
    if (statusNote != null) {
      json['statusNote'] = nativeToJson<String?>(statusNote);
    }
    if (statusPhoto != null) {
      json['statusPhoto'] = nativeToJson<String?>(statusPhoto);
    }
    if (completedAt != null) {
      json['completedAt'] = completedAt!.toJson();
    }
    if (assignedTo != null) {
      json['assignedTo'] = assignedTo!.toJson();
    }
    json['template'] = template.toJson();
    return json;
  }

  HouseholdTasksForDayTasks({
    required this.id,
    required this.status,
    this.cantDoReason,
    this.statusNote,
    this.statusPhoto,
    this.completedAt,
    this.assignedTo,
    required this.template,
  });
}

@immutable
class HouseholdTasksForDayTasksAssignedTo {
  final String id;
  final HouseholdTasksForDayTasksAssignedToUser user;
  HouseholdTasksForDayTasksAssignedTo.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  user = HouseholdTasksForDayTasksAssignedToUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdTasksForDayTasksAssignedTo otherTyped = other as HouseholdTasksForDayTasksAssignedTo;
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

  HouseholdTasksForDayTasksAssignedTo({
    required this.id,
    required this.user,
  });
}

@immutable
class HouseholdTasksForDayTasksAssignedToUser {
  final String name;
  HouseholdTasksForDayTasksAssignedToUser.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdTasksForDayTasksAssignedToUser otherTyped = other as HouseholdTasksForDayTasksAssignedToUser;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  HouseholdTasksForDayTasksAssignedToUser({
    required this.name,
  });
}

@immutable
class HouseholdTasksForDayTasksTemplate {
  final String? customTitle;
  final String? photoUrl;
  final int? estMinutes;
  final EnumValue<TaskPriority> priority;
  final HouseholdTasksForDayTasksTemplateLibrary? library;
  HouseholdTasksForDayTasksTemplate.fromJson(dynamic json):
  
  customTitle = json['customTitle'] == null ? null : nativeFromJson<String>(json['customTitle']),
  photoUrl = json['photoUrl'] == null ? null : nativeFromJson<String>(json['photoUrl']),
  estMinutes = json['estMinutes'] == null ? null : nativeFromJson<int>(json['estMinutes']),
  priority = taskPriorityDeserializer(json['priority']),
  library = json['library'] == null ? null : HouseholdTasksForDayTasksTemplateLibrary.fromJson(json['library']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdTasksForDayTasksTemplate otherTyped = other as HouseholdTasksForDayTasksTemplate;
    return customTitle == otherTyped.customTitle && 
    photoUrl == otherTyped.photoUrl && 
    estMinutes == otherTyped.estMinutes && 
    priority == otherTyped.priority && 
    library == otherTyped.library;
    
  }
  @override
  int get hashCode => Object.hashAll([customTitle.hashCode, photoUrl.hashCode, estMinutes.hashCode, priority.hashCode, library.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (customTitle != null) {
      json['customTitle'] = nativeToJson<String?>(customTitle);
    }
    if (photoUrl != null) {
      json['photoUrl'] = nativeToJson<String?>(photoUrl);
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

  HouseholdTasksForDayTasksTemplate({
    this.customTitle,
    this.photoUrl,
    this.estMinutes,
    required this.priority,
    this.library,
  });
}

@immutable
class HouseholdTasksForDayTasksTemplateLibrary {
  final EnumValue<TaskCategory> category;
  final String nameEn;
  final String? nameSi;
  final String? nameTa;
  HouseholdTasksForDayTasksTemplateLibrary.fromJson(dynamic json):
  
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

    final HouseholdTasksForDayTasksTemplateLibrary otherTyped = other as HouseholdTasksForDayTasksTemplateLibrary;
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

  HouseholdTasksForDayTasksTemplateLibrary({
    required this.category,
    required this.nameEn,
    this.nameSi,
    this.nameTa,
  });
}

@immutable
class HouseholdTasksForDayData {
  final List<HouseholdTasksForDayTasks> tasks;
  HouseholdTasksForDayData.fromJson(dynamic json):
  
  tasks = (json['tasks'] as List<dynamic>)
        .map((e) => HouseholdTasksForDayTasks.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdTasksForDayData otherTyped = other as HouseholdTasksForDayData;
    return tasks == otherTyped.tasks;
    
  }
  @override
  int get hashCode => tasks.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tasks'] = tasks.map((e) => e.toJson()).toList();
    return json;
  }

  HouseholdTasksForDayData({
    required this.tasks,
  });
}

@immutable
class HouseholdTasksForDayVariables {
  final String householdId;
  final DateTime dueDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  HouseholdTasksForDayVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']),
  dueDate = nativeFromJson<DateTime>(json['dueDate']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdTasksForDayVariables otherTyped = other as HouseholdTasksForDayVariables;
    return householdId == otherTyped.householdId && 
    dueDate == otherTyped.dueDate;
    
  }
  @override
  int get hashCode => Object.hashAll([householdId.hashCode, dueDate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    json['dueDate'] = nativeToJson<DateTime>(dueDate);
    return json;
  }

  HouseholdTasksForDayVariables({
    required this.householdId,
    required this.dueDate,
  });
}

