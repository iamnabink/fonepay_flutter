part of fonepay_flutter;

class _FonePayService {
  _FonePayService._(); // private constructor for singletons
  /// return the same instance of PaymentService
  static _FonePayService i = _FonePayService._();

  Future<FonePayPaymentResult> init(
      {required BuildContext context,
      required FonePayConfig fonePayConfig}) async {
    try {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FonePayPage(fonePayConfig)),
      );
      // Wait for the user to return from the fonePay payment screen before closing any dialogs
      // This delay should give enough time for the success/failure dialog (if any) to appear and prevent it from closing prematurely.
      return await Future.delayed(
          const Duration(milliseconds: 500), () => result);
    } catch (e) {
      return FonePayPaymentResult(error: 'Payment Failed or Cancelled!');
    }
  }
}

class FonePay {
  FonePay._(); // private constructor for singletons
  /// return the same instance of PaymentService
  static FonePay instance = FonePay._();

  /// you can use PaymentService.instance or PaymentService.i
  static FonePay get i => instance;

  final _FonePayService _payment = _FonePayService.i;

  /// return a new instance of PaymentService for testing
  @visibleForTesting
  static FonePay getInstance() => FonePay._();

  /// like webview, native app, or a dialog.
  Future<FonePayPaymentResult> init({
    required BuildContext context,
    required FonePayConfig fonePayConfig,
  }) =>
      _payment.init(
        context: context,
        fonePayConfig: fonePayConfig,
      );
}
