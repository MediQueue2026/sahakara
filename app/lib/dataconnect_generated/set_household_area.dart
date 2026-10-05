part of 'sahakara.dart';

class SetHouseholdAreaVariablesBuilder {
  String householdId;
  Optional<String> _area = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  SetHouseholdAreaVariablesBuilder area(String? t) {
   _area.value = t;
   return this;
  }

  SetHouseholdAreaVariablesBuilder(this._dataConnect, {required  this.householdId,});
  Deserializer<SetHouseholdAreaData> dataDeserializer = (dynamic json)  => SetHouseholdAreaData.fromJson(jsonDecode(json));
  Serializer<SetHouseholdAreaVariables> varsSerializer = (SetHouseholdAreaVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SetHouseholdAreaData, SetHouseholdAreaVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SetHouseholdAreaData, SetHouseholdAreaVariables> ref() {
    SetHouseholdAreaVariables vars= SetHouseholdAreaVariables(householdId: householdId,area: _area,);
    return _dataConnect.mutation("SetHouseholdArea", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SetHouseholdAreaData {
  final int household_updateMany;
  SetHouseholdAreaData.fromJson(dynamic json):
  
  household_updateMany = nativeFromJson<int>(json['household_updateMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetHouseholdAreaData otherTyped = other as SetHouseholdAreaData;
    return household_updateMany == otherTyped.household_updateMany;
    
  }
  @override
  int get hashCode => household_updateMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['household_updateMany'] = nativeToJson<int>(household_updateMany);
    return json;
  }

  SetHouseholdAreaData({
    required this.household_updateMany,
  });
}

@immutable
class SetHouseholdAreaVariables {
  final String householdId;
  late final Optional<String>area;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SetHouseholdAreaVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']) {
  
  
  
    area = Optional.optional(nativeFromJson, nativeToJson);
    area.value = json['area'] == null ? null : nativeFromJson<String>(json['area']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetHouseholdAreaVariables otherTyped = other as SetHouseholdAreaVariables;
    return householdId == otherTyped.householdId && 
    area == otherTyped.area;
    
  }
  @override
  int get hashCode => Object.hashAll([householdId.hashCode, area.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    if(area.state == OptionalState.set) {
      json['area'] = area.toJson();
    }
    return json;
  }

  SetHouseholdAreaVariables({
    required this.householdId,
    required this.area,
  });
}

