part of 'sahakara.dart';

class SaveContractVariablesBuilder {
  String memberId;
  PayType payType;
  double rate;
  Optional<String> _offDays = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _workingHours = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  SaveContractVariablesBuilder offDays(String? t) {
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
    SaveContractVariables vars= SaveContractVariables(memberId: memberId,payType: payType,rate: rate,offDays: _offDays,workingHours: _workingHours,);
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
  late final Optional<String>offDays;
  late final Optional<String>workingHours;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SaveContractVariables.fromJson(Map<String, dynamic> json):
  
  memberId = nativeFromJson<String>(json['memberId']),
  payType = PayType.values.byName(json['payType']),
  rate = nativeFromJson<double>(json['rate']) {
  
  
  
  
  
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
    offDays == otherTyped.offDays && 
    workingHours == otherTyped.workingHours;
    
  }
  @override
  int get hashCode => Object.hashAll([memberId.hashCode, payType.hashCode, rate.hashCode, offDays.hashCode, workingHours.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['memberId'] = nativeToJson<String>(memberId);
    json['payType'] = 
    payType.name
    ;
    json['rate'] = nativeToJson<double>(rate);
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
    required this.offDays,
    required this.workingHours,
  });
}

