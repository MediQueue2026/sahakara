part of 'sahakara.dart';

class GetGroceryItemsVariablesBuilder {
  String householdId;

  final FirebaseDataConnect _dataConnect;
  GetGroceryItemsVariablesBuilder(this._dataConnect, {required  this.householdId,});
  Deserializer<GetGroceryItemsData> dataDeserializer = (dynamic json)  => GetGroceryItemsData.fromJson(jsonDecode(json));
  Serializer<GetGroceryItemsVariables> varsSerializer = (GetGroceryItemsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetGroceryItemsData, GetGroceryItemsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetGroceryItemsData, GetGroceryItemsVariables> ref() {
    GetGroceryItemsVariables vars= GetGroceryItemsVariables(householdId: householdId,);
    return _dataConnect.query("GetGroceryItems", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetGroceryItemsGroceryItems {
  final String id;
  final String nameEn;
  final String? nameSi;
  final String? nameTa;
  final bool isBought;
  final Timestamp createdAt;
  final GetGroceryItemsGroceryItemsAddedBy addedBy;
  GetGroceryItemsGroceryItems.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nameEn = nativeFromJson<String>(json['nameEn']),
  nameSi = json['nameSi'] == null ? null : nativeFromJson<String>(json['nameSi']),
  nameTa = json['nameTa'] == null ? null : nativeFromJson<String>(json['nameTa']),
  isBought = nativeFromJson<bool>(json['isBought']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  addedBy = GetGroceryItemsGroceryItemsAddedBy.fromJson(json['addedBy']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetGroceryItemsGroceryItems otherTyped = other as GetGroceryItemsGroceryItems;
    return id == otherTyped.id && 
    nameEn == otherTyped.nameEn && 
    nameSi == otherTyped.nameSi && 
    nameTa == otherTyped.nameTa && 
    isBought == otherTyped.isBought && 
    createdAt == otherTyped.createdAt && 
    addedBy == otherTyped.addedBy;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nameEn.hashCode, nameSi.hashCode, nameTa.hashCode, isBought.hashCode, createdAt.hashCode, addedBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nameEn'] = nativeToJson<String>(nameEn);
    if (nameSi != null) {
      json['nameSi'] = nativeToJson<String?>(nameSi);
    }
    if (nameTa != null) {
      json['nameTa'] = nativeToJson<String?>(nameTa);
    }
    json['isBought'] = nativeToJson<bool>(isBought);
    json['createdAt'] = createdAt.toJson();
    json['addedBy'] = addedBy.toJson();
    return json;
  }

  GetGroceryItemsGroceryItems({
    required this.id,
    required this.nameEn,
    this.nameSi,
    this.nameTa,
    required this.isBought,
    required this.createdAt,
    required this.addedBy,
  });
}

@immutable
class GetGroceryItemsGroceryItemsAddedBy {
  final String name;
  GetGroceryItemsGroceryItemsAddedBy.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetGroceryItemsGroceryItemsAddedBy otherTyped = other as GetGroceryItemsGroceryItemsAddedBy;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetGroceryItemsGroceryItemsAddedBy({
    required this.name,
  });
}

@immutable
class GetGroceryItemsData {
  final List<GetGroceryItemsGroceryItems> groceryItems;
  GetGroceryItemsData.fromJson(dynamic json):
  
  groceryItems = (json['groceryItems'] as List<dynamic>)
        .map((e) => GetGroceryItemsGroceryItems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetGroceryItemsData otherTyped = other as GetGroceryItemsData;
    return groceryItems == otherTyped.groceryItems;
    
  }
  @override
  int get hashCode => groceryItems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['groceryItems'] = groceryItems.map((e) => e.toJson()).toList();
    return json;
  }

  GetGroceryItemsData({
    required this.groceryItems,
  });
}

@immutable
class GetGroceryItemsVariables {
  final String householdId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetGroceryItemsVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetGroceryItemsVariables otherTyped = other as GetGroceryItemsVariables;
    return householdId == otherTyped.householdId;
    
  }
  @override
  int get hashCode => householdId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    return json;
  }

  GetGroceryItemsVariables({
    required this.householdId,
  });
}

