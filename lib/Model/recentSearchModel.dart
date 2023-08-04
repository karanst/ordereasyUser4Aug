/// error : false
/// message : "Get Data successfully!"
/// date : [{"id":"67","user_id":"1281","qr_number":"551454","date_added":"2023-04-13 16:42:19","ip_address":"182.69.6.75","username":"Rohit","password":"$2y$10$yPA4sh1o6QMNx1BtvSPRJOpo2YevuJbLV5yqy8o5urioXdC4fycpe","email":"rohit@gmail.com","mobile":"8770669965","image":null,"balance":"0","activation_selector":"68fe4880c31d719ae31d","activation_code":"$2y$10$yhe49MCGSteqv5cQy4AHkeHC1TlZY953MHaBZP26oMqTXcpeg3mYG","forgotten_password_selector":null,"forgotten_password_code":null,"forgotten_password_time":null,"remember_selector":null,"remember_code":null,"created_on":"1681384339","last_login":"1681452441","active":"1","company":null,"address":"Indore, Madhya Pradesh, India","bonus":null,"cash_received":"0.00","dob":null,"country_code":null,"city":null,"area":null,"street":null,"qrcode":"uploads/qrcode/2036573332.png","pincode":null,"serviceable_zipcodes":null,"apikey":null,"referral_code":null,"friends_code":null,"fcm_id":"fSdIAAYDSkCRxliq9owJDY:APA91bFxdQGIxUjm67Q2l8dBm3xfmvxja8Kxc2oBZHUFfbJbt77ALhbLGmtT1ITdYqhjNkm2s2u4WwgpwB9okPhhcfdtiYh-wf2xDts4AYvImqiDZAwUf5dOmF1uX0_4JG-d78n89ikX","otp":"0","verify_otp":"0","latitude":"22.7195687","longitude":"75.8577258","created_at":"2023-04-13 16:42:19","online":"1","slug":"-2","category_ids":"206,208,209,210,211,207","store_name":"","store_description":"","logo":"uploads/seller/processed-8c1ab5ff-1f44-47f4-96f2-777a1d27360d_Ztmfdjvo.jpeg","store_url":"","no_of_ratings":"0","rating":"0.00","bank_name":"","bank_code":"","account_name":"","account_number":"","national_identity_card":"","address_proof":"uploads/seller/processed-8c1ab5ff-1f44-47f4-96f2-777a1d27360d_Ztmfdjvo1.jpeg","pan_number":"","tax_name":"","tax_number":"","permissions":"{\"require_products_approval\":\"0\",\"customer_privacy\":\"0\",\"view_order_otp\":\"0\",\"assign_delivery_boy\":\"0\",\"online\":\"0\"}","commission":"0.00","estimated_time":"","food_person":"","open_close_status":"1","status":"1"}]

class RecentSearchModel {
  RecentSearchModel({
      bool? error, 
      String? message, 
      List<Date>? date,}){
    _error = error;
    _message = message;
    _date = date;
}

  RecentSearchModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['date'] != null) {
      _date = [];
      json['date'].forEach((v) {
        _date?.add(Date.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Date>? _date;
RecentSearchModel copyWith({  bool? error,
  String? message,
  List<Date>? date,
}) => RecentSearchModel(  error: error ?? _error,
  message: message ?? _message,
  date: date ?? _date,
);
  bool? get error => _error;
  String? get message => _message;
  List<Date>? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_date != null) {
      map['date'] = _date?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "67"
/// user_id : "1281"
/// qr_number : "551454"
/// date_added : "2023-04-13 16:42:19"
/// ip_address : "182.69.6.75"
/// username : "Rohit"
/// password : "$2y$10$yPA4sh1o6QMNx1BtvSPRJOpo2YevuJbLV5yqy8o5urioXdC4fycpe"
/// email : "rohit@gmail.com"
/// mobile : "8770669965"
/// image : null
/// balance : "0"
/// activation_selector : "68fe4880c31d719ae31d"
/// activation_code : "$2y$10$yhe49MCGSteqv5cQy4AHkeHC1TlZY953MHaBZP26oMqTXcpeg3mYG"
/// forgotten_password_selector : null
/// forgotten_password_code : null
/// forgotten_password_time : null
/// remember_selector : null
/// remember_code : null
/// created_on : "1681384339"
/// last_login : "1681452441"
/// active : "1"
/// company : null
/// address : "Indore, Madhya Pradesh, India"
/// bonus : null
/// cash_received : "0.00"
/// dob : null
/// country_code : null
/// city : null
/// area : null
/// street : null
/// qrcode : "uploads/qrcode/2036573332.png"
/// pincode : null
/// serviceable_zipcodes : null
/// apikey : null
/// referral_code : null
/// friends_code : null
/// fcm_id : "fSdIAAYDSkCRxliq9owJDY:APA91bFxdQGIxUjm67Q2l8dBm3xfmvxja8Kxc2oBZHUFfbJbt77ALhbLGmtT1ITdYqhjNkm2s2u4WwgpwB9okPhhcfdtiYh-wf2xDts4AYvImqiDZAwUf5dOmF1uX0_4JG-d78n89ikX"
/// otp : "0"
/// verify_otp : "0"
/// latitude : "22.7195687"
/// longitude : "75.8577258"
/// created_at : "2023-04-13 16:42:19"
/// online : "1"
/// slug : "-2"
/// category_ids : "206,208,209,210,211,207"
/// store_name : ""
/// store_description : ""
/// logo : "uploads/seller/processed-8c1ab5ff-1f44-47f4-96f2-777a1d27360d_Ztmfdjvo.jpeg"
/// store_url : ""
/// no_of_ratings : "0"
/// rating : "0.00"
/// bank_name : ""
/// bank_code : ""
/// account_name : ""
/// account_number : ""
/// national_identity_card : ""
/// address_proof : "uploads/seller/processed-8c1ab5ff-1f44-47f4-96f2-777a1d27360d_Ztmfdjvo1.jpeg"
/// pan_number : ""
/// tax_name : ""
/// tax_number : ""
/// permissions : "{\"require_products_approval\":\"0\",\"customer_privacy\":\"0\",\"view_order_otp\":\"0\",\"assign_delivery_boy\":\"0\",\"online\":\"0\"}"
/// commission : "0.00"
/// estimated_time : ""
/// food_person : ""
/// open_close_status : "1"
/// status : "1"

class Date {
  Date({
      String? id, 
      String? userId, 
      String? qrNumber, 
      String? dateAdded, 
      String? ipAddress, 
      String? username, 
      String? fuid,
      String? password,
      String? email, 
      String? mobile, 
      dynamic image, 
      String? balance, 
      String? activationSelector, 
      String? activationCode, 
      dynamic forgottenPasswordSelector, 
      dynamic forgottenPasswordCode, 
      dynamic forgottenPasswordTime, 
      dynamic rememberSelector, 
      dynamic rememberCode, 
      String? createdOn, 
      String? lastLogin, 
      String? active, 
      String? active_status,
      dynamic company,
      String? address, 
      dynamic bonus, 
      String? cashReceived, 
      dynamic dob, 
      dynamic countryCode, 
      dynamic city, 
      dynamic area, 
      dynamic street, 
      String? qrcode, 
      dynamic pincode, 
      dynamic serviceableZipcodes, 
      dynamic apikey, 
      dynamic referralCode, 
      dynamic friendsCode, 
      String? fcmId, 
      String? otp, 
      String? verifyOtp, 
      String? latitude, 
      String? longitude, 
      String? createdAt, 
      String? online, 
      String? slug, 
      String? categoryIds, 
      String? storeName, 
      String? storeDescription, 
      String? logo, 
      String? storeUrl, 
      String? noOfRatings, 
      String? rating, 
      String? bankName, 
      String? bankCode, 
      String? accountName, 
      String? accountNumber, 
      String? nationalIdentityCard, 
      String? addressProof, 
      String? panNumber, 
      String? taxName, 
      String? taxNumber, 
      String? permissions, 
      String? commission, 
      String? estimatedTime, 
      String? foodPerson, 
      String? openCloseStatus, 
      String? status,}){
    _id = id;
    _userId = userId;
    _qrNumber = qrNumber;
    _dateAdded = dateAdded;
    _ipAddress = ipAddress;
    _username = username;
    _fuid = fuid;
    _password = password;
    _email = email;
    _mobile = mobile;
    _image = image;
    _balance = balance;
    _activationSelector = activationSelector;
    _activationCode = activationCode;
    _forgottenPasswordSelector = forgottenPasswordSelector;
    _forgottenPasswordCode = forgottenPasswordCode;
    _forgottenPasswordTime = forgottenPasswordTime;
    _rememberSelector = rememberSelector;
    _rememberCode = rememberCode;
    _createdOn = createdOn;
    _lastLogin = lastLogin;
    _active = active;
    _activeStatus = active_status;
    _company = company;
    _address = address;
    _bonus = bonus;
    _cashReceived = cashReceived;
    _dob = dob;
    _countryCode = countryCode;
    _city = city;
    _area = area;
    _street = street;
    _qrcode = qrcode;
    _pincode = pincode;
    _serviceableZipcodes = serviceableZipcodes;
    _apikey = apikey;
    _referralCode = referralCode;
    _friendsCode = friendsCode;
    _fcmId = fcmId;
    _otp = otp;
    _verifyOtp = verifyOtp;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
    _online = online;
    _slug = slug;
    _categoryIds = categoryIds;
    _storeName = storeName;
    _storeDescription = storeDescription;
    _logo = logo;
    _storeUrl = storeUrl;
    _noOfRatings = noOfRatings;
    _rating = rating;
    _bankName = bankName;
    _bankCode = bankCode;
    _accountName = accountName;
    _accountNumber = accountNumber;
    _nationalIdentityCard = nationalIdentityCard;
    _addressProof = addressProof;
    _panNumber = panNumber;
    _taxName = taxName;
    _taxNumber = taxNumber;
    _permissions = permissions;
    _commission = commission;
    _estimatedTime = estimatedTime;
    _foodPerson = foodPerson;
    _openCloseStatus = openCloseStatus;
    _status = status;
}

  Date.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _qrNumber = json['qr_number'];
    _dateAdded = json['date_added'];
    _ipAddress = json['ip_address'];
    _username = json['username'];
    _fuid = json['fuid'];
    _password = json['password'];
    _email = json['email'];
    _mobile = json['mobile'];
    _image = json['image'];
    _balance = json['balance'];
    _activationSelector = json['activation_selector'];
    _activationCode = json['activation_code'];
    _forgottenPasswordSelector = json['forgotten_password_selector'];
    _forgottenPasswordCode = json['forgotten_password_code'];
    _forgottenPasswordTime = json['forgotten_password_time'];
    _rememberSelector = json['remember_selector'];
    _rememberCode = json['remember_code'];
    _createdOn = json['created_on'];
    _lastLogin = json['last_login'];
    _active = json['active'];
    _activeStatus = json['active_status'];
    _company = json['company'];
    _address = json['address'];
    _bonus = json['bonus'];
    _cashReceived = json['cash_received'];
    _dob = json['dob'];
    _countryCode = json['country_code'];
    _city = json['city'];
    _area = json['area'];
    _street = json['street'];
    _qrcode = json['qrcode'];
    _pincode = json['pincode'];
    _serviceableZipcodes = json['serviceable_zipcodes'];
    _apikey = json['apikey'];
    _referralCode = json['referral_code'];
    _friendsCode = json['friends_code'];
    _fcmId = json['fcm_id'];
    _otp = json['otp'];
    _verifyOtp = json['verify_otp'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _online = json['online'];
    _slug = json['slug'];
    _categoryIds = json['category_ids'];
    _storeName = json['store_name'];
    _storeDescription = json['store_description'];
    _logo = json['logo'];
    _storeUrl = json['store_url'];
    _noOfRatings = json['no_of_ratings'];
    _rating = json['rating'];
    _bankName = json['bank_name'];
    _bankCode = json['bank_code'];
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _nationalIdentityCard = json['national_identity_card'];
    _addressProof = json['address_proof'];
    _panNumber = json['pan_number'];
    _taxName = json['tax_name'];
    _taxNumber = json['tax_number'];
    _permissions = json['permissions'];
    _commission = json['commission'];
    _estimatedTime = json['estimated_time'];
    _foodPerson = json['food_person'];
    _openCloseStatus = json['open_close_status'];
    _status = json['status'];
  }
  String? _id;
  String? _userId;
  String? _qrNumber;
  String? _dateAdded;
  String? _ipAddress;
  String? _username;
  String? _fuid;
  String? _password;
  String? _email;
  String? _mobile;
  dynamic _image;
  String? _balance;
  String? _activationSelector;
  String? _activationCode;
  dynamic _forgottenPasswordSelector;
  dynamic _forgottenPasswordCode;
  dynamic _forgottenPasswordTime;
  dynamic _rememberSelector;
  dynamic _rememberCode;
  String? _createdOn;
  String? _lastLogin;
  String? _active;
  String? _activeStatus;
  dynamic _company;
  String? _address;
  dynamic _bonus;
  String? _cashReceived;
  dynamic _dob;
  dynamic _countryCode;
  dynamic _city;
  dynamic _area;
  dynamic _street;
  String? _qrcode;
  dynamic _pincode;
  dynamic _serviceableZipcodes;
  dynamic _apikey;
  dynamic _referralCode;
  dynamic _friendsCode;
  String? _fcmId;
  String? _otp;
  String? _verifyOtp;
  String? _latitude;
  String? _longitude;
  String? _createdAt;
  String? _online;
  String? _slug;
  String? _categoryIds;
  String? _storeName;
  String? _storeDescription;
  String? _logo;
  String? _storeUrl;
  String? _noOfRatings;
  String? _rating;
  String? _bankName;
  String? _bankCode;
  String? _accountName;
  String? _accountNumber;
  String? _nationalIdentityCard;
  String? _addressProof;
  String? _panNumber;
  String? _taxName;
  String? _taxNumber;
  String? _permissions;
  String? _commission;
  String? _estimatedTime;
  String? _foodPerson;
  String? _openCloseStatus;
  String? _status;
Date copyWith({  String? id,
  String? userId,
  String? qrNumber,
  String? dateAdded,
  String? ipAddress,
  String? username,
  String? fuid,
  String? password,
  String? email,
  String? mobile,
  dynamic image,
  String? balance,
  String? activationSelector,
  String? activationCode,
  dynamic forgottenPasswordSelector,
  dynamic forgottenPasswordCode,
  dynamic forgottenPasswordTime,
  dynamic rememberSelector,
  dynamic rememberCode,
  String? createdOn,
  String? lastLogin,
  String? active,
  String? active_status,
  dynamic company,
  String? address,
  dynamic bonus,
  String? cashReceived,
  dynamic dob,
  dynamic countryCode,
  dynamic city,
  dynamic area,
  dynamic street,
  String? qrcode,
  dynamic pincode,
  dynamic serviceableZipcodes,
  dynamic apikey,
  dynamic referralCode,
  dynamic friendsCode,
  String? fcmId,
  String? otp,
  String? verifyOtp,
  String? latitude,
  String? longitude,
  String? createdAt,
  String? online,
  String? slug,
  String? categoryIds,
  String? storeName,
  String? storeDescription,
  String? logo,
  String? storeUrl,
  String? noOfRatings,
  String? rating,
  String? bankName,
  String? bankCode,
  String? accountName,
  String? accountNumber,
  String? nationalIdentityCard,
  String? addressProof,
  String? panNumber,
  String? taxName,
  String? taxNumber,
  String? permissions,
  String? commission,
  String? estimatedTime,
  String? foodPerson,
  String? openCloseStatus,
  String? status,
}) => Date(  id: id ?? _id,
  userId: userId ?? _userId,
  qrNumber: qrNumber ?? _qrNumber,
  dateAdded: dateAdded ?? _dateAdded,
  ipAddress: ipAddress ?? _ipAddress,
  username: username ?? _username,
  fuid: fuid ?? _fuid,
  password: password ?? _password,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  image: image ?? _image,
  balance: balance ?? _balance,
  activationSelector: activationSelector ?? _activationSelector,
  activationCode: activationCode ?? _activationCode,
  forgottenPasswordSelector: forgottenPasswordSelector ?? _forgottenPasswordSelector,
  forgottenPasswordCode: forgottenPasswordCode ?? _forgottenPasswordCode,
  forgottenPasswordTime: forgottenPasswordTime ?? _forgottenPasswordTime,
  rememberSelector: rememberSelector ?? _rememberSelector,
  rememberCode: rememberCode ?? _rememberCode,
  createdOn: createdOn ?? _createdOn,
  lastLogin: lastLogin ?? _lastLogin,
  active: active ?? _active,
  active_status: active_status ?? _activeStatus,
  company: company ?? _company,
  address: address ?? _address,
  bonus: bonus ?? _bonus,
  cashReceived: cashReceived ?? _cashReceived,
  dob: dob ?? _dob,
  countryCode: countryCode ?? _countryCode,
  city: city ?? _city,
  area: area ?? _area,
  street: street ?? _street,
  qrcode: qrcode ?? _qrcode,
  pincode: pincode ?? _pincode,
  serviceableZipcodes: serviceableZipcodes ?? _serviceableZipcodes,
  apikey: apikey ?? _apikey,
  referralCode: referralCode ?? _referralCode,
  friendsCode: friendsCode ?? _friendsCode,
  fcmId: fcmId ?? _fcmId,
  otp: otp ?? _otp,
  verifyOtp: verifyOtp ?? _verifyOtp,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  createdAt: createdAt ?? _createdAt,
  online: online ?? _online,
  slug: slug ?? _slug,
  categoryIds: categoryIds ?? _categoryIds,
  storeName: storeName ?? _storeName,
  storeDescription: storeDescription ?? _storeDescription,
  logo: logo ?? _logo,
  storeUrl: storeUrl ?? _storeUrl,
  noOfRatings: noOfRatings ?? _noOfRatings,
  rating: rating ?? _rating,
  bankName: bankName ?? _bankName,
  bankCode: bankCode ?? _bankCode,
  accountName: accountName ?? _accountName,
  accountNumber: accountNumber ?? _accountNumber,
  nationalIdentityCard: nationalIdentityCard ?? _nationalIdentityCard,
  addressProof: addressProof ?? _addressProof,
  panNumber: panNumber ?? _panNumber,
  taxName: taxName ?? _taxName,
  taxNumber: taxNumber ?? _taxNumber,
  permissions: permissions ?? _permissions,
  commission: commission ?? _commission,
  estimatedTime: estimatedTime ?? _estimatedTime,
  foodPerson: foodPerson ?? _foodPerson,
  openCloseStatus: openCloseStatus ?? _openCloseStatus,
  status: status ?? _status,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get qrNumber => _qrNumber;
  String? get dateAdded => _dateAdded;
  String? get ipAddress => _ipAddress;
  String? get username => _username;
  String? get fuid => _fuid;
  String? get password => _password;
  String? get email => _email;
  String? get mobile => _mobile;
  dynamic get image => _image;
  String? get balance => _balance;
  String? get activationSelector => _activationSelector;
  String? get activationCode => _activationCode;
  dynamic get forgottenPasswordSelector => _forgottenPasswordSelector;
  dynamic get forgottenPasswordCode => _forgottenPasswordCode;
  dynamic get forgottenPasswordTime => _forgottenPasswordTime;
  dynamic get rememberSelector => _rememberSelector;
  dynamic get rememberCode => _rememberCode;
  String? get createdOn => _createdOn;
  String? get lastLogin => _lastLogin;
  String? get active => _active;
  String? get active_status => _activeStatus;
  dynamic get company => _company;
  String? get address => _address;
  dynamic get bonus => _bonus;
  String? get cashReceived => _cashReceived;
  dynamic get dob => _dob;
  dynamic get countryCode => _countryCode;
  dynamic get city => _city;
  dynamic get area => _area;
  dynamic get street => _street;
  String? get qrcode => _qrcode;
  dynamic get pincode => _pincode;
  dynamic get serviceableZipcodes => _serviceableZipcodes;
  dynamic get apikey => _apikey;
  dynamic get referralCode => _referralCode;
  dynamic get friendsCode => _friendsCode;
  String? get fcmId => _fcmId;
  String? get otp => _otp;
  String? get verifyOtp => _verifyOtp;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get createdAt => _createdAt;
  String? get online => _online;
  String? get slug => _slug;
  String? get categoryIds => _categoryIds;
  String? get storeName => _storeName;
  String? get storeDescription => _storeDescription;
  String? get logo => _logo;
  String? get storeUrl => _storeUrl;
  String? get noOfRatings => _noOfRatings;
  String? get rating => _rating;
  String? get bankName => _bankName;
  String? get bankCode => _bankCode;
  String? get accountName => _accountName;
  String? get accountNumber => _accountNumber;
  String? get nationalIdentityCard => _nationalIdentityCard;
  String? get addressProof => _addressProof;
  String? get panNumber => _panNumber;
  String? get taxName => _taxName;
  String? get taxNumber => _taxNumber;
  String? get permissions => _permissions;
  String? get commission => _commission;
  String? get estimatedTime => _estimatedTime;
  String? get foodPerson => _foodPerson;
  String? get openCloseStatus => _openCloseStatus;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['qr_number'] = _qrNumber;
    map['date_added'] = _dateAdded;
    map['ip_address'] = _ipAddress;
    map['username'] = _username;
    map['fuid'] = _fuid;
    map['password'] = _password;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['image'] = _image;
    map['balance'] = _balance;
    map['activation_selector'] = _activationSelector;
    map['activation_code'] = _activationCode;
    map['forgotten_password_selector'] = _forgottenPasswordSelector;
    map['forgotten_password_code'] = _forgottenPasswordCode;
    map['forgotten_password_time'] = _forgottenPasswordTime;
    map['remember_selector'] = _rememberSelector;
    map['remember_code'] = _rememberCode;
    map['created_on'] = _createdOn;
    map['last_login'] = _lastLogin;
    map['active'] = _active;
    map['active_status'] = _activeStatus;
    map['company'] = _company;
    map['address'] = _address;
    map['bonus'] = _bonus;
    map['cash_received'] = _cashReceived;
    map['dob'] = _dob;
    map['country_code'] = _countryCode;
    map['city'] = _city;
    map['area'] = _area;
    map['street'] = _street;
    map['qrcode'] = _qrcode;
    map['pincode'] = _pincode;
    map['serviceable_zipcodes'] = _serviceableZipcodes;
    map['apikey'] = _apikey;
    map['referral_code'] = _referralCode;
    map['friends_code'] = _friendsCode;
    map['fcm_id'] = _fcmId;
    map['otp'] = _otp;
    map['verify_otp'] = _verifyOtp;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    map['online'] = _online;
    map['slug'] = _slug;
    map['category_ids'] = _categoryIds;
    map['store_name'] = _storeName;
    map['store_description'] = _storeDescription;
    map['logo'] = _logo;
    map['store_url'] = _storeUrl;
    map['no_of_ratings'] = _noOfRatings;
    map['rating'] = _rating;
    map['bank_name'] = _bankName;
    map['bank_code'] = _bankCode;
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['national_identity_card'] = _nationalIdentityCard;
    map['address_proof'] = _addressProof;
    map['pan_number'] = _panNumber;
    map['tax_name'] = _taxName;
    map['tax_number'] = _taxNumber;
    map['permissions'] = _permissions;
    map['commission'] = _commission;
    map['estimated_time'] = _estimatedTime;
    map['food_person'] = _foodPerson;
    map['open_close_status'] = _openCloseStatus;
    map['status'] = _status;
    return map;
  }

}