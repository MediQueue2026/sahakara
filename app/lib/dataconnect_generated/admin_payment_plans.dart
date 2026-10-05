part of 'sahakara.dart';

class AdminPaymentPlansVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  AdminPaymentPlansVariablesBuilder(this._dataConnect, );
  Deserializer<AdminPaymentPlansData> dataDeserializer = (dynamic json)  => AdminPaymentPlansData.fromJson(jsonDecode(json));
  
  Future<QueryResult<AdminPaymentPlansData, void>> execute() {
    return ref().execute();
  }

  QueryRef<AdminPaymentPlansData, void> ref() {
    
    return _dataConnect.query("AdminPaymentPlans", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class AdminPaymentPlansPaymentPlans {
  final String id;
  final String name;
  final double price;
  final EnumValue<BillingPeriod> billingPeriod;
  final String? description;
  final List<AdminPaymentPlansPaymentPlansHouseholdSubscriptionsOnPlan> householdSubscriptions_on_plan;
  AdminPaymentPlansPaymentPlans.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  price = nativeFromJson<double>(json['price']),
  billingPeriod = billingPeriodDeserializer(json['billingPeriod']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  householdSubscriptions_on_plan = (json['householdSubscriptions_on_plan'] as List<dynamic>)
        .map((e) => AdminPaymentPlansPaymentPlansHouseholdSubscriptionsOnPlan.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminPaymentPlansPaymentPlans otherTyped = other as AdminPaymentPlansPaymentPlans;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    price == otherTyped.price && 
    billingPeriod == otherTyped.billingPeriod && 
    description == otherTyped.description && 
    householdSubscriptions_on_plan == otherTyped.householdSubscriptions_on_plan;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, price.hashCode, billingPeriod.hashCode, description.hashCode, householdSubscriptions_on_plan.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['price'] = nativeToJson<double>(price);
    json['billingPeriod'] = 
    billingPeriodSerializer(billingPeriod)
    ;
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    json['householdSubscriptions_on_plan'] = householdSubscriptions_on_plan.map((e) => e.toJson()).toList();
    return json;
  }

  AdminPaymentPlansPaymentPlans({
    required this.id,
    required this.name,
    required this.price,
    required this.billingPeriod,
    this.description,
    required this.householdSubscriptions_on_plan,
  });
}

@immutable
class AdminPaymentPlansPaymentPlansHouseholdSubscriptionsOnPlan {
  final String householdId;
  AdminPaymentPlansPaymentPlansHouseholdSubscriptionsOnPlan.fromJson(dynamic json):
  
  householdId = nativeFromJson<String>(json['householdId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminPaymentPlansPaymentPlansHouseholdSubscriptionsOnPlan otherTyped = other as AdminPaymentPlansPaymentPlansHouseholdSubscriptionsOnPlan;
    return householdId == otherTyped.householdId;
    
  }
  @override
  int get hashCode => householdId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    return json;
  }

  AdminPaymentPlansPaymentPlansHouseholdSubscriptionsOnPlan({
    required this.householdId,
  });
}

@immutable
class AdminPaymentPlansData {
  final List<AdminPaymentPlansPaymentPlans> paymentPlans;
  AdminPaymentPlansData.fromJson(dynamic json):
  
  paymentPlans = (json['paymentPlans'] as List<dynamic>)
        .map((e) => AdminPaymentPlansPaymentPlans.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminPaymentPlansData otherTyped = other as AdminPaymentPlansData;
    return paymentPlans == otherTyped.paymentPlans;
    
  }
  @override
  int get hashCode => paymentPlans.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['paymentPlans'] = paymentPlans.map((e) => e.toJson()).toList();
    return json;
  }

  AdminPaymentPlansData({
    required this.paymentPlans,
  });
}

