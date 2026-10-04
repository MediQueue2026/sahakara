part of 'sahakara.dart';

class RejectAdvanceRequestVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  RejectAdvanceRequestVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<RejectAdvanceRequestData> dataDeserializer = (dynamic json)  => RejectAdvanceRequestData.fromJson(jsonDecode(json));
  Serializer<RejectAdvanceRequestVariables> varsSerializer = (RejectAdvanceRequestVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RejectAdvanceRequestData, RejectAdvanceRequestVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RejectAdvanceRequestData, RejectAdvanceRequestVariables> ref() {
    RejectAdvanceRequestVariables vars= RejectAdvanceRequestVariables(id: id,);
    return _dataConnect.mutation("RejectAdvanceRequest", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class RejectAdvanceRequestAdvanceRequestUpdate {
  final String id;
  RejectAdvanceRequestAdvanceRequestUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RejectAdvanceRequestAdvanceRequestUpdate otherTyped = other as RejectAdvanceRequestAdvanceRequestUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RejectAdvanceRequestAdvanceRequestUpdate({
    required this.id,
  });
}

@immutable
class RejectAdvanceRequestData {
  final RejectAdvanceRequestAdvanceRequestUpdate? advanceRequest_update;
  RejectAdvanceRequestData.fromJson(dynamic json):
  
  advanceRequest_update = json['advanceRequest_update'] == null ? null : RejectAdvanceRequestAdvanceRequestUpdate.fromJson(json['advanceRequest_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RejectAdvanceRequestData otherTyped = other as RejectAdvanceRequestData;
    return advanceRequest_update == otherTyped.advanceRequest_update;
    
  }
  @override
  int get hashCode => advanceRequest_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (advanceRequest_update != null) {
      json['advanceRequest_update'] = advanceRequest_update!.toJson();
    }
    return json;
  }

  RejectAdvanceRequestData({
    this.advanceRequest_update,
  });
}

@immutable
class RejectAdvanceRequestVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RejectAdvanceRequestVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final RejectAdvanceRequestVariables otherTyped = other as RejectAdvanceRequestVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RejectAdvanceRequestVariables({
    required this.id,
  });
}

