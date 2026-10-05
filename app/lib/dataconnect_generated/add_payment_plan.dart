part of 'sahakara.dart';

class AddPaymentPlanVariablesBuilder {
  String name;
  double price;
  BillingPeriod billingPeriod;
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AddPaymentPlanVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }

  AddPaymentPlanVariablesBuilder(this._dataConnect, {required  this.name,required  this.price,required  this.billingPeriod,});
  Deserializer<AddPaymentPlanData> dataDeserializer = (dynamic json)  => AddPaymentPlanData.fromJson(jsonDecode(json));
  Serializer<AddPaymentPlanVariables> varsSerializer = (AddPaymentPlanVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddPaymentPlanData, AddPaymentPlanVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddPaymentPlanData, AddPaymentPlanVariables> ref() {
    AddPaymentPlanVariables vars= AddPaymentPlanVariables(name: name,price: price,billingPeriod: billingPeriod,description: _description,);
    return _dataConnect.mutation("AddPaymentPlan", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddPaymentPlanPaymentPlanInsert {
  final String id;
  AddPaymentPlanPaymentPlanInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddPaymentPlanPaymentPlanInsert otherTyped = other as AddPaymentPlanPaymentPlanInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddPaymentPlanPaymentPlanInsert({
    required this.id,
  });
}

@immutable
class AddPaymentPlanData {
  final AddPaymentPlanPaymentPlanInsert paymentPlan_insert;
  AddPaymentPlanData.fromJson(dynamic json):
  
  paymentPlan_insert = AddPaymentPlanPaymentPlanInsert.fromJson(json['paymentPlan_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddPaymentPlanData otherTyped = other as AddPaymentPlanData;
    return paymentPlan_insert == otherTyped.paymentPlan_insert;
    
  }
  @override
  int get hashCode => paymentPlan_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['paymentPlan_insert'] = paymentPlan_insert.toJson();
    return json;
  }

  AddPaymentPlanData({
    required this.paymentPlan_insert,
  });
}

@immutable
class AddPaymentPlanVariables {
  final String name;
  final double price;
  final BillingPeriod billingPeriod;
  late final Optional<String>description;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddPaymentPlanVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  price = nativeFromJson<double>(json['price']),
  billingPeriod = BillingPeriod.values.byName(json['billingPeriod']) {
  
  
  
  
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddPaymentPlanVariables otherTyped = other as AddPaymentPlanVariables;
    return name == otherTyped.name && 
    price == otherTyped.price && 
    billingPeriod == otherTyped.billingPeriod && 
    description == otherTyped.description;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, price.hashCode, billingPeriod.hashCode, description.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['price'] = nativeToJson<double>(price);
    json['billingPeriod'] = 
    billingPeriod.name
    ;
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    return json;
  }

  AddPaymentPlanVariables({
    required this.name,
    required this.price,
    required this.billingPeriod,
    required this.description,
  });
}

