# FonePay Flutter [![Share on Twitter](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=Flutter%20FonePayPayment%20plugin!&url=https://github.com/iamnabink/fonepay_flutter&hashtags=flutter,flutterio,dart,wallet,fonepay,paymentgateway) [![Share on Facebook](https://img.shields.io/badge/share-facebook-blue.svg?longCache=true&style=flat&colorB=%234267b2)](https://www.facebook.com/sharer/sharer.php?u=https%3A//github.com/iamnabink/fonepay_flutter)

[![Pub Version](https://img.shields.io/pub/v/fonepay_flutter.svg)](https://pub.dev/packages/fonepay_flutter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An un-official Flutter plugin for FonePay Payment Gateway. With this plugin, you can easily integrate
FonePay Payment Gateway into your Flutter app and start accepting payments from your customers.
Whether you're building an eCommerce app or any other type of app that requires payments, this
plugin makes the integration process simple and straightforward.

![Cover Image](https://github.com/iamnabink/fonepay_flutter/raw/master/screenshots/cover.png)

# Note

This package doesn't use any plugin or native APIs for payment initialization. Instead, it is based on the Flutter
InAppWebView package. A shoutout to the developer of [InAppWebView](https://pub.dev/packages/flutter_inappwebview)
package for providing such a useful package.

## Features

- Easy integration
- No complex setup
- Pure Dart code
- Simple to use


## Requirements

* Android: `minSdkVersion 17` and add support for `androidx` (see [AndroidX Migration](https://flutter.dev/docs/development/androidx-migration))
* iOS: `--ios-language swift`, Xcode version `>= 11`

## Setup

### iOS
No Configuration Needed

For more info, [see here](https://pub.dev/packages/flutter_inappwebview#important-note-for-ios)

### Android
Set `minSdkVersion` of your `android/app/build.gradle` file to at least 17.

For more info, [see here](https://pub.dev/packages/flutter_inappwebview#important-note-for-android)

# Usage

1. Add `fonepay_flutter` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  fonepay_flutter: ^1.0.0
```

2. Import the package in your Dart code:

```import 'package:fonepay_flutter/fonepay_flutter.dart';```

3. Create an instance of `FonePayConfig` with your payment information:

The `FonePayConfig` class holds the configuration details for the payment gateway. Pass an instance of
`FonePayConfig` to the init() method of the `FonePay` class to initiate the payment process.

```dart

final config = FonePayConfig.live(
  pid: 'liveMerchantCode',
  ru: 'https://example.com/fonepay/return',
  prn: '123456',
  amt: 100.0,
  sk: 'mySecretKey',
  r1: 'Payment for order #123',
  r2: 'Additional info',
);
```

4. Initialize the payment by calling `FonePay.init()` method:

```
final result = await FonePay.i.init(
  context: context,
  fonePayConfig: config,
);
```

5. Check the payment result:

After the payment is completed or cancelled by the user, the plugin returns an instance of
FonePayPaymentResult. If the payment was successful, hasData will be true and you can access the
FonePayResponse object using data. If the payment was unsuccessful, hasError will be true and
you can access the error message using error.

```
if (result.hasData) {
  // Payment successful
  final response = result.data!;
  print('Payment successful. Ref ID: ${response.uid}');
} else {
  // Payment failed or cancelled
  final error = result.error!;
  print('Payment failed or cancelled. Error: $error');
}
```

# Dev/Live Mode

`FonePayConfig` supports both dev and live mode. For live mode, use the `FonePayConfig.live()`
constructor, and for dev mode, use the `FonePayConfig.dev()` constructor. Here's an example of using
the dev mode:

```dart

final config = FonePayConfig.dev(
  ru: 'https://example.com/fonepay/return',
  prn: '123456',
  amt: 100.0,
  r1: 'Payment for order #123',
  r2: 'Additional info',
);
```

# APIs

## Class: FonePayConfig

The `FonePayConfig` class provides configuration options for FonePay payments.

### Properties

- `ru` (required): Live - Return Url where FonePay system notifies payment information to merchant site.
- `serverUrl`: FonePay prod server URL. Defaults to "https://clientapi.fonepay.com/api/merchantRequest?".
- `sk` (required): Secret key for the FonePay account.
- `pid`: Live Merchant Code, defined by FonePay system. Defaults to "fonepay123".
- `prn` (required): Product Reference Number, need to be sent by the merchant. Must be between 3 and 25 characters.
- `amt` (required): Payable amount, specified as a double with a maximum of 18 digits.
- `crn`: Currency code. Defaults to "NPR".
- `dt`: Payment date in MM/dd/yyyy format. Defaults to the current date.
- `r1` (required): Payment details that identify what the payment was for (e.g., receipt ID or payment description).
- `r2`: Additional information, defaults to "N/A".
- `md`: Payment mode, defaults to "P".
- `dv`: SHA512 hashed value, generated using the secure hash calculation method described below.

## Methods

### FonePayConfig.live

Initializes a configuration for FonePay live payments.

#### Parameters

- `pid` (required): Live Merchant Code, defined by FonePay system.
- `ru` (required): Live - Return Url where FonePay system notifies payment information to merchant site.
- `prn` (required): Product Reference Number, need to be sent by the merchant.
- `amt` (required): Payable amount.
- `crn`: Currency code. Defaults to "NPR".
- `dt`: Payment date in MM/dd/yyyy format. Defaults to the current date.
- `sk` (required): Secret key for the FonePay account.
- `r1` (required): Payment details that identify what the payment was for.
- `r2`: Additional information. Defaults to "N/A".
- `md`: Payment mode. Defaults to "P".

#### Example

```dart

final config = FonePayConfig.live(
  pid: 'liveMerchantCode',
  ru: 'https://example.com/fonepay/return',
  prn: '123456',
  amt: 100.0,
  sk: 'mySecretKey',
  r1: 'Payment for order #123',
  r2: 'Additional info',
);
```

### FonePayConfig.dev

Initializes a configuration for FonePay development stage.

#### Parameters

- `ru` (required): Live - Return Url where FonePay system notifies payment information to merchant site.
- `prn` (required): Product Reference Number, need to be sent by the merchant.
- `amt` (required): Payable amount.
- `crn`: Currency code. Defaults to "NPR".
- `dt`: Payment date in MM/dd/yyyy format. Defaults to the current date.
- `r1` (required): Payment details that identify what the payment was for.
- `r2`: Additional information. Defaults to "N/A".
- `md`: Payment mode. Defaults to "P".

#### Example

```dart

final config = FonePayConfig.dev(
  ru: 'https://example.com/fonepay/return',
  prn: '123456',
  amt: 100.0,
  r1: 'Payment for order #123',
  r2: 'Additional info',
);
```

## FonePayResponse

Represents a response from the FonePay API.

### Properties

| Name   | Type     | Description                                   |
|--------|----------|-----------------------------------------------|
| `prn`  | `String` | The payment reference number.                 |
| `pid`  | `String` | The merchant's payment identifier.            |
| `ps`   | `String` | The payment status.                           |
| `rc`   | `String` | The response code.                            |
| `uid`  | `String` | The unique transaction identifier.            |
| `bc`   | `String` | The bank code.                                |
| `ini`  | `String` | The transaction initialization date and time. |
| `pAmt` | `String` | The paid amount.                              |
| `rAmt` | `String` | The refund amount.                            |
| `dv`   | `String` | The device type.                              |

### Methods

#### `toJson()`

Converts the `FonePayResponse` instance to a JSON object.

**Returns**

A `Map` object representing the `FonePayResponse` instance.

## Class: FonePayPaymentResult

Class representing the result of a payment transaction.

### Properties

- `data`: The payment response data, if the payment was successful. Null otherwise.
- `error`: The error message, if the payment failed or was cancelled. Null otherwise.
- `hasData`: A boolean indicating whether the payment was successful and contains a non-null data
  property.
- `hasError`: A boolean indicating whether the payment failed or was cancelled and contains a
  non-null error property.

## Class: FonePay

Class providing the main interface for the FonePay payment integration.

### Methods

- `init(BuildContext context, FonePayConfig e)`: Initializes the FonePayConfig payment gateway with the given
  configuration.


## Class: FonePayUtils

The `FonePayUtils` class provides utility functions for FonePay integration.

### Static Method: formatDate

```dart
static String formatDate(DateTime date)
```

Returns the formatted date string in the format of MM/dd/yyyy.

`date` (required): The `DateTime` object to be formatted.
### Method: generateRandomString

```dart
String generateRandomString({int? len})

```
* Generates a random string of specified length or a default length of 6 if not specified.

`len` (optional): The length of the random string to be generated. If not specified, the default length of 6 will be used.
Note: To prevent payment request failure due to duplicate PRN number in `FonePayConfig`, it is recommended to generate a unique `PRN` number by utilizing this method.

## Dev Testing Information

To access the development environment, use the following credentials:

- Bank: Any bank available in dev mode [Currently  Global IME Bank]
- Username: [any 10 digit random Nepali number starting with 98]
- Password: [anything random, like 1212122]
- OTP: [anything random, like 1212122]

Please note that these credentials are for testing purposes only and should not be used in production.

## Screenshots

Here are some screenshots of the FonePay Payment Gateway integrated into a ecommerce Flutter app:

<table>
  <tr>
    <td><img src="https://github.com/iamnabink/fonepay_flutter/raw/master/screenshots/order_screen.png" alt="Example Order Screen" width="400"/></td>
    <td><img src="https://github.com/iamnabink/fonepay_flutter/raw/master/screenshots/payment_screen.png" alt="Payment Screen" width="400"/></td>
  </tr>
</table>

## Run the example app

- Navigate to the example folder `cd example`
- Install the dependencies
    - `flutter pub get`
- Set up configuration `FonePayConfig.live()` or directly run with just `FonePayConfig.dev()` in dev
  mode
- Start the example
    - Terminal : `flutter run`

# License

This plugin is released under the MIT License. See LICENSE for details.

## Contributions

Contributions are welcome! To make this project better, Feel free to open an issue or submit a pull
request on [Github](https://github.com/iamnabink/fonepay_flutter/issues)..

## Contact

If you have any questions or suggestions, feel free
to [contact me on LinkedIn](https://www.linkedin.com/in/iamnabink/).




