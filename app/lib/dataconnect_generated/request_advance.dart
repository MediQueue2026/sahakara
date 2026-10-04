part of 'sahakara.dart';

class RequestAdvanceVariablesBuilder {
  String memberId;
  double amount;
  Optional<String> _reason = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  RequestAdvanceVariablesBuilder reason(String? t) {
   _reason.value = t;
   return this;
  }

  RequestAdvanceVariablesBuilder(this._dataConnect, {required  this.memberId,required  this.amount,});
  Deserializer<RequestAdvanceData> dataDeserializer = (dynamic json)  => RequestAdvanceData.fromJson(jsonDecode(json));
  Serializer<RequestAdvanceVariables> varsSerializer = (RequestAdvanceVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RequestAdvanceData, RequestAdvanceVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RequestAdvanceData, RequestAdvanceVariables> ref() {
    RequestAdvanceVariables vars= RequestAdvanceVariables(memberId: memberId,amount: amount,reason: _reason,);
    return _dataConnect.mutation("RequestAdvance", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class RequestAdvanceAdvanceRequestInsert {
  final String id;
  RequestAdvanceAdvanceRequestInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RequestAdvanceAdvanceRequestInsert otherTyped = other as RequestAdvanceAdvanceRequestInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RequestAdvanceAdvanceRequestInsert({
    required this.id,
  });
}

@immutable
class RequestAdvanceData {
  final RequestAdvanceAdvanceRequestInsert advanceRequest_insert;
  RequestAdvanceData.fromJson(dynamic json):
  
  advanceRequest_insert = RequestAdvanceAdvanceRequestInsert.fromJson(json['advanceRequest_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RequestAdvanceData otherTyped = other as RequestAdvanceData;
    return advanceRequest_insert == otherTyped.advanceRequest_insert;
    
  }
  @override
  int get hashCode => advanceRequest_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['advanceRequest_insert'] = advanceRequest_insert.toJson();
    return json;
  }

  RequestAdvanceData({
    required this.advanceRequest_insert,
  });
}

@immutable
class RequestAdvanceVariables {
  final String memberId;
  final double amount;
  late final Optional<String>reason;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RequestAdvanceVariables.fromJson(Map<String, dynamic> json):
  
  memberId = nativeFromJson<String>(json['memberId']),
  amount = nativeFromJson<double>(json['amount']) {
  
  
  
  
    reason = Optional.optional(nativeFromJson, nativeToJson);
    reason.value = json['reason'] == null ? null : nativeFromJson<String>(json['reason']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RequestAdvanceVariables otherTyped = other as RequestAdvanceVariables;
    return memberId == otherTyped.memberId && 
    amount == otherTyped.amount && 
    reason == otherTyped.reason;
    
  }
  @override
  int get hashCode => Object.hashAll([memberId.hashCode, amount.hashCode, reason.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['memberId'] = nativeToJson<String>(memberId);
    json['amount'] = nativeToJson<double>(amount);
    if(reason.state == OptionalState.set) {
      json['reason'] = reason.toJson();
    }
    return json;
  }

  RequestAdvanceVariables({
    required this.memberId,
    required this.amount,
    required this.reason,
  });
}

