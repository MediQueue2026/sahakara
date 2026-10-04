part of 'sahakara.dart';

class CurrentContractVariablesBuilder {
  String memberId;

  final FirebaseDataConnect _dataConnect;
  CurrentContractVariablesBuilder(this._dataConnect, {required  this.memberId,});
  Deserializer<CurrentContractData> dataDeserializer = (dynamic json)  => CurrentContractData.fromJson(jsonDecode(json));
  Serializer<CurrentContractVariables> varsSerializer = (CurrentContractVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<CurrentContractData, CurrentContractVariables>> execute() {
    return ref().execute();
  }

  QueryRef<CurrentContractData, CurrentContractVariables> ref() {
    CurrentContractVariables vars= CurrentContractVariables(memberId: memberId,);
    return _dataConnect.query("CurrentContract", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CurrentContractContracts {
  final String id;
  final EnumValue<PayType> payType;
  final double rate;
  final double? allowance;
  final String? offDays;
  final String? workingHours;
  final DateTime startDate;
  CurrentContractContracts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  payType = payTypeDeserializer(json['payType']),
  rate = nativeFromJson<double>(json['rate']),
  allowance = json['allowance'] == null ? null : nativeFromJson<double>(json['allowance']),
  offDays = json['offDays'] == null ? null : nativeFromJson<String>(json['offDays']),
  workingHours = json['workingHours'] == null ? null : nativeFromJson<String>(json['workingHours']),
  startDate = nativeFromJson<DateTime>(json['startDate']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CurrentContractContracts otherTyped = other as CurrentContractContracts;
    return id == otherTyped.id && 
    payType == otherTyped.payType && 
    rate == otherTyped.rate && 
    allowance == otherTyped.allowance && 
    offDays == otherTyped.offDays && 
    workingHours == otherTyped.workingHours && 
    startDate == otherTyped.startDate;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, payType.hashCode, rate.hashCode, allowance.hashCode, offDays.hashCode, workingHours.hashCode, startDate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['payType'] = 
    payTypeSerializer(payType)
    ;
    json['rate'] = nativeToJson<double>(rate);
    if (allowance != null) {
      json['allowance'] = nativeToJson<double?>(allowance);
    }
    if (offDays != null) {
      json['offDays'] = nativeToJson<String?>(offDays);
    }
    if (workingHours != null) {
      json['workingHours'] = nativeToJson<String?>(workingHours);
    }
    json['startDate'] = nativeToJson<DateTime>(startDate);
    return json;
  }

  CurrentContractContracts({
    required this.id,
    required this.payType,
    required this.rate,
    this.allowance,
    this.offDays,
    this.workingHours,
    required this.startDate,
  });
}

@immutable
class CurrentContractData {
  final List<CurrentContractContracts> contracts;
  CurrentContractData.fromJson(dynamic json):
  
  contracts = (json['contracts'] as List<dynamic>)
        .map((e) => CurrentContractContracts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CurrentContractData otherTyped = other as CurrentContractData;
    return contracts == otherTyped.contracts;
    
  }
  @override
  int get hashCode => contracts.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['contracts'] = contracts.map((e) => e.toJson()).toList();
    return json;
  }

  CurrentContractData({
    required this.contracts,
  });
}

@immutable
class CurrentContractVariables {
  final String memberId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CurrentContractVariables.fromJson(Map<String, dynamic> json):
  
  memberId = nativeFromJson<String>(json['memberId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CurrentContractVariables otherTyped = other as CurrentContractVariables;
    return memberId == otherTyped.memberId;
    
  }
  @override
  int get hashCode => memberId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['memberId'] = nativeToJson<String>(memberId);
    return json;
  }

  CurrentContractVariables({
    required this.memberId,
  });
}

