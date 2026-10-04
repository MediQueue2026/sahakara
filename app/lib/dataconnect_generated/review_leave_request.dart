part of 'sahakara.dart';

class ReviewLeaveRequestVariablesBuilder {
  String id;
  LeaveStatus status;

  final FirebaseDataConnect _dataConnect;
  ReviewLeaveRequestVariablesBuilder(this._dataConnect, {required  this.id,required  this.status,});
  Deserializer<ReviewLeaveRequestData> dataDeserializer = (dynamic json)  => ReviewLeaveRequestData.fromJson(jsonDecode(json));
  Serializer<ReviewLeaveRequestVariables> varsSerializer = (ReviewLeaveRequestVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ReviewLeaveRequestData, ReviewLeaveRequestVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ReviewLeaveRequestData, ReviewLeaveRequestVariables> ref() {
    ReviewLeaveRequestVariables vars= ReviewLeaveRequestVariables(id: id,status: status,);
    return _dataConnect.mutation("ReviewLeaveRequest", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ReviewLeaveRequestLeaveRequestUpdate {
  final String id;
  ReviewLeaveRequestLeaveRequestUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReviewLeaveRequestLeaveRequestUpdate otherTyped = other as ReviewLeaveRequestLeaveRequestUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ReviewLeaveRequestLeaveRequestUpdate({
    required this.id,
  });
}

@immutable
class ReviewLeaveRequestData {
  final ReviewLeaveRequestLeaveRequestUpdate? leaveRequest_update;
  ReviewLeaveRequestData.fromJson(dynamic json):
  
  leaveRequest_update = json['leaveRequest_update'] == null ? null : ReviewLeaveRequestLeaveRequestUpdate.fromJson(json['leaveRequest_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReviewLeaveRequestData otherTyped = other as ReviewLeaveRequestData;
    return leaveRequest_update == otherTyped.leaveRequest_update;
    
  }
  @override
  int get hashCode => leaveRequest_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (leaveRequest_update != null) {
      json['leaveRequest_update'] = leaveRequest_update!.toJson();
    }
    return json;
  }

  ReviewLeaveRequestData({
    this.leaveRequest_update,
  });
}

@immutable
class ReviewLeaveRequestVariables {
  final String id;
  final LeaveStatus status;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ReviewLeaveRequestVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  status = LeaveStatus.values.byName(json['status']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReviewLeaveRequestVariables otherTyped = other as ReviewLeaveRequestVariables;
    return id == otherTyped.id && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['status'] = 
    status.name
    ;
    return json;
  }

  ReviewLeaveRequestVariables({
    required this.id,
    required this.status,
  });
}

