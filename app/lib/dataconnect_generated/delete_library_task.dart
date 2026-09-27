part of 'sahakara.dart';

class DeleteLibraryTaskVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteLibraryTaskVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteLibraryTaskData> dataDeserializer = (dynamic json)  => DeleteLibraryTaskData.fromJson(jsonDecode(json));
  Serializer<DeleteLibraryTaskVariables> varsSerializer = (DeleteLibraryTaskVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteLibraryTaskData, DeleteLibraryTaskVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteLibraryTaskData, DeleteLibraryTaskVariables> ref() {
    DeleteLibraryTaskVariables vars= DeleteLibraryTaskVariables(id: id,);
    return _dataConnect.mutation("DeleteLibraryTask", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteLibraryTaskLibraryTaskDelete {
  final String id;
  DeleteLibraryTaskLibraryTaskDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteLibraryTaskLibraryTaskDelete otherTyped = other as DeleteLibraryTaskLibraryTaskDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteLibraryTaskLibraryTaskDelete({
    required this.id,
  });
}

@immutable
class DeleteLibraryTaskData {
  final DeleteLibraryTaskLibraryTaskDelete? libraryTask_delete;
  DeleteLibraryTaskData.fromJson(dynamic json):
  
  libraryTask_delete = json['libraryTask_delete'] == null ? null : DeleteLibraryTaskLibraryTaskDelete.fromJson(json['libraryTask_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteLibraryTaskData otherTyped = other as DeleteLibraryTaskData;
    return libraryTask_delete == otherTyped.libraryTask_delete;
    
  }
  @override
  int get hashCode => libraryTask_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (libraryTask_delete != null) {
      json['libraryTask_delete'] = libraryTask_delete!.toJson();
    }
    return json;
  }

  DeleteLibraryTaskData({
    this.libraryTask_delete,
  });
}

@immutable
class DeleteLibraryTaskVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteLibraryTaskVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteLibraryTaskVariables otherTyped = other as DeleteLibraryTaskVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteLibraryTaskVariables({
    required this.id,
  });
}

