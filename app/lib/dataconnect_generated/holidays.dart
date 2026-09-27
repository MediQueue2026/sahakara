part of 'sahakara.dart';

class HolidaysVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  HolidaysVariablesBuilder(this._dataConnect, );
  Deserializer<HolidaysData> dataDeserializer = (dynamic json)  => HolidaysData.fromJson(jsonDecode(json));
  
  Future<QueryResult<HolidaysData, void>> execute() {
    return ref().execute();
  }

  QueryRef<HolidaysData, void> ref() {
    
    return _dataConnect.query("Holidays", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class HolidaysHolidays {
  final String id;
  final DateTime date;
  final EnumValue<HolidayType> type;
  final String nameEn;
  final String? nameSi;
  final String? nameTa;
  HolidaysHolidays.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  type = holidayTypeDeserializer(json['type']),
  nameEn = nativeFromJson<String>(json['nameEn']),
  nameSi = json['nameSi'] == null ? null : nativeFromJson<String>(json['nameSi']),
  nameTa = json['nameTa'] == null ? null : nativeFromJson<String>(json['nameTa']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HolidaysHolidays otherTyped = other as HolidaysHolidays;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    type == otherTyped.type && 
    nameEn == otherTyped.nameEn && 
    nameSi == otherTyped.nameSi && 
    nameTa == otherTyped.nameTa;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, type.hashCode, nameEn.hashCode, nameSi.hashCode, nameTa.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['type'] = 
    holidayTypeSerializer(type)
    ;
    json['nameEn'] = nativeToJson<String>(nameEn);
    if (nameSi != null) {
      json['nameSi'] = nativeToJson<String?>(nameSi);
    }
    if (nameTa != null) {
      json['nameTa'] = nativeToJson<String?>(nameTa);
    }
    return json;
  }

  HolidaysHolidays({
    required this.id,
    required this.date,
    required this.type,
    required this.nameEn,
    this.nameSi,
    this.nameTa,
  });
}

@immutable
class HolidaysData {
  final List<HolidaysHolidays> holidays;
  HolidaysData.fromJson(dynamic json):
  
  holidays = (json['holidays'] as List<dynamic>)
        .map((e) => HolidaysHolidays.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final HolidaysData otherTyped = other as HolidaysData;
    return holidays == otherTyped.holidays;
    
  }
  @override
  int get hashCode => holidays.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['holidays'] = holidays.map((e) => e.toJson()).toList();
    return json;
  }

  HolidaysData({
    required this.holidays,
  });
}

