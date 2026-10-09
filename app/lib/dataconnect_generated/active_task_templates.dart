part of 'sahakara.dart';

class ActiveTaskTemplatesVariablesBuilder {
  String householdId;

  final FirebaseDataConnect _dataConnect;
  ActiveTaskTemplatesVariablesBuilder(this._dataConnect, {required  this.householdId,});
  Deserializer<ActiveTaskTemplatesData> dataDeserializer = (dynamic json)  => ActiveTaskTemplatesData.fromJson(jsonDecode(json));
  Serializer<ActiveTaskTemplatesVariables> varsSerializer = (ActiveTaskTemplatesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ActiveTaskTemplatesData, ActiveTaskTemplatesVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ActiveTaskTemplatesData, ActiveTaskTemplatesVariables> ref() {
    ActiveTaskTemplatesVariables vars= ActiveTaskTemplatesVariables(householdId: householdId,);
    return _dataConnect.query("ActiveTaskTemplates", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ActiveTaskTemplatesTaskTemplates {
  final String id;
  final EnumValue<RecurrenceType> recurrence;
  final String? recurrenceDay;
  ActiveTaskTemplatesTaskTemplates.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  recurrence = recurrenceTypeDeserializer(json['recurrence']),
  recurrenceDay = json['recurrenceDay'] == null ? null : nativeFromJson<String>(json['recurrenceDay']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ActiveTaskTemplatesTaskTemplates otherTyped = other as ActiveTaskTemplatesTaskTemplates;
    return id == otherTyped.id && 
    recurrence == otherTyped.recurrence && 
    recurrenceDay == otherTyped.recurrenceDay;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, recurrence.hashCode, recurrenceDay.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['recurrence'] = 
    recurrenceTypeSerializer(recurrence)
    ;
    if (recurrenceDay != null) {
      json['recurrenceDay'] = nativeToJson<String?>(recurrenceDay);
    }
    return json;
  }

  ActiveTaskTemplatesTaskTemplates({
    required this.id,
    required this.recurrence,
    this.recurrenceDay,
  });
}

@immutable
class ActiveTaskTemplatesData {
  final List<ActiveTaskTemplatesTaskTemplates> taskTemplates;
  ActiveTaskTemplatesData.fromJson(dynamic json):
  
  taskTemplates = (json['taskTemplates'] as List<dynamic>)
        .map((e) => ActiveTaskTemplatesTaskTemplates.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ActiveTaskTemplatesData otherTyped = other as ActiveTaskTemplatesData;
    return taskTemplates == otherTyped.taskTemplates;
    
  }
  @override
  int get hashCode => taskTemplates.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['taskTemplates'] = taskTemplates.map((e) => e.toJson()).toList();
    return json;
  }

  ActiveTaskTemplatesData({
    required this.taskTemplates,
  });
}

@immutable
class ActiveTaskTemplatesVariables {
  final String householdId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ActiveTaskTemplatesVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ActiveTaskTemplatesVariables otherTyped = other as ActiveTaskTemplatesVariables;
    return householdId == otherTyped.householdId;
    
  }
  @override
  int get hashCode => householdId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    return json;
  }

  ActiveTaskTemplatesVariables({
    required this.householdId,
  });
}

