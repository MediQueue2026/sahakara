part of 'sahakara.dart';

class AddGroceryItemVariablesBuilder {
  String householdId;
  String nameEn;
  Optional<String> _nameSi = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _nameTa = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AddGroceryItemVariablesBuilder nameSi(String? t) {
   _nameSi.value = t;
   return this;
  }
  AddGroceryItemVariablesBuilder nameTa(String? t) {
   _nameTa.value = t;
   return this;
  }

  AddGroceryItemVariablesBuilder(this._dataConnect, {required  this.householdId,required  this.nameEn,});
  Deserializer<AddGroceryItemData> dataDeserializer = (dynamic json)  => AddGroceryItemData.fromJson(jsonDecode(json));
  Serializer<AddGroceryItemVariables> varsSerializer = (AddGroceryItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddGroceryItemData, AddGroceryItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddGroceryItemData, AddGroceryItemVariables> ref() {
    AddGroceryItemVariables vars= AddGroceryItemVariables(householdId: householdId,nameEn: nameEn,nameSi: _nameSi,nameTa: _nameTa,);
    return _dataConnect.mutation("AddGroceryItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddGroceryItemGroceryItemInsert {
  final String id;
  AddGroceryItemGroceryItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddGroceryItemGroceryItemInsert otherTyped = other as AddGroceryItemGroceryItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddGroceryItemGroceryItemInsert({
    required this.id,
  });
}

@immutable
class AddGroceryItemData {
  final AddGroceryItemGroceryItemInsert groceryItem_insert;
  AddGroceryItemData.fromJson(dynamic json):
  
  groceryItem_insert = AddGroceryItemGroceryItemInsert.fromJson(json['groceryItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddGroceryItemData otherTyped = other as AddGroceryItemData;
    return groceryItem_insert == otherTyped.groceryItem_insert;
    
  }
  @override
  int get hashCode => groceryItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['groceryItem_insert'] = groceryItem_insert.toJson();
    return json;
  }

  AddGroceryItemData({
    required this.groceryItem_insert,
  });
}

@immutable
class AddGroceryItemVariables {
  final String householdId;
  final String nameEn;
  late final Optional<String>nameSi;
  late final Optional<String>nameTa;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddGroceryItemVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']),
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

    final AddGroceryItemVariables otherTyped = other as AddGroceryItemVariables;
    return householdId == otherTyped.householdId && 
    nameEn == otherTyped.nameEn && 
    nameSi == otherTyped.nameSi && 
    nameTa == otherTyped.nameTa;
    
  }
  @override
  int get hashCode => Object.hashAll([householdId.hashCode, nameEn.hashCode, nameSi.hashCode, nameTa.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    json['nameEn'] = nativeToJson<String>(nameEn);
    if(nameSi.state == OptionalState.set) {
      json['nameSi'] = nameSi.toJson();
    }
    if(nameTa.state == OptionalState.set) {
      json['nameTa'] = nameTa.toJson();
    }
    return json;
  }

  AddGroceryItemVariables({
    required this.householdId,
    required this.nameEn,
    required this.nameSi,
    required this.nameTa,
  });
}

