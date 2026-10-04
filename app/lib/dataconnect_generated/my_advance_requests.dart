part of 'sahakara.dart';

class MyAdvanceRequestsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MyAdvanceRequestsVariablesBuilder(this._dataConnect, );
  Deserializer<MyAdvanceRequestsData> dataDeserializer = (dynamic json)  => MyAdvanceRequestsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<MyAdvanceRequestsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<MyAdvanceRequestsData, void> ref() {
    
    return _dataConnect.query("MyAdvanceRequests", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class MyAdvanceRequestsAdvanceRequests {
  final String id;
  final double amount;
  final String? reason;
  final EnumValue<AdvanceRequestStatus> status;
  final Timestamp requestedAt;
  final Timestamp? reviewedAt;
  MyAdvanceRequestsAdvanceRequests.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  amount = nativeFromJson<double>(json['amount']),
  reason = json['reason'] == null ? null : nativeFromJson<String>(json['reason']),
  status = advanceRequestStatusDeserializer(json['status']),
  requestedAt = Timestamp.fromJson(json['requestedAt']),
  reviewedAt = json['reviewedAt'] == null ? null : Timestamp.fromJson(json['reviewedAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyAdvanceRequestsAdvanceRequests otherTyped = other as MyAdvanceRequestsAdvanceRequests;
    return id == otherTyped.id && 
    amount == otherTyped.amount && 
    reason == otherTyped.reason && 
    status == otherTyped.status && 
    requestedAt == otherTyped.requestedAt && 
    reviewedAt == otherTyped.reviewedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, amount.hashCode, reason.hashCode, status.hashCode, requestedAt.hashCode, reviewedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['amount'] = nativeToJson<double>(amount);
    if (reason != null) {
      json['reason'] = nativeToJson<String?>(reason);
    }
    json['status'] = 
    advanceRequestStatusSerializer(status)
    ;
    json['requestedAt'] = requestedAt.toJson();
    if (reviewedAt != null) {
      json['reviewedAt'] = reviewedAt!.toJson();
    }
    return json;
  }

  MyAdvanceRequestsAdvanceRequests({
    required this.id,
    required this.amount,
    this.reason,
    required this.status,
    required this.requestedAt,
    this.reviewedAt,
  });
}

@immutable
class MyAdvanceRequestsData {
  final List<MyAdvanceRequestsAdvanceRequests> advanceRequests;
  MyAdvanceRequestsData.fromJson(dynamic json):
  
  advanceRequests = (json['advanceRequests'] as List<dynamic>)
        .map((e) => MyAdvanceRequestsAdvanceRequests.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MyAdvanceRequestsData otherTyped = other as MyAdvanceRequestsData;
    return advanceRequests == otherTyped.advanceRequests;
    
  }
  @override
  int get hashCode => advanceRequests.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['advanceRequests'] = advanceRequests.map((e) => e.toJson()).toList();
    return json;
  }

  MyAdvanceRequestsData({
    required this.advanceRequests,
  });
}

