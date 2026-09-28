library sahakara;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

part 'claim_invited_profile.dart';

part 'create_my_profile.dart';

part 'set_my_name.dart';

part 'set_my_language.dart';

part 'create_household.dart';

part 'add_household_member.dart';

part 'invite_household_member.dart';

part 'save_contract.dart';

part 'add_library_task.dart';

part 'delete_library_task.dart';

part 'add_holiday.dart';

part 'delete_holiday.dart';

part 'my_profile.dart';

part 'my_membership.dart';

part 'household_members.dart';

part 'user_id_by_email.dart';

part 'current_contract.dart';

part 'library_tasks.dart';

part 'holidays.dart';

part 'admin_households.dart';



  enum AccountType {
    
      owner,
    
      maid,
    
  }
  
  String accountTypeSerializer(EnumValue<AccountType> e) {
    return e.stringValue;
  }
  EnumValue<AccountType> accountTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'owner':
        return const Known(AccountType.owner);
      
      case 'maid':
        return const Known(AccountType.maid);
      
      default:
        return Unknown(data);
    }
  }
  

  enum AppLanguage {
    
      si,
    
      ta,
    
      en,
    
  }
  
  String appLanguageSerializer(EnumValue<AppLanguage> e) {
    return e.stringValue;
  }
  EnumValue<AppLanguage> appLanguageDeserializer(dynamic data) {
    switch (data) {
      
      case 'si':
        return const Known(AppLanguage.si);
      
      case 'ta':
        return const Known(AppLanguage.ta);
      
      case 'en':
        return const Known(AppLanguage.en);
      
      default:
        return Unknown(data);
    }
  }
  

  enum HolidayType {
    
      poya,
    
      public,
    
      festival,
    
  }
  
  String holidayTypeSerializer(EnumValue<HolidayType> e) {
    return e.stringValue;
  }
  EnumValue<HolidayType> holidayTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'poya':
        return const Known(HolidayType.poya);
      
      case 'public':
        return const Known(HolidayType.public);
      
      case 'festival':
        return const Known(HolidayType.festival);
      
      default:
        return Unknown(data);
    }
  }
  

  enum MemberRole {
    
      owner,
    
      adult,
    
      maid,
    
      driver,
    
      cook,
    
      gardener,
    
  }
  
  String memberRoleSerializer(EnumValue<MemberRole> e) {
    return e.stringValue;
  }
  EnumValue<MemberRole> memberRoleDeserializer(dynamic data) {
    switch (data) {
      
      case 'owner':
        return const Known(MemberRole.owner);
      
      case 'adult':
        return const Known(MemberRole.adult);
      
      case 'maid':
        return const Known(MemberRole.maid);
      
      case 'driver':
        return const Known(MemberRole.driver);
      
      case 'cook':
        return const Known(MemberRole.cook);
      
      case 'gardener':
        return const Known(MemberRole.gardener);
      
      default:
        return Unknown(data);
    }
  }
  

  enum PayType {
    
      monthly,
    
      daily,
    
      hourly,
    
      per_visit,
    
  }
  
  String payTypeSerializer(EnumValue<PayType> e) {
    return e.stringValue;
  }
  EnumValue<PayType> payTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'monthly':
        return const Known(PayType.monthly);
      
      case 'daily':
        return const Known(PayType.daily);
      
      case 'hourly':
        return const Known(PayType.hourly);
      
      case 'per_visit':
        return const Known(PayType.per_visit);
      
      default:
        return Unknown(data);
    }
  }
  

  enum TaskCategory {
    
      kitchen,
    
      cleaning,
    
      laundry,
    
      cooking,
    
      other,
    
  }
  
  String taskCategorySerializer(EnumValue<TaskCategory> e) {
    return e.stringValue;
  }
  EnumValue<TaskCategory> taskCategoryDeserializer(dynamic data) {
    switch (data) {
      
      case 'kitchen':
        return const Known(TaskCategory.kitchen);
      
      case 'cleaning':
        return const Known(TaskCategory.cleaning);
      
      case 'laundry':
        return const Known(TaskCategory.laundry);
      
      case 'cooking':
        return const Known(TaskCategory.cooking);
      
      case 'other':
        return const Known(TaskCategory.other);
      
      default:
        return Unknown(data);
    }
  }
  



String enumSerializer(Enum e) {
  return e.name;
}



/// A sealed class representing either a known enum value or an unknown string value.
@immutable
sealed class EnumValue<T extends Enum> {
  const EnumValue();

  

  /// The string representation of the value.
  String get stringValue;
  @override
  String toString() {
    return "EnumValue($stringValue)";
  }
}

/// Represents a known, valid enum value.
class Known<T extends Enum> extends EnumValue<T> {
  /// The actual enum value.
  final T value;

  const Known(this.value);

  @override
  String get stringValue => value.name;

  @override
  String toString() {
    return "Known($stringValue)";
  }
}
/// Represents an unknown or unrecognized enum value.
class Unknown extends EnumValue<Never> {
  /// The raw string value that couldn't be mapped to a known enum.
  @override
  final String stringValue;

  const Unknown(this.stringValue);
  @override
  String toString() {
    return "Unknown($stringValue)";
  }
}

class SahakaraConnector {
  
  
  ClaimInvitedProfileVariablesBuilder claimInvitedProfile () {
    return ClaimInvitedProfileVariablesBuilder(dataConnect, );
  }
  
  
  CreateMyProfileVariablesBuilder createMyProfile ({required String name, required AccountType accountType, }) {
    return CreateMyProfileVariablesBuilder(dataConnect, name: name,accountType: accountType,);
  }
  
  
  SetMyNameVariablesBuilder setMyName ({required String name, }) {
    return SetMyNameVariablesBuilder(dataConnect, name: name,);
  }
  
  
  SetMyLanguageVariablesBuilder setMyLanguage ({required AppLanguage language, }) {
    return SetMyLanguageVariablesBuilder(dataConnect, language: language,);
  }
  
  
  CreateHouseholdVariablesBuilder createHousehold ({required String name, }) {
    return CreateHouseholdVariablesBuilder(dataConnect, name: name,);
  }
  
  
  AddHouseholdMemberVariablesBuilder addHouseholdMember ({required String householdId, required String userId, required MemberRole role, }) {
    return AddHouseholdMemberVariablesBuilder(dataConnect, householdId: householdId,userId: userId,role: role,);
  }
  
  
  InviteHouseholdMemberVariablesBuilder inviteHouseholdMember ({required String householdId, required String email, required MemberRole role, }) {
    return InviteHouseholdMemberVariablesBuilder(dataConnect, householdId: householdId,email: email,role: role,);
  }
  
  
  SaveContractVariablesBuilder saveContract ({required String memberId, required PayType payType, required double rate, }) {
    return SaveContractVariablesBuilder(dataConnect, memberId: memberId,payType: payType,rate: rate,);
  }
  
  
  AddLibraryTaskVariablesBuilder addLibraryTask ({required TaskCategory category, required String nameEn, }) {
    return AddLibraryTaskVariablesBuilder(dataConnect, category: category,nameEn: nameEn,);
  }
  
  
  DeleteLibraryTaskVariablesBuilder deleteLibraryTask ({required String id, }) {
    return DeleteLibraryTaskVariablesBuilder(dataConnect, id: id,);
  }
  
  
  AddHolidayVariablesBuilder addHoliday ({required DateTime date, required HolidayType type, required String nameEn, }) {
    return AddHolidayVariablesBuilder(dataConnect, date: date,type: type,nameEn: nameEn,);
  }
  
  
  DeleteHolidayVariablesBuilder deleteHoliday ({required String id, }) {
    return DeleteHolidayVariablesBuilder(dataConnect, id: id,);
  }
  
  
  MyProfileVariablesBuilder myProfile () {
    return MyProfileVariablesBuilder(dataConnect, );
  }
  
  
  MyMembershipVariablesBuilder myMembership () {
    return MyMembershipVariablesBuilder(dataConnect, );
  }
  
  
  HouseholdMembersVariablesBuilder householdMembers ({required String householdId, }) {
    return HouseholdMembersVariablesBuilder(dataConnect, householdId: householdId,);
  }
  
  
  UserIdByEmailVariablesBuilder userIdByEmail ({required String email, }) {
    return UserIdByEmailVariablesBuilder(dataConnect, email: email,);
  }
  
  
  CurrentContractVariablesBuilder currentContract ({required String memberId, }) {
    return CurrentContractVariablesBuilder(dataConnect, memberId: memberId,);
  }
  
  
  LibraryTasksVariablesBuilder libraryTasks () {
    return LibraryTasksVariablesBuilder(dataConnect, );
  }
  
  
  HolidaysVariablesBuilder holidays () {
    return HolidaysVariablesBuilder(dataConnect, );
  }
  
  
  AdminHouseholdsVariablesBuilder adminHouseholds () {
    return AdminHouseholdsVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-southeast1',
    'sahakara',
    'sahakara-f78dd-service',
  );

  SahakaraConnector({required this.dataConnect});
  static SahakaraConnector get instance {
    
    return SahakaraConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
