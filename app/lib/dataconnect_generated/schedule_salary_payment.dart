part of 'sahakara.dart';

class ScheduleSalaryPaymentVariablesBuilder {
  String memberId;
  double amount;
  DateTime paymentDate;
  Optional<String> _note = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  ScheduleSalaryPaymentVariablesBuilder note(String? t) {
   _note.value = t;
   return this;
  }

  ScheduleSalaryPaymentVariablesBuilder(this._dataConnect, {required  this.memberId,required  this.amount,required  this.paymentDate,});
  Deserializer<ScheduleSalaryPaymentData> dataDeserializer = (dynamic json)  => ScheduleSalaryPaymentData.fromJson(jsonDecode(json));
  Serializer<ScheduleSalaryPaymentVariables> varsSerializer = (ScheduleSalaryPaymentVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ScheduleSalaryPaymentData, ScheduleSalaryPaymentVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ScheduleSalaryPaymentData, ScheduleSalaryPaymentVariables> ref() {
    ScheduleSalaryPaymentVariables vars= ScheduleSalaryPaymentVariables(memberId: memberId,amount: amount,paymentDate: paymentDate,note: _note,);
    return _dataConnect.mutation("ScheduleSalaryPayment", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ScheduleSalaryPaymentSalaryPaymentInsert {
  final String id;
  ScheduleSalaryPaymentSalaryPaymentInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ScheduleSalaryPaymentSalaryPaymentInsert otherTyped = other as ScheduleSalaryPaymentSalaryPaymentInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ScheduleSalaryPaymentSalaryPaymentInsert({
    required this.id,
  });
}

@immutable
class ScheduleSalaryPaymentData {
  final ScheduleSalaryPaymentSalaryPaymentInsert salaryPayment_insert;
  ScheduleSalaryPaymentData.fromJson(dynamic json):
  
  salaryPayment_insert = ScheduleSalaryPaymentSalaryPaymentInsert.fromJson(json['salaryPayment_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ScheduleSalaryPaymentData otherTyped = other as ScheduleSalaryPaymentData;
    return salaryPayment_insert == otherTyped.salaryPayment_insert;
    
  }
  @override
  int get hashCode => salaryPayment_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['salaryPayment_insert'] = salaryPayment_insert.toJson();
    return json;
  }

  ScheduleSalaryPaymentData({
    required this.salaryPayment_insert,
  });
}

@immutable
class ScheduleSalaryPaymentVariables {
  final String memberId;
  final double amount;
  final DateTime paymentDate;
  late final Optional<String>note;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ScheduleSalaryPaymentVariables.fromJson(Map<String, dynamic> json):
  
  memberId = nativeFromJson<String>(json['memberId']),
  amount = nativeFromJson<double>(json['amount']),
  paymentDate = nativeFromJson<DateTime>(json['paymentDate']) {
  
  
  
  
  
    note = Optional.optional(nativeFromJson, nativeToJson);
    note.value = json['note'] == null ? null : nativeFromJson<String>(json['note']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ScheduleSalaryPaymentVariables otherTyped = other as ScheduleSalaryPaymentVariables;
    return memberId == otherTyped.memberId && 
    amount == otherTyped.amount && 
    paymentDate == otherTyped.paymentDate && 
    note == otherTyped.note;
    
  }
  @override
  int get hashCode => Object.hashAll([memberId.hashCode, amount.hashCode, paymentDate.hashCode, note.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['memberId'] = nativeToJson<String>(memberId);
    json['amount'] = nativeToJson<double>(amount);
    json['paymentDate'] = nativeToJson<DateTime>(paymentDate);
    if(note.state == OptionalState.set) {
      json['note'] = note.toJson();
    }
    return json;
  }

  ScheduleSalaryPaymentVariables({
    required this.memberId,
    required this.amount,
    required this.paymentDate,
    required this.note,
  });
}

