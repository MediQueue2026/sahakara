part of 'sahakara.dart';

class UpdateGroceryItemStatusVariablesBuilder {
  String id;
  bool isBought;

  final FirebaseDataConnect _dataConnect;
  UpdateGroceryItemStatusVariablesBuilder(this._dataConnect, {required  this.id,required  this.isBought,});
  Deserializer<UpdateGroceryItemStatusData> dataDeserializer = (dynamic json)  => UpdateGroceryItemStatusData.fromJson(jsonDecode(json));
  Serializer<UpdateGroceryItemStatusVariables> varsSerializer = (UpdateGroceryItemStatusVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateGroceryItemStatusData, UpdateGroceryItemStatusVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateGroceryItemStatusData, UpdateGroceryItemStatusVariables> ref() {
    UpdateGroceryItemStatusVariables vars= UpdateGroceryItemStatusVariables(id: id,isBought: isBought,);
    return _dataConnect.mutation("UpdateGroceryItemStatus", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateGroceryItemStatusGroceryItemUpdate {
  final String id;
  UpdateGroceryItemStatusGroceryItemUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateGroceryItemStatusGroceryItemUpdate otherTyped = other as UpdateGroceryItemStatusGroceryItemUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateGroceryItemStatusGroceryItemUpdate({
    required this.id,
  });
}

@immutable
class UpdateGroceryItemStatusData {
  final UpdateGroceryItemStatusGroceryItemUpdate? groceryItem_update;
  UpdateGroceryItemStatusData.fromJson(dynamic json):
  
  groceryItem_update = json['groceryItem_update'] == null ? null : UpdateGroceryItemStatusGroceryItemUpdate.fromJson(json['groceryItem_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateGroceryItemStatusData otherTyped = other as UpdateGroceryItemStatusData;
    return groceryItem_update == otherTyped.groceryItem_update;
    
  }
  @override
  int get hashCode => groceryItem_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (groceryItem_update != null) {
      json['groceryItem_update'] = groceryItem_update!.toJson();
    }
    return json;
  }

  UpdateGroceryItemStatusData({
    this.groceryItem_update,
  });
}

@immutable
class UpdateGroceryItemStatusVariables {
  final String id;
  final bool isBought;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateGroceryItemStatusVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  isBought = nativeFromJson<bool>(json['isBought']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateGroceryItemStatusVariables otherTyped = other as UpdateGroceryItemStatusVariables;
    return id == otherTyped.id && 
    isBought == otherTyped.isBought;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, isBought.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['isBought'] = nativeToJson<bool>(isBought);
    return json;
  }

  UpdateGroceryItemStatusVariables({
    required this.id,
    required this.isBought,
  });
}

