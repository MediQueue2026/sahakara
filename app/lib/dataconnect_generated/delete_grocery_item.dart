part of 'sahakara.dart';

class DeleteGroceryItemVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteGroceryItemVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteGroceryItemData> dataDeserializer = (dynamic json)  => DeleteGroceryItemData.fromJson(jsonDecode(json));
  Serializer<DeleteGroceryItemVariables> varsSerializer = (DeleteGroceryItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteGroceryItemData, DeleteGroceryItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteGroceryItemData, DeleteGroceryItemVariables> ref() {
    DeleteGroceryItemVariables vars= DeleteGroceryItemVariables(id: id,);
    return _dataConnect.mutation("DeleteGroceryItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteGroceryItemGroceryItemDelete {
  final String id;
  DeleteGroceryItemGroceryItemDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteGroceryItemGroceryItemDelete otherTyped = other as DeleteGroceryItemGroceryItemDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteGroceryItemGroceryItemDelete({
    required this.id,
  });
}

@immutable
class DeleteGroceryItemData {
  final DeleteGroceryItemGroceryItemDelete? groceryItem_delete;
  DeleteGroceryItemData.fromJson(dynamic json):
  
  groceryItem_delete = json['groceryItem_delete'] == null ? null : DeleteGroceryItemGroceryItemDelete.fromJson(json['groceryItem_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteGroceryItemData otherTyped = other as DeleteGroceryItemData;
    return groceryItem_delete == otherTyped.groceryItem_delete;
    
  }
  @override
  int get hashCode => groceryItem_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (groceryItem_delete != null) {
      json['groceryItem_delete'] = groceryItem_delete!.toJson();
    }
    return json;
  }

  DeleteGroceryItemData({
    this.groceryItem_delete,
  });
}

@immutable
class DeleteGroceryItemVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteGroceryItemVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteGroceryItemVariables otherTyped = other as DeleteGroceryItemVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteGroceryItemVariables({
    required this.id,
  });
}

