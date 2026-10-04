part of 'sahakara.dart';

class HouseholdSalaryPaymentsVariablesBuilder {
  String householdId;

  final FirebaseDataConnect _dataConnect;
  HouseholdSalaryPaymentsVariablesBuilder(this._dataConnect, {required  this.householdId,});
  Deserializer<HouseholdSalaryPaymentsData> dataDeserializer = (dynamic json)  => HouseholdSalaryPaymentsData.fromJson(jsonDecode(json));
  Serializer<HouseholdSalaryPaymentsVariables> varsSerializer = (HouseholdSalaryPaymentsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<HouseholdSalaryPaymentsData, HouseholdSalaryPaymentsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<HouseholdSalaryPaymentsData, HouseholdSalaryPaymentsVariables> ref() {
    HouseholdSalaryPaymentsVariables vars= HouseholdSalaryPaymentsVariables(householdId: householdId,);
    return _dataConnect.query("HouseholdSalaryPayments", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class HouseholdSalaryPaymentsSalaryPayments {
  final String id;
  final double amount;
  final DateTime paymentDate;
  final EnumValue<SalaryPaymentStatus> status;
  final String? note;
  final Timestamp? paidAt;
  final HouseholdSalaryPaymentsSalaryPaymentsMember member;
  HouseholdSalaryPaymentsSalaryPayments.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  amount = nativeFromJson<double>(json['amount']),
  paymentDate = nativeFromJson<DateTime>(json['paymentDate']),
  status = salaryPaymentStatusDeserializer(json['status']),
  note = json['note'] == null ? null : nativeFromJson<String>(json['note']),
  paidAt = json['paidAt'] == null ? null : Timestamp.fromJson(json['paidAt']),
  member = HouseholdSalaryPaymentsSalaryPaymentsMember.fromJson(json['member']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdSalaryPaymentsSalaryPayments otherTyped = other as HouseholdSalaryPaymentsSalaryPayments;
    return id == otherTyped.id && 
    amount == otherTyped.amount && 
    paymentDate == otherTyped.paymentDate && 
    status == otherTyped.status && 
    note == otherTyped.note && 
    paidAt == otherTyped.paidAt && 
    member == otherTyped.member;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, amount.hashCode, paymentDate.hashCode, status.hashCode, note.hashCode, paidAt.hashCode, member.hashCode]);
  

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
    json['member'] = member.toJson();
    return json;
  }

  HouseholdSalaryPaymentsSalaryPayments({
    required this.id,
    required this.amount,
    required this.paymentDate,
    required this.status,
    this.note,
    this.paidAt,
    required this.member,
  });
}

@immutable
class HouseholdSalaryPaymentsSalaryPaymentsMember {
  final String id;
  final HouseholdSalaryPaymentsSalaryPaymentsMemberUser user;
  HouseholdSalaryPaymentsSalaryPaymentsMember.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  user = HouseholdSalaryPaymentsSalaryPaymentsMemberUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdSalaryPaymentsSalaryPaymentsMember otherTyped = other as HouseholdSalaryPaymentsSalaryPaymentsMember;
    return id == otherTyped.id && 
    user == otherTyped.user;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, user.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['user'] = user.toJson();
    return json;
  }

  HouseholdSalaryPaymentsSalaryPaymentsMember({
    required this.id,
    required this.user,
  });
}

@immutable
class HouseholdSalaryPaymentsSalaryPaymentsMemberUser {
  final String name;
  HouseholdSalaryPaymentsSalaryPaymentsMemberUser.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdSalaryPaymentsSalaryPaymentsMemberUser otherTyped = other as HouseholdSalaryPaymentsSalaryPaymentsMemberUser;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  HouseholdSalaryPaymentsSalaryPaymentsMemberUser({
    required this.name,
  });
}

@immutable
class HouseholdSalaryPaymentsData {
  final List<HouseholdSalaryPaymentsSalaryPayments> salaryPayments;
  HouseholdSalaryPaymentsData.fromJson(dynamic json):
  
  salaryPayments = (json['salaryPayments'] as List<dynamic>)
        .map((e) => HouseholdSalaryPaymentsSalaryPayments.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdSalaryPaymentsData otherTyped = other as HouseholdSalaryPaymentsData;
    return salaryPayments == otherTyped.salaryPayments;
    
  }
  @override
  int get hashCode => salaryPayments.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['salaryPayments'] = salaryPayments.map((e) => e.toJson()).toList();
    return json;
  }

  HouseholdSalaryPaymentsData({
    required this.salaryPayments,
  });
}

@immutable
class HouseholdSalaryPaymentsVariables {
  final String householdId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  HouseholdSalaryPaymentsVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HouseholdSalaryPaymentsVariables otherTyped = other as HouseholdSalaryPaymentsVariables;
    return householdId == otherTyped.householdId;
    
  }
  @override
  int get hashCode => householdId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    return json;
  }

  HouseholdSalaryPaymentsVariables({
    required this.householdId,
  });
}

