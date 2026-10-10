part of 'sahakara.dart';

class InviteHouseholdMemberVariablesBuilder {
  String householdId;
  String email;
  MemberRole role;
  PayType payType;
  double rate;
  Optional<double> _allowance = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _durationMonths = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _durationDays = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _offDays = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _workingHours = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  InviteHouseholdMemberVariablesBuilder allowance(double? t) {
   _allowance.value = t;
   return this;
  }
  InviteHouseholdMemberVariablesBuilder durationMonths(int? t) {
   _durationMonths.value = t;
   return this;
  }
  InviteHouseholdMemberVariablesBuilder durationDays(int? t) {
   _durationDays.value = t;
   return this;
  }
  InviteHouseholdMemberVariablesBuilder offDays(String? t) {
   _offDays.value = t;
   return this;
  }
  InviteHouseholdMemberVariablesBuilder workingHours(String? t) {
   _workingHours.value = t;
   return this;
  }

  InviteHouseholdMemberVariablesBuilder(this._dataConnect, {required  this.householdId,required  this.email,required  this.role,required  this.payType,required  this.rate,});
  Deserializer<InviteHouseholdMemberData> dataDeserializer = (dynamic json)  => InviteHouseholdMemberData.fromJson(jsonDecode(json));
  Serializer<InviteHouseholdMemberVariables> varsSerializer = (InviteHouseholdMemberVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InviteHouseholdMemberData, InviteHouseholdMemberVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InviteHouseholdMemberData, InviteHouseholdMemberVariables> ref() {
    InviteHouseholdMemberVariables vars= InviteHouseholdMemberVariables(householdId: householdId,email: email,role: role,payType: payType,rate: rate,allowance: _allowance,durationMonths: _durationMonths,durationDays: _durationDays,offDays: _offDays,workingHours: _workingHours,);
    return _dataConnect.mutation("InviteHouseholdMember", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InviteHouseholdMemberUserInsert {
  final String id;
  InviteHouseholdMemberUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InviteHouseholdMemberUserInsert otherTyped = other as InviteHouseholdMemberUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InviteHouseholdMemberUserInsert({
    required this.id,
  });
}

@immutable
class InviteHouseholdMemberHouseholdMemberInsert {
  final String id;
  InviteHouseholdMemberHouseholdMemberInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InviteHouseholdMemberHouseholdMemberInsert otherTyped = other as InviteHouseholdMemberHouseholdMemberInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InviteHouseholdMemberHouseholdMemberInsert({
    required this.id,
  });
}

@immutable
class InviteHouseholdMemberContractInsert {
  final String id;
  InviteHouseholdMemberContractInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InviteHouseholdMemberContractInsert otherTyped = other as InviteHouseholdMemberContractInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InviteHouseholdMemberContractInsert({
    required this.id,
  });
}

@immutable
class InviteHouseholdMemberData {
  final InviteHouseholdMemberUserInsert user_insert;
  final InviteHouseholdMemberHouseholdMemberInsert householdMember_insert;
  final InviteHouseholdMemberContractInsert contract_insert;
  InviteHouseholdMemberData.fromJson(dynamic json):
  
  user_insert = InviteHouseholdMemberUserInsert.fromJson(json['user_insert']),
  householdMember_insert = InviteHouseholdMemberHouseholdMemberInsert.fromJson(json['householdMember_insert']),
  contract_insert = InviteHouseholdMemberContractInsert.fromJson(json['contract_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InviteHouseholdMemberData otherTyped = other as InviteHouseholdMemberData;
    return user_insert == otherTyped.user_insert && 
    householdMember_insert == otherTyped.householdMember_insert && 
    contract_insert == otherTyped.contract_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([user_insert.hashCode, householdMember_insert.hashCode, contract_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    json['householdMember_insert'] = householdMember_insert.toJson();
    json['contract_insert'] = contract_insert.toJson();
    return json;
  }

  InviteHouseholdMemberData({
    required this.user_insert,
    required this.householdMember_insert,
    required this.contract_insert,
  });
}

@immutable
class InviteHouseholdMemberVariables {
  final String householdId;
  final String email;
  final MemberRole role;
  final PayType payType;
  final double rate;
  late final Optional<double>allowance;
  late final Optional<int>durationMonths;
  late final Optional<int>durationDays;
  late final Optional<String>offDays;
  late final Optional<String>workingHours;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InviteHouseholdMemberVariables.fromJson(Map<String, dynamic> json):
  
  householdId = nativeFromJson<String>(json['householdId']),
  email = nativeFromJson<String>(json['email']),
  role = MemberRole.values.byName(json['role']),
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

    final InviteHouseholdMemberVariables otherTyped = other as InviteHouseholdMemberVariables;
    return householdId == otherTyped.householdId && 
    email == otherTyped.email && 
    role == otherTyped.role && 
    payType == otherTyped.payType && 
    rate == otherTyped.rate && 
    allowance == otherTyped.allowance && 
    durationMonths == otherTyped.durationMonths && 
    durationDays == otherTyped.durationDays && 
    offDays == otherTyped.offDays && 
    workingHours == otherTyped.workingHours;
    
  }
  @override
  int get hashCode => Object.hashAll([householdId.hashCode, email.hashCode, role.hashCode, payType.hashCode, rate.hashCode, allowance.hashCode, durationMonths.hashCode, durationDays.hashCode, offDays.hashCode, workingHours.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['householdId'] = nativeToJson<String>(householdId);
    json['email'] = nativeToJson<String>(email);
    json['role'] = 
    role.name
    ;
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

  InviteHouseholdMemberVariables({
    required this.householdId,
    required this.email,
    required this.role,
    required this.payType,
    required this.rate,
    required this.allowance,
    required this.durationMonths,
    required this.durationDays,
    required this.offDays,
    required this.workingHours,
  });
}

