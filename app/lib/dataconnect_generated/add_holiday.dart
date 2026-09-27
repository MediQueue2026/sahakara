part of 'sahakara.dart';

class AddHolidayVariablesBuilder {
  DateTime date;
  HolidayType type;
  String nameEn;
  Optional<String> _nameSi = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _nameTa = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AddHolidayVariablesBuilder nameSi(String? t) {
   _nameSi.value = t;
   return this;
  }
  AddHolidayVariablesBuilder nameTa(String? t) {
   _nameTa.value = t;
   return this;
  }

  AddHolidayVariablesBuilder(this._dataConnect, {required  this.date,required  this.type,required  this.nameEn,});
  Deserializer<AddHolidayData> dataDeserializer = (dynamic json)  => AddHolidayData.fromJson(jsonDecode(json));
  Serializer<AddHolidayVariables> varsSerializer = (AddHolidayVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddHolidayData, AddHolidayVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddHolidayData, AddHolidayVariables> ref() {
    AddHolidayVariables vars= AddHolidayVariables(date: date,type: type,nameEn: nameEn,nameSi: _nameSi,nameTa: _nameTa,);
    return _dataConnect.mutation("AddHoliday", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddHolidayHolidayInsert {
  final String id;
  AddHolidayHolidayInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddHolidayHolidayInsert otherTyped = other as AddHolidayHolidayInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddHolidayHolidayInsert({
    required this.id,
  });
}

@immutable
class AddHolidayData {
  final AddHolidayHolidayInsert holiday_insert;
  AddHolidayData.fromJson(dynamic json):
  
  holiday_insert = AddHolidayHolidayInsert.fromJson(json['holiday_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddHolidayData otherTyped = other as AddHolidayData;
    return holiday_insert == otherTyped.holiday_insert;
    
  }
  @override
  int get hashCode => holiday_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['holiday_insert'] = holiday_insert.toJson();
    return json;
  }

  AddHolidayData({
    required this.holiday_insert,
  });
}

@immutable
class AddHolidayVariables {
  final DateTime date;
  final HolidayType type;
  final String nameEn;
  late final Optional<String>nameSi;
  late final Optional<String>nameTa;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddHolidayVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  type = HolidayType.values.byName(json['type']),
  nameEn = nativeFromJson<String>(json['nameEn']) {
  
  
  
  
  
    nameSi = Optional.optional(nativeFromJson, nativeToJson);
    nameSi.value = json['nameSi'] == null ? null : nativeFromJson<String>(json['nameSi']);
  
  
    nameTa = Optional.optional(nativeFromJson, nativeToJson);
    nameTa.value = json['nameTa'] == null ? null : nativeFromJson<String>(json['nameTa']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddHolidayVariables otherTyped = other as AddHolidayVariables;
    return date == otherTyped.date && 
    type == otherTyped.type && 
    nameEn == otherTyped.nameEn && 
    nameSi == otherTyped.nameSi && 
    nameTa == otherTyped.nameTa;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, type.hashCode, nameEn.hashCode, nameSi.hashCode, nameTa.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['type'] = 
    type.name
    ;
    json['nameEn'] = nativeToJson<String>(nameEn);
    if(nameSi.state == OptionalState.set) {
      json['nameSi'] = nameSi.toJson();
    }
    if(nameTa.state == OptionalState.set) {
      json['nameTa'] = nameTa.toJson();
    }
    return json;
  }

  AddHolidayVariables({
    required this.date,
    required this.type,
    required this.nameEn,
    required this.nameSi,
    required this.nameTa,
  });
}

