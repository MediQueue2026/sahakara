part of 'sahakara.dart';

class SaveContractVariablesBuilder {
  String memberId;
  PayType payType;
  double rate;
  Optional<double> _allowance = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _durationMonths = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _durationDays = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _offDays = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _workingHours = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  SaveContractVariablesBuilder allowance(double? t) {
   _allowance.value = t;
   return this;
  }
  SaveContractVariablesBuilder durationMonths(int? t) {
   _durationMonths.value = t;
   return this;
  }
  SaveContractVariablesBuilder durationDays(int? t) {
   _durationDays.value = t;
   return this;
  }
  SaveContractVariablesBuilder offDays(String? t) {
   _offDays.value = t;
   return this;
  }
  SaveContractVariablesBuilder workingHours(String? t) {
   _workingHours.value = t;
   return this;
  }

  SaveContractVariablesBuilder(this._dataConnect, {required  this.memberId,required  this.payType,required  this.rate,});
  Deserializer<SaveContractData> dataDeserializer = (dynamic json)  => SaveContractData.fromJson(jsonDecode(json));
  Serializer<SaveContractVariables> varsSerializer = (SaveContractVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SaveContractData, SaveContractVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SaveContractData, SaveContractVariables> ref() {
    SaveContractVariables vars= SaveContractVariables(memberId: memberId,payType: payType,rate: rate,allowance: _allowance,durationMonths: _durationMonths,durationDays: _durationDays,offDays: _offDays,workingHours: _workingHours,);
    return _dataConnect.mutation("SaveContract", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SaveContractContractInsert {
  final String id;
  SaveContractContractInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SaveContractContractInsert otherTyped = other as SaveContractContractInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SaveContractContractInsert({
    required this.id,
  });
}

@immutable
class SaveContractData {
  final int contract_updateMany;
  final SaveContractContractInsert contract_insert;
  SaveContractData.fromJson(dynamic json):
  
  contract_updateMany = nativeFromJson<int>(json['contract_updateMany']),
  contract_insert = SaveContractContractInsert.fromJson(json['contract_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SaveContractData otherTyped = other as SaveContractData;
    return contract_updateMany == otherTyped.contract_updateMany && 
    contract_insert == otherTyped.contract_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([contract_updateMany.hashCode, contract_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['contract_updateMany'] = nativeToJson<int>(contract_updateMany);
    json['contract_insert'] = contract_insert.toJson();
    return json;
  }

  SaveContractData({
    required this.contract_updateMany,
    required this.contract_insert,
  });
}

@immutable
class SaveContractVariables {
  final String memberId;
  final PayType payType;
  final double rate;
  late final Optional<double>allowance;
  late final Optional<int>durationMonths;
  late final Optional<int>durationDays;
  late final Optional<String>offDays;
  late final Optional<String>workingHours;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SaveContractVariables.fromJson(Map<String, dynamic> json):
  
  memberId = nativeFromJson<String>(json['memberId']),
  payType = PayType.values.byName(json['payType']),
  rate = nativeFromJson<double>(json['rate']) {
  
  
  
  
  
    allowance = Optional.optional(nativeFromJson, nativeToJson);
    allowance.value = json['allowance'] == null ? null : nativeFromJson<double>(json['allowance']);
  
  
    durationMonths = Optional.optional(nativeFromJson, nativeToJson);
    durationMonths.value = json['durationMonths'] == null ? null : nativeFromJson<int>(json['durationMonths']);
  
  
    durationDays = Optional.optional(nativeFromJson, nativeToJson);
    durationDays.value = json['durationDays'] == null ? null : nativeFromJson<int>(json['durationDays']);
  
  
    offDays = Optional.optional(nativeFromJson, nativeToJson);
    offDays.value = json['offDays'] == null ? null : nativeFromJson<String>(json['offDays']);
  
  
    workingHours = Optional.optional(nativeFromJson, nativeToJson);
    workingHours.value = json['workingHours'] == null ? null : nativeFromJson<String>(json['workingHours']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SaveContractVariables otherTyped = other as SaveContractVariables;
    return memberId == otherTyped.memberId && 
    payType == otherTyped.payType && 
    rate == otherTyped.rate && 
    allowance == otherTyped.allowance && 
    durationMonths == otherTyped.durationMonths && 
    durationDays == otherTyped.durationDays && 
    offDays == otherTyped.offDays && 
    workingHours == otherTyped.workingHours;
    
  }
  @override
  int get hashCode => Object.hashAll([memberId.hashCode, payType.hashCode, rate.hashCode, allowance.hashCode, durationMonths.hashCode, durationDays.hashCode, offDays.hashCode, workingHours.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['memberId'] = nativeToJson<String>(memberId);
    json['payType'] = 
    payType.name
    ;
    json['rate'] = nativeToJson<double>(rate);
    if(allowance.state == OptionalState.set) {
      json['allowance'] = allowance.toJson();
    }
    if(durationMonths.state == OptionalState.set) {
      json['durationMonths'] = durationMonths.toJson();
    }
    if(durationDays.state == OptionalState.set) {
      json['durationDays'] = durationDays.toJson();
    }
    if(offDays.state == OptionalState.set) {
      json['offDays'] = offDays.toJson();
    }
    if(workingHours.state == OptionalState.set) {
      json['workingHours'] = workingHours.toJson();
    }
    return json;
  }

  SaveContractVariables({
    required this.memberId,
    required this.payType,
    required this.rate,
    required this.allowance,
    required this.durationMonths,
    required this.durationDays,
    required this.offDays,
    required this.workingHours,
  });
}

