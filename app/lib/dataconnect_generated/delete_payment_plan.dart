part of 'sahakara.dart';

class DeletePaymentPlanVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeletePaymentPlanVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeletePaymentPlanData> dataDeserializer = (dynamic json)  => DeletePaymentPlanData.fromJson(jsonDecode(json));
  Serializer<DeletePaymentPlanVariables> varsSerializer = (DeletePaymentPlanVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeletePaymentPlanData, DeletePaymentPlanVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeletePaymentPlanData, DeletePaymentPlanVariables> ref() {
    DeletePaymentPlanVariables vars= DeletePaymentPlanVariables(id: id,);
    return _dataConnect.mutation("DeletePaymentPlan", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeletePaymentPlanPaymentPlanDelete {
  final String id;
  DeletePaymentPlanPaymentPlanDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletePaymentPlanPaymentPlanDelete otherTyped = other as DeletePaymentPlanPaymentPlanDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletePaymentPlanPaymentPlanDelete({
    required this.id,
  });
}

@immutable
class DeletePaymentPlanData {
  final DeletePaymentPlanPaymentPlanDelete? paymentPlan_delete;
  DeletePaymentPlanData.fromJson(dynamic json):
  
  paymentPlan_delete = json['paymentPlan_delete'] == null ? null : DeletePaymentPlanPaymentPlanDelete.fromJson(json['paymentPlan_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletePaymentPlanData otherTyped = other as DeletePaymentPlanData;
    return paymentPlan_delete == otherTyped.paymentPlan_delete;
    
  }
  @override
  int get hashCode => paymentPlan_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (paymentPlan_delete != null) {
      json['paymentPlan_delete'] = paymentPlan_delete!.toJson();
    }
    return json;
  }

  DeletePaymentPlanData({
    this.paymentPlan_delete,
  });
}

@immutable
class DeletePaymentPlanVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeletePaymentPlanVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletePaymentPlanVariables otherTyped = other as DeletePaymentPlanVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletePaymentPlanVariables({
    required this.id,
  });
}

