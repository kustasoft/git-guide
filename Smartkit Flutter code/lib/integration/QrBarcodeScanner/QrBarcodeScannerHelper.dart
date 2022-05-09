import 'dart:async';

import 'package:flutter/services.dart';

/// Scan mode which is either QR code or BARCODE
enum ScanMode { QR, BARCODE, DEFAULT }
class FlutterBarcodeScanner {
  static const MethodChannel _channel =
  MethodChannel('flutter_barcode_scanner');

  static const EventChannel _eventChannel =
  EventChannel('flutter_barcode_scanner_receiver');

  static Stream? _onBarcodeReceiver;
  static Future<String> scanBarcode(String lineColor, String cancelButtonText,
      bool isShowFlashIcon, ScanMode scanMode) async {
    if (cancelButtonText.isEmpty) {
      cancelButtonText = 'Cancel';
    }

    // Pass params to the plugin
    Map params = <String, dynamic>{
      'lineColor': lineColor,
      'cancelButtonText': cancelButtonText,
      'isShowFlashIcon': isShowFlashIcon,
      'isContinuousScan': false,
      'scanMode': scanMode.index
    };

    /// Get barcode scan result
    final barcodeResult =
        await _channel.invokeMethod('scanBarcode', params) ?? '';
    return barcodeResult;
  }
  static Stream? getBarcodeStreamReceiver(String lineColor,
      String cancelButtonText, bool isShowFlashIcon, ScanMode scanMode) {
    if (cancelButtonText.isEmpty) {
      cancelButtonText = 'Cancel';
    }

    // Pass params to the plugin
    Map params = <String, dynamic>{
      'lineColor': lineColor,
      'cancelButtonText': cancelButtonText,
      'isShowFlashIcon': isShowFlashIcon,
      'isContinuousScan': true,
      'scanMode': scanMode.index
    };

    // Invoke method to open camera, and then create an event channel which will
    // return a stream
    _channel.invokeMethod('scanBarcode', params);
    _onBarcodeReceiver ??= _eventChannel.receiveBroadcastStream();
    return _onBarcodeReceiver;
  }
}