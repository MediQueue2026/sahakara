part of 'sahakara.dart';

class CreateHouseholdVariablesBuilder {
  String name;
  Optional<String> _address = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateHouseholdVariablesBuilder address(String? t) {
   _address.value = t;
   return this;
  }

  CreateHouseholdVariablesBuilder(this._dataConnect, {required  this.name,});
  Deserializer<CreateHouseholdData> dataDeserializer = (dynamic json)  => CreateHouseholdData.fromJson(jsonDecode(json));
  Serializer<CreateHouseholdVariables> varsSerializer = (CreateHouseholdVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateHouseholdData, CreateHouseholdVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateHouseholdData, CreateHouseholdVariables> ref() {
    CreateHouseholdVariables vars= CreateHouseholdVariables(name: name,address: _address,);
    return _dataConnect.mutation("CreateHousehold", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateHouseholdHouseholdInsert {
  final String id;
  CreateHouseholdHouseholdInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateHouseholdHouseholdInsert otherTyped = other as CreateHouseholdHouseholdInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateHouseholdHouseholdInsert({
    required this.id,
  });
}

@immutable
class CreateHouseholdHouseholdMemberInsert {
  final String id;
  CreateHouseholdHouseholdMemberInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateHouseholdHouseholdMemberInsert otherTyped = other as CreateHouseholdHouseholdMemberInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateHouseholdHouseholdMemberInsert({
    required this.id,
  });
}

@immutable
class CreateHouseholdData {
  final CreateHouseholdHouseholdInsert household_insert;
  final CreateHouseholdHouseholdMemberInsert householdMember_insert;
  CreateHouseholdData.fromJson(dynamic json):
  
  household_insert = CreateHouseholdHouseholdInsert.fromJson(json['household_insert']),
  householdMember_insert = CreateHouseholdHouseholdMemberInsert.fromJson(json['householdMember_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateHouseholdData otherTyped = other as CreateHouseholdData;
    return household_insert == otherTyped.household_insert && 
    householdMember_insert == otherTyped.householdMember_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([household_insert.hashCode, householdMember_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['household_insert'] = household_insert.toJson();
    json['householdMember_insert'] = householdMember_insert.toJson();
    return json;
  }

  CreateHouseholdData({
    required this.household_insert,
    required this.householdMember_insert,
  });
}

@immutable
class CreateHouseholdVariables {
  final String name;
  late final Optional<String>address;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateHouseholdVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']) {
  
  
  
    address = Optional.optional(nativeFromJson, nativeToJson);
    address.value = json['address'] == null ? null : nativeFromJson<String>(json['address']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateHouseholdVariables otherTyped = other as CreateHouseholdVariables;
    return name == otherTyped.name && 
    address == otherTyped.address;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, address.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    if(address.state == OptionalState.set) {
      json['address'] = address.toJson();
    }
    return json;
  }

  CreateHouseholdVariables({
    required this.name,
    required this.address,
  });
}

