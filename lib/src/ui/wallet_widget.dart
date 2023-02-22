part of fonepay_flutter;

class FonePayPage extends StatefulWidget {
  final FonePayConfig fonePayConfig;

  const FonePayPage(this.fonePayConfig);

  @override
  State<FonePayPage> createState() => _FonePayPageState();
}

class _FonePayPageState extends State<FonePayPage> {
  late FonePayConfig fonePayConfig;
  late URLRequest paymentRequest;

  @override
  void initState() {
    fonePayConfig = widget.fonePayConfig;
    paymentRequest = getURLRequest();
    super.initState();
  }

  bool _isLoading = true;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  URLRequest getURLRequest() {
    var url =
        "${fonePayConfig.serverUrl}PID=${fonePayConfig.pid}&MD=${fonePayConfig.md}&AMT=${fonePayConfig.amt}&CRN=${fonePayConfig.crn}&DT=${fonePayConfig.dt}&R1=${fonePayConfig.r1}&R2=${fonePayConfig.r2}&DV=${fonePayConfig.dv}&RU=${fonePayConfig.ru}&PRN=${fonePayConfig.prn}";
    var urlRequest = URLRequest(url: Uri.tryParse(url));
    return urlRequest;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Pay Via Fonepay"),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialOptions: options,
            initialUrlRequest: paymentRequest,
            onWebViewCreated: (webViewController) {
              setState(() {
                _isLoading = false;
              });
            },
            onLoadStart: (controller, url) {
              setState(() {
                _isLoading = true;
              });
            },
            onLoadStop: (controller, url) async {
              setState(() {
                _isLoading = false;
              });
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var url = navigationAction.request.url!;
              if (![
                "http",
                "https",
                "file",
                "chrome",
                "data",
                "javascript",
                "about"
              ].contains(url.scheme)) {
                return NavigationActionPolicy.CANCEL;
              }
              try {
                if ((url.toString()).contains(fonePayConfig.ru)) {
                  var result = Uri.parse(url.toString());
                  var body = result.queryParameters;
                  if (body['RC'] == 'successful') {
                    await createPaymentResponse(body).then((value) {
                      Navigator.pop(context, FonePayPaymentResult(data: value));
                    });
                  } else if (body['RC'] == 'failed') {
                    Navigator.pop(
                        context, FonePayPaymentResult(error: 'Payment Failed'));
                  }
                }
              } catch (e) {
                Navigator.pop(
                    context, FonePayPaymentResult(error: 'Payment Cancelled'));
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadError: (controller, url, code, message) {},
            onConsoleMessage: (controller, consoleMessage) {},
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Future<FonePayResponse> createPaymentResponse(
      Map<String, dynamic> body) async {
    final params = FonePayResponse(
        prn: body['PRN'],
        pid: body['PID'],
        ps: body['PS'],
        pAmt: body['P_AMT'],
        rAmt: body['R_AMT'],
        rc: body['RC'],
        bc: body['BC'],
        ini: body['INI'],
        uid: body['UID'],
        dv: body['DV']);
    return params;
  }
}
