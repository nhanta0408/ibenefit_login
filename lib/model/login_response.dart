class LoginResponse {
  bool? success;
  DataLoginResponse? data;
  String? msg;
  dynamic errors;
  int? code;

  LoginResponse({this.success, this.data, this.msg, this.errors, this.code});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? DataLoginResponse.fromJson(json['data']) : null;
    msg = json['msg'];
    errors = json['errors'];
    code = json['code'];
  }
}

class DataLoginResponse {
  User? user;
  List<String>? permissions;
  String? token;

  DataLoginResponse({this.user, this.permissions, this.token});

  DataLoginResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    permissions = json['permissions'].cast<String>();
    token = json['token'];
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  LastLogin? lastLogin;
  int? accountType;
  int? memberLevelId;
  dynamic lastUpgradeLevel;
  dynamic vendorId;
  dynamic taxCodeId;
  dynamic areaId;
  String? avatar;
  int? gender;
  String? address;
  String? idNumber;
  int? status;
  dynamic referralCode;
  String? wallet;
  int? coinWallet;
  String? createdAt;
  String? updatedAt;
  dynamic socialId;
  dynamic age;
  dynamic birthOfDate;
  dynamic agencyId;
  dynamic pinCodeExpire;
  int? availableLoanProductDiscounts;
  int? isWorking;
  int? financeLocked;
  dynamic firstSpend;
  dynamic activatedReferralCode;
  int? dailyCallMaxTime;
  dynamic dailyCallMaxAmount;
  int? isAutoCall;
  int? simType;
  String? uncenPhoneNumber;
  AccountTypes? accountTypes;
  MemberLevel? memberLevel;
  String? genderText;
  String? statusText;

  User(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.lastLogin,
      this.accountType,
      this.memberLevelId,
      this.lastUpgradeLevel,
      this.vendorId,
      this.taxCodeId,
      this.areaId,
      this.avatar,
      this.gender,
      this.address,
      this.idNumber,
      this.status,
      this.referralCode,
      this.wallet,
      this.coinWallet,
      this.createdAt,
      this.updatedAt,
      this.socialId,
      this.age,
      this.birthOfDate,
      this.agencyId,
      this.pinCodeExpire,
      this.availableLoanProductDiscounts,
      this.isWorking,
      this.financeLocked,
      this.firstSpend,
      this.activatedReferralCode,
      this.dailyCallMaxTime,
      this.dailyCallMaxAmount,
      this.isAutoCall,
      this.simType,
      this.uncenPhoneNumber,
      this.accountTypes,
      this.memberLevel,
      this.genderText,
      this.statusText});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    lastLogin = json['last_login'] != null
        ? LastLogin.fromJson(json['last_login'])
        : null;
    accountType = json['account_type'];
    memberLevelId = json['member_level_id'];
    lastUpgradeLevel = json['last_upgrade_level'];
    vendorId = json['vendor_id'];
    taxCodeId = json['tax_code_id'];
    areaId = json['area_id'];
    avatar = json['avatar'];
    gender = json['gender'];
    address = json['address'];
    idNumber = json['id_number'];
    status = json['status'];
    referralCode = json['referral_code'];
    wallet = json['wallet'];
    coinWallet = json['coin_wallet'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    socialId = json['social_id'];
    age = json['age'];
    birthOfDate = json['birth_of_date'];
    agencyId = json['agency_id'];
    pinCodeExpire = json['pin_code_expire'];
    availableLoanProductDiscounts = json['available_loan_product_discounts'];
    isWorking = json['is_working'];
    financeLocked = json['finance_locked'];
    firstSpend = json['first_spend'];
    activatedReferralCode = json['activated_referral_code'];
    dailyCallMaxTime = json['daily_call_max_time'];
    dailyCallMaxAmount = json['daily_call_max_amount'];
    isAutoCall = json['is_auto_call'];
    simType = json['sim_type'];
    uncenPhoneNumber = json['uncen_phone_number'];
    accountTypes = json['account_types'] != null
        ? AccountTypes.fromJson(json['account_types'])
        : null;
    memberLevel = json['member_level'] != null
        ? MemberLevel.fromJson(json['member_level'])
        : null;
    genderText = json['gender_text'];
    statusText = json['status_text'];
  }
}

class LastLogin {
  String? date;
  int? timezoneType;
  String? timezone;

  LastLogin({this.date, this.timezoneType, this.timezone});

  LastLogin.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }
}

class AccountTypes {
  String? s1;

  AccountTypes({this.s1});

  AccountTypes.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
  }
}

class MemberLevel {
  int? id;
  String? name;
  String? code;
  int? level;
  int? minCourses;
  int? minReferrals;
  int? minProducts;
  String? minRevenue;
  String? minProfit;
  int? profitRatio1;
  int? profitRatio2;
  int? profitRatio3;
  int? profitRatio4;
  String? createdAt;
  String? updatedAt;
  int? minAmountSpent;

  MemberLevel(
      {this.id,
      this.name,
      this.code,
      this.level,
      this.minCourses,
      this.minReferrals,
      this.minProducts,
      this.minRevenue,
      this.minProfit,
      this.profitRatio1,
      this.profitRatio2,
      this.profitRatio3,
      this.profitRatio4,
      this.createdAt,
      this.updatedAt,
      this.minAmountSpent});

  MemberLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    level = json['level'];
    minCourses = json['min_courses'];
    minReferrals = json['min_referrals'];
    minProducts = json['min_products'];
    minRevenue = json['min_revenue'];
    minProfit = json['min_profit'];
    profitRatio1 = json['profit_ratio_1'];
    profitRatio2 = json['profit_ratio_2'];
    profitRatio3 = json['profit_ratio_3'];
    profitRatio4 = json['profit_ratio_4'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    minAmountSpent = json['min_amount_spent'];
  }
}
