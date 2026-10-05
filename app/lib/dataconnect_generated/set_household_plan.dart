part of 'sahakara.dart';

class SetHouseholdPlanVariablesBuilder {
  String householdId;
  String planId;
  double price;

  final FirebaseDataConnect _dataConnect;
  SetHouseholdPlanVariablesBuilder(this._dataConnect, {required  this.householdId,required  this.planId,required  this.price,});
  Deserializer<SetHouseholdPlanData> dataDeserializer = (dynamic json)  => SetHouseholdPlanData.fromJson(jsonDecode(json));
  Serializer<SetHouseholdPlanVariables> varsSerializer = (SetHouseholdPlanVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SetHouseholdPlanData, SetHouseholdPlanVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SetHouseholdPlanData, SetHouseholdPlanVariables> ref() {
    SetHouseholdPlanVariables vars= SetHouseholdPlanVariables(householdId: householdId,planId: planId,price: price,);
    return _dataConnect.mutation("SetHouseholdPlan", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SetHouseholdPlanHouseholdSubscriptionUpsert {
  final String householdId;
  SetHouseholdPlanHouseholdSubscriptionUpsert.fromJson(dynamic json):
  
  householdId = nativeFromJson<String>(json['householdId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetHouseholdPlanHouseholdSubscriptionUpsert otherTyped = other as SetHouseholdPlanHouseholdSubscriptionUpsert;
    return householdId == otherTyped.householdId;
    
  }
  @override
  int get hashCode => householdId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    return json;
  }

  SetHouseholdPlanHouseholdSubscriptionUpsert({
    required this.householdId,
  });
}

@immutable
class SetHouseholdPlanData {
  final SetHouseholdPlanHouseholdSubscriptionUpsert householdSubscription_upsert;
  SetHouseholdPlanData.fromJson(dynamic json):
  
  householdSubscription_upsert = SetHouseholdPlanHouseholdSubscriptionUpsert.fromJson(json['householdSubscription_upsert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetHouseholdPlanData otherTyped = other as SetHouseholdPlanData;
    return householdSubscription_upsert == otherTyped.householdSubscription_upsert;
    
  }
  @override
  int get hashCode => householdSubscription_upsert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdSubscription_upsert'] = householdSubscription_upsert.toJson();
    return json;
  }

  SetHouseholdPlanData({
    required this.householdSubscription_upsert,
  });
}

@immutable
class SetHouseholdPlanVariables {
  final String householdId;
  final String planId;
  final double price;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SetHouseholdPlanVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']),
  planId = nativeFromJson<String>(json['planId']),
  price = nativeFromJson<double>(json['price']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SetHouseholdPlanVariables otherTyped = other as SetHouseholdPlanVariables;
    return householdId == otherTyped.householdId && 
    planId == otherTyped.planId && 
    price == otherTyped.price;
    
  }
  @override
  int get hashCode => Object.hashAll([householdId.hashCode, planId.hashCode, price.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    json['planId'] = nativeToJson<String>(planId);
    json['price'] = nativeToJson<double>(price);
    return json;
  }

  SetHouseholdPlanVariables({
    required this.householdId,
    required this.planId,
    required this.price,
  });
}

