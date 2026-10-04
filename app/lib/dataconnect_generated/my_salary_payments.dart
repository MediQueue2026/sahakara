part of 'sahakara.dart';

class MySalaryPaymentsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MySalaryPaymentsVariablesBuilder(this._dataConnect, );
  Deserializer<MySalaryPaymentsData> dataDeserializer = (dynamic json)  => MySalaryPaymentsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<MySalaryPaymentsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<MySalaryPaymentsData, void> ref() {
    
    return _dataConnect.query("MySalaryPayments", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class MySalaryPaymentsSalaryPayments {
  final String id;
  final double amount;
  final DateTime paymentDate;
  final EnumValue<SalaryPaymentStatus> status;
  final String? note;
  final Timestamp? paidAt;
  MySalaryPaymentsSalaryPayments.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  amount = nativeFromJson<double>(json['amount']),
  paymentDate = nativeFromJson<DateTime>(json['paymentDate']),
  status = salaryPaymentStatusDeserializer(json['status']),
  note = json['note'] == null ? null : nativeFromJson<String>(json['note']),
  paidAt = json['paidAt'] == null ? null : Timestamp.fromJson(json['paidAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MySalaryPaymentsSalaryPayments otherTyped = other as MySalaryPaymentsSalaryPayments;
    return id == otherTyped.id && 
    amount == otherTyped.amount && 
    paymentDate == otherTyped.paymentDate && 
    status == otherTyped.status && 
    note == otherTyped.note && 
    paidAt == otherTyped.paidAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, amount.hashCode, paymentDate.hashCode, status.hashCode, note.hashCode, paidAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['amount'] = nativeToJson<double>(amount);
    json['paymentDate'] = nativeToJson<DateTime>(paymentDate);
    json['status'] = 
    salaryPaymentStatusSerializer(status)
    ;
    if (note != null) {
      json['note'] = nativeToJson<String?>(note);
    }
    if (paidAt != null) {
      json['paidAt'] = paidAt!.toJson();
    }
    return json;
  }

  MySalaryPaymentsSalaryPayments({
    required this.id,
    required this.amount,
    required this.paymentDate,
    required this.status,
    this.note,
    this.paidAt,
  });
}

@immutable
class MySalaryPaymentsData {
  final List<MySalaryPaymentsSalaryPayments> salaryPayments;
  MySalaryPaymentsData.fromJson(dynamic json):
  
  salaryPayments = (json['salaryPayments'] as List<dynamic>)
        .map((e) => MySalaryPaymentsSalaryPayments.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MySalaryPaymentsData otherTyped = other as MySalaryPaymentsData;
    return salaryPayments == otherTyped.salaryPayments;
    
  }
  @override
  int get hashCode => salaryPayments.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['salaryPayments'] = salaryPayments.map((e) => e.toJson()).toList();
    return json;
  }

  MySalaryPaymentsData({
    required this.salaryPayments,
  });
}

