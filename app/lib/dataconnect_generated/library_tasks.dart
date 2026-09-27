part of 'sahakara.dart';

class LibraryTasksVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  LibraryTasksVariablesBuilder(this._dataConnect, );
  Deserializer<LibraryTasksData> dataDeserializer = (dynamic json)  => LibraryTasksData.fromJson(jsonDecode(json));
  
  Future<QueryResult<LibraryTasksData, void>> execute() {
    return ref().execute();
  }

  QueryRef<LibraryTasksData, void> ref() {
    
    return _dataConnect.query("LibraryTasks", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class LibraryTasksLibraryTasks {
  final String id;
  final EnumValue<TaskCategory> category;
  final String nameEn;
  final String? nameSi;
  final String? nameTa;
  LibraryTasksLibraryTasks.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
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

    final LibraryTasksLibraryTasks otherTyped = other as LibraryTasksLibraryTasks;
    return id == otherTyped.id && 
    category == otherTyped.category && 
    nameEn == otherTyped.nameEn && 
    nameSi == otherTyped.nameSi && 
    nameTa == otherTyped.nameTa;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, category.hashCode, nameEn.hashCode, nameSi.hashCode, nameTa.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
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

  LibraryTasksLibraryTasks({
    required this.id,
    required this.category,
    required this.nameEn,
    this.nameSi,
    this.nameTa,
  });
}

@immutable
class LibraryTasksData {
  final List<LibraryTasksLibraryTasks> libraryTasks;
  LibraryTasksData.fromJson(dynamic json):
  
  libraryTasks = (json['libraryTasks'] as List<dynamic>)
        .map((e) => LibraryTasksLibraryTasks.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final LibraryTasksData otherTyped = other as LibraryTasksData;
    return libraryTasks == otherTyped.libraryTasks;
    
  }
  @override
  int get hashCode => libraryTasks.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['libraryTasks'] = libraryTasks.map((e) => e.toJson()).toList();
    return json;
  }

  LibraryTasksData({
    required this.libraryTasks,
  });
}

