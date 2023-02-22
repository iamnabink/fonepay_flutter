part of fonepay_flutter;

//TODO: Add configuration validation
class FonePayConfig {
  FonePayConfig.live({
    required this.pid,
    required this.ru,
    required this.prn,
    required this.amt,
    this.crn = 'NPR',
    this.dt,
    this.serverUrl = kFonePayLiveUrl,
    required this.sk,
    required this.r1,
    required this.r2,
    this.md = "P",
  }) {
    // assert(pid != "", "pid cannot be empty");
    // assert(ru != "", "ru cannot be empty");
    // assert(prn != "", "prn cannot be empty");
    // assert(amt != 0, "amt cannot be 0");
    // assert(sk != "", "sk cannot be empty");
    dt = dt ?? FonePayUtils.formatDate(DateTime.now());
    var secretKey = utf8.encode(sk);
    var data = utf8.encode('$pid,$md,$prn,$amt,$crn,$dt,$r1,$r2,$ru');
    var hmacSha512 = Hmac(sha512, secretKey); // HMAC-sha512
    var digest = hmacSha512.convert(data).toString();
    _dv = digest;
  }

  dynamic get dv => _dv;

  FonePayConfig.dev({
    this.pid = kFonePayDevMerchantCode,
    required this.ru,
    required this.prn,
    required this.amt,
    this.crn = 'NPR',
    this.dt,
    this.serverUrl = kFonePayDevUrl,
    this.sk = kFonePayDevSecretKey,
    required this.r1,
    required this.r2,
    this.md = "P",
  }) {
    // assert(pid != "", "pid cannot be empty");
    // assert(ru != "", "ru cannot be empty");
    // assert(prn != "", "prn cannot be empty");
    // assert(amt != 0, "amt cannot be 0");
    // assert(sk != "", "sk cannot be empty");
    dt = dt ?? FonePayUtils.formatDate(DateTime.now());
    var secretKey = utf8.encode(sk); // fonepay
    var data = utf8.encode('$pid,$md,$prn,$amt,$crn,$dt,$r1,$r2,$ru');
    var hmacSha512 = Hmac(sha512, secretKey); // HMAC-sha512
    var digest = hmacSha512.convert(data).toString();
    _dv = digest;
  }

  /// Live - Return Url where Fonepay system notifies payment information to merchant site
  /// for e.g https://fonepay.com/for-business/web-integration
  String ru;

  /// Fonepay prod server
  /// URL: https://clientapi.fonepay.com/api/merchantRequest?
  String? serverUrl;

  /// secret key
  /// for dev default it : fonepay
  String sk;

  /// Live Merchant Code,Defined by fonepay system
  /// for test pid use 'fonepay123' [default]
  String pid;

  /// Product Reference Number,need to send by merchant
  /// Min 3
  /// Max 25
  String prn;

  /// Payable Amount like 10.0
  /// Double
  /// Max 18 digit
  double amt;

  /// Default Value ,NPR need to send for local merchants
  String? crn;

  ///  Format :MM/dd/yyyy
  /// eg:06/27/2018
  /// Fixed 10
  String? dt;

  /// Need to provide payment details that identifies what was payment for (Eg Receipt id or payment description)
  String r1;

  /// Additional Info,provide N/A if does not exists
  /// Max 50
  String r2;

  /// P –payment
  /// Min 1 Max 3
  String? md;

  /// SHA512  hashed value.
  /// Read Secure Hash Calculation (DV) below to generate this value
  String? _dv;
}
