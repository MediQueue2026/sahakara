part of 'sahakara.dart';

class MarkSalaryPaymentPaidVariablesBuilder {
  String id;
  String month;
  PaymentMethod method;

  final FirebaseDataConnect _dataConnect;
  MarkSalaryPaymentPaidVariablesBuilder(this._dataConnect, {required  this.id,required  this.month,required  this.method,});
  Deserializer<MarkSalaryPaymentPaidData> dataDeserializer = (dynamic json)  => MarkSalaryPaymentPaidData.fromJson(jsonDecode(json));
  Serializer<MarkSalaryPaymentPaidVariables> varsSerializer = (MarkSalaryPaymentPaidVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<MarkSalaryPaymentPaidData, MarkSalaryPaymentPaidVariables>> execute() {
    return ref().execute();
  }

  MutationRef<MarkSalaryPaymentPaidData, MarkSalaryPaymentPaidVariables> ref() {
    MarkSalaryPaymentPaidVariables vars= MarkSalaryPaymentPaidVariables(id: id,month: month,method: method,);
    return _dataConnect.mutation("MarkSalaryPaymentPaid", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class MarkSalaryPaymentPaidSalaryPaymentUpdate {
  final String id;
  MarkSalaryPaymentPaidSalaryPaymentUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MarkSalaryPaymentPaidSalaryPaymentUpdate otherTyped = other as MarkSalaryPaymentPaidSalaryPaymentUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MarkSalaryPaymentPaidSalaryPaymentUpdate({
    required this.id,
  });
}

@immutable
class MarkSalaryPaymentPaidLedgerEntryInsert {
  final String id;
  MarkSalaryPaymentPaidLedgerEntryInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MarkSalaryPaymentPaidLedgerEntryInsert otherTyped = other as MarkSalaryPaymentPaidLedgerEntryInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MarkSalaryPaymentPaidLedgerEntryInsert({
    required this.id,
  });
}

@immutable
class MarkSalaryPaymentPaidData {
  final MarkSalaryPaymentPaidSalaryPaymentUpdate? salaryPayment_update;
  final MarkSalaryPaymentPaidLedgerEntryInsert ledgerEntry_insert;
  MarkSalaryPaymentPaidData.fromJson(dynamic json):
  
  salaryPayment_update = json['salaryPayment_update'] == null ? null : MarkSalaryPaymentPaidSalaryPaymentUpdate.fromJson(json['salaryPayment_update']),
  ledgerEntry_insert = MarkSalaryPaymentPaidLedgerEntryInsert.fromJson(json['ledgerEntry_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MarkSalaryPaymentPaidData otherTyped = other as MarkSalaryPaymentPaidData;
    return salaryPayment_update == otherTyped.salaryPayment_update && 
    ledgerEntry_insert == otherTyped.ledgerEntry_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([salaryPayment_update.hashCode, ledgerEntry_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (salaryPayment_update != null) {
      json['salaryPayment_update'] = salaryPayment_update!.toJson();
    }
    json['ledgerEntry_insert'] = ledgerEntry_insert.toJson();
    return json;
  }

  MarkSalaryPaymentPaidData({
    this.salaryPayment_update,
    required this.ledgerEntry_insert,
  });
}

@immutable
class MarkSalaryPaymentPaidVariables {
  final String id;
  final String month;
  final PaymentMethod method;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  MarkSalaryPaymentPaidVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  month = nativeFromJson<String>(json['month']),
  method = PaymentMethod.values.byName(json['method']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MarkSalaryPaymentPaidVariables otherTyped = other as MarkSalaryPaymentPaidVariables;
    return id == otherTyped.id && 
    month == otherTyped.month && 
    method == otherTyped.method;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, month.hashCode, method.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['month'] = nativeToJson<String>(month);
    json['method'] = 
    method.name
    ;
    return json;
  }

  MarkSalaryPaymentPaidVariables({
    required this.id,
    required this.month,
    required this.method,
  });
}

