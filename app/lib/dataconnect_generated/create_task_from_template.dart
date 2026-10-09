part of 'sahakara.dart';

class CreateTaskFromTemplateVariablesBuilder {
  String templateId;
  DateTime dueDate;

  final FirebaseDataConnect _dataConnect;
  CreateTaskFromTemplateVariablesBuilder(this._dataConnect, {required  this.templateId,required  this.dueDate,});
  Deserializer<CreateTaskFromTemplateData> dataDeserializer = (dynamic json)  => CreateTaskFromTemplateData.fromJson(jsonDecode(json));
  Serializer<CreateTaskFromTemplateVariables> varsSerializer = (CreateTaskFromTemplateVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateTaskFromTemplateData, CreateTaskFromTemplateVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateTaskFromTemplateData, CreateTaskFromTemplateVariables> ref() {
    CreateTaskFromTemplateVariables vars= CreateTaskFromTemplateVariables(templateId: templateId,dueDate: dueDate,);
    return _dataConnect.mutation("CreateTaskFromTemplate", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateTaskFromTemplateTaskInsert {
  final String id;
  CreateTaskFromTemplateTaskInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTaskFromTemplateTaskInsert otherTyped = other as CreateTaskFromTemplateTaskInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateTaskFromTemplateTaskInsert({
    required this.id,
  });
}

@immutable
class CreateTaskFromTemplateData {
  final CreateTaskFromTemplateTaskInsert task_insert;
  CreateTaskFromTemplateData.fromJson(dynamic json):
  
  task_insert = CreateTaskFromTemplateTaskInsert.fromJson(json['task_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTaskFromTemplateData otherTyped = other as CreateTaskFromTemplateData;
    return task_insert == otherTyped.task_insert;
    
  }
  @override
  int get hashCode => task_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['task_insert'] = task_insert.toJson();
    return json;
  }

  CreateTaskFromTemplateData({
    required this.task_insert,
  });
}

@immutable
class CreateTaskFromTemplateVariables {
  final String templateId;
  final DateTime dueDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateTaskFromTemplateVariables.fromJson(Map<String, dynamic> json):
  
  templateId = nativeFromJson<String>(json['templateId']),
  dueDate = nativeFromJson<DateTime>(json['dueDate']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTaskFromTemplateVariables otherTyped = other as CreateTaskFromTemplateVariables;
    return templateId == otherTyped.templateId && 
    dueDate == otherTyped.dueDate;
    
  }
  @override
  int get hashCode => Object.hashAll([templateId.hashCode, dueDate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['templateId'] = nativeToJson<String>(templateId);
    json['dueDate'] = nativeToJson<DateTime>(dueDate);
    return json;
  }

  CreateTaskFromTemplateVariables({
    required this.templateId,
    required this.dueDate,
  });
}

