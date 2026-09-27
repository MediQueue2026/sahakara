part of 'sahakara.dart';

class AddLibraryTaskVariablesBuilder {
  TaskCategory category;
  String nameEn;
  Optional<String> _nameSi = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _nameTa = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AddLibraryTaskVariablesBuilder nameSi(String? t) {
   _nameSi.value = t;
   return this;
  }
  AddLibraryTaskVariablesBuilder nameTa(String? t) {
   _nameTa.value = t;
   return this;
  }

  AddLibraryTaskVariablesBuilder(this._dataConnect, {required  this.category,required  this.nameEn,});
  Deserializer<AddLibraryTaskData> dataDeserializer = (dynamic json)  => AddLibraryTaskData.fromJson(jsonDecode(json));
  Serializer<AddLibraryTaskVariables> varsSerializer = (AddLibraryTaskVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddLibraryTaskData, AddLibraryTaskVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddLibraryTaskData, AddLibraryTaskVariables> ref() {
    AddLibraryTaskVariables vars= AddLibraryTaskVariables(category: category,nameEn: nameEn,nameSi: _nameSi,nameTa: _nameTa,);
    return _dataConnect.mutation("AddLibraryTask", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddLibraryTaskLibraryTaskInsert {
  final String id;
  AddLibraryTaskLibraryTaskInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddLibraryTaskLibraryTaskInsert otherTyped = other as AddLibraryTaskLibraryTaskInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddLibraryTaskLibraryTaskInsert({
    required this.id,
  });
}

@immutable
class AddLibraryTaskData {
  final AddLibraryTaskLibraryTaskInsert libraryTask_insert;
  AddLibraryTaskData.fromJson(dynamic json):
  
  libraryTask_insert = AddLibraryTaskLibraryTaskInsert.fromJson(json['libraryTask_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddLibraryTaskData otherTyped = other as AddLibraryTaskData;
    return libraryTask_insert == otherTyped.libraryTask_insert;
    
  }
  @override
  int get hashCode => libraryTask_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['libraryTask_insert'] = libraryTask_insert.toJson();
    return json;
  }

  AddLibraryTaskData({
    required this.libraryTask_insert,
  });
}

@immutable
class AddLibraryTaskVariables {
  final TaskCategory category;
  final String nameEn;
  late final Optional<String>nameSi;
  late final Optional<String>nameTa;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddLibraryTaskVariables.fromJson(Map<String, dynamic> json):
  
  category = TaskCategory.values.byName(json['category']),
  nameEn = nativeFromJson<String>(json['nameEn']) {
  
  
  
  
    nameSi = Optional.optional(nativeFromJson, nativeToJson);
    nameSi.value = json['nameSi'] == null ? null : nativeFromJson<String>(json['nameSi']);
  
  
    nameTa = Optional.optional(nativeFromJson, nativeToJson);
    nameTa.value = json['nameTa'] == null ? null : nativeFromJson<String>(json['nameTa']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddLibraryTaskVariables otherTyped = other as AddLibraryTaskVariables;
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
    category.name
    ;
    json['nameEn'] = nativeToJson<String>(nameEn);
    if(nameSi.state == OptionalState.set) {
      json['nameSi'] = nameSi.toJson();
    }
    if(nameTa.state == OptionalState.set) {
      json['nameTa'] = nameTa.toJson();
    }
    return json;
  }

  AddLibraryTaskVariables({
    required this.category,
    required this.nameEn,
    required this.nameSi,
    required this.nameTa,
  });
}

