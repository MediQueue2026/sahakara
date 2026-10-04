part of 'sahakara.dart';

class ApproveAdvanceRequestVariablesBuilder {
  String id;
  String month;

  final FirebaseDataConnect _dataConnect;
  ApproveAdvanceRequestVariablesBuilder(this._dataConnect, {required  this.id,required  this.month,});
  Deserializer<ApproveAdvanceRequestData> dataDeserializer = (dynamic json)  => ApproveAdvanceRequestData.fromJson(jsonDecode(json));
  Serializer<ApproveAdvanceRequestVariables> varsSerializer = (ApproveAdvanceRequestVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ApproveAdvanceRequestData, ApproveAdvanceRequestVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ApproveAdvanceRequestData, ApproveAdvanceRequestVariables> ref() {
    ApproveAdvanceRequestVariables vars= ApproveAdvanceRequestVariables(id: id,month: month,);
    return _dataConnect.mutation("ApproveAdvanceRequest", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ApproveAdvanceRequestAdvanceInsert {
  final String id;
  ApproveAdvanceRequestAdvanceInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ApproveAdvanceRequestAdvanceInsert otherTyped = other as ApproveAdvanceRequestAdvanceInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ApproveAdvanceRequestAdvanceInsert({
    required this.id,
  });
}

@immutable
class ApproveAdvanceRequestAdvanceRequestUpdate {
  final String id;
  ApproveAdvanceRequestAdvanceRequestUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ApproveAdvanceRequestAdvanceRequestUpdate otherTyped = other as ApproveAdvanceRequestAdvanceRequestUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ApproveAdvanceRequestAdvanceRequestUpdate({
    required this.id,
  });
}

@immutable
class ApproveAdvanceRequestLedgerEntryInsert {
  final String id;
  ApproveAdvanceRequestLedgerEntryInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ApproveAdvanceRequestLedgerEntryInsert otherTyped = other as ApproveAdvanceRequestLedgerEntryInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ApproveAdvanceRequestLedgerEntryInsert({
    required this.id,
  });
}

@immutable
class ApproveAdvanceRequestData {
  final ApproveAdvanceRequestAdvanceInsert advance_insert;
  final ApproveAdvanceRequestAdvanceRequestUpdate? advanceRequest_update;
  final ApproveAdvanceRequestLedgerEntryInsert ledgerEntry_insert;
  ApproveAdvanceRequestData.fromJson(dynamic json):
  
  advance_insert = ApproveAdvanceRequestAdvanceInsert.fromJson(json['advance_insert']),
  advanceRequest_update = json['advanceRequest_update'] == null ? null : ApproveAdvanceRequestAdvanceRequestUpdate.fromJson(json['advanceRequest_update']),
  ledgerEntry_insert = ApproveAdvanceRequestLedgerEntryInsert.fromJson(json['ledgerEntry_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ApproveAdvanceRequestData otherTyped = other as ApproveAdvanceRequestData;
    return advance_insert == otherTyped.advance_insert && 
    advanceRequest_update == otherTyped.advanceRequest_update && 
    ledgerEntry_insert == otherTyped.ledgerEntry_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([advance_insert.hashCode, advanceRequest_update.hashCode, ledgerEntry_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['advance_insert'] = advance_insert.toJson();
    if (advanceRequest_update != null) {
      json['advanceRequest_update'] = advanceRequest_update!.toJson();
    }
    json['ledgerEntry_insert'] = ledgerEntry_insert.toJson();
    return json;
  }

  ApproveAdvanceRequestData({
    required this.advance_insert,
    this.advanceRequest_update,
    required this.ledgerEntry_insert,
  });
}

@immutable
class ApproveAdvanceRequestVariables {
  final String id;
  final String month;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ApproveAdvanceRequestVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  month = nativeFromJson<String>(json['month']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ApproveAdvanceRequestVariables otherTyped = other as ApproveAdvanceRequestVariables;
    return id == otherTyped.id && 
    month == otherTyped.month;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, month.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['month'] = nativeToJson<String>(month);
    return json;
  }

  ApproveAdvanceRequestVariables({
    required this.id,
    required this.month,
  });
}

