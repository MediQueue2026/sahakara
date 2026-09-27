part of 'sahakara.dart';

class DeleteHolidayVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteHolidayVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteHolidayData> dataDeserializer = (dynamic json)  => DeleteHolidayData.fromJson(jsonDecode(json));
  Serializer<DeleteHolidayVariables> varsSerializer = (DeleteHolidayVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteHolidayData, DeleteHolidayVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteHolidayData, DeleteHolidayVariables> ref() {
    DeleteHolidayVariables vars= DeleteHolidayVariables(id: id,);
    return _dataConnect.mutation("DeleteHoliday", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteHolidayHolidayDelete {
  final String id;
  DeleteHolidayHolidayDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteHolidayHolidayDelete otherTyped = other as DeleteHolidayHolidayDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteHolidayHolidayDelete({
    required this.id,
  });
}

@immutable
class DeleteHolidayData {
  final DeleteHolidayHolidayDelete? holiday_delete;
  DeleteHolidayData.fromJson(dynamic json):
  
  holiday_delete = json['holiday_delete'] == null ? null : DeleteHolidayHolidayDelete.fromJson(json['holiday_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteHolidayData otherTyped = other as DeleteHolidayData;
    return holiday_delete == otherTyped.holiday_delete;
    
  }
  @override
  int get hashCode => holiday_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (holiday_delete != null) {
      json['holiday_delete'] = holiday_delete!.toJson();
    }
    return json;
  }

  DeleteHolidayData({
    this.holiday_delete,
  });
}

@immutable
class DeleteHolidayVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteHolidayVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteHolidayVariables otherTyped = other as DeleteHolidayVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteHolidayVariables({
    required this.id,
  });
}

