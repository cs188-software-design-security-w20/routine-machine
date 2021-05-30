import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:routine_machine/Views/components/custom_route.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import './HomePage.dart';
import './SetUserInfoPage.dart';

import '../../constants/Constants.dart' as Constants;
import '../../constants/Palette.dart' as Palette;

enum VerificationStatus {
  pending,
  success,
  failed,
}

class ScanQRPage extends StatefulWidget {
  final User user;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  ScanQRPage({this.user});
  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  VerificationStatus _verificationStatus = VerificationStatus.pending;
  Barcode result;
  QRViewController controller;
  APIWrapper apiWrapper = APIWrapper();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiWrapper.setUser(widget.user);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Palette.primary,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _verificationStatus == VerificationStatus.success
                ? Center(
                    child: Text('Success!', style: Constants.kTitle1Style),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _verificationStatus == VerificationStatus.failed
                          ? Text(
                              'Invalid Code',
                              style: Constants.kUnselectedTitleStyle,
                            )
                          : RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: Constants.kUnselectedTitleStyle,
                                children: [
                                  TextSpan(
                                      text: 'New device',
                                      style: TextStyle(color: Palette.primary)),
                                  TextSpan(
                                    text: ' login detected\n',
                                  ),
                                  TextSpan(text: 'Please verify your identity')
                                ],
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Scan QR Code',
                          style: Constants.kTitle1Style,
                        ),
                      ),
                      Text(
                        'On a logged-in device,\n find under Account > View Credentials',
                        style: Constants.kBodyLabelStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Future<bool> _validateQRCode(Barcode qrCode) async {
    // TODO: validate that QRCode works
    String key = qrCode.code;
    print("PRIVATE KEY: $key");
    bool validKey = await apiWrapper.validateDevicePrivateKey(scannedKey: key);
    // bool validKey = await Future.delayed(Duration(seconds: 1), () => true);
    return validKey;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanData.format == BarcodeFormat.qrcode) {
          _validateQRCode(scanData).then((validCode) {
            if (validCode) {
              print('valid code!!!');
              _verificationStatus = VerificationStatus.success;
              apiWrapper.cse.setPrivateKey(key: scanData.code).then((result) {
                Navigator.pushReplacement(
                  context,
                  FadePageRoute(
                      builder: (context) => HomePage(user: widget.user)),
                ).catchError((error) {
                  print('Error setting private key: $error');
                  _verificationStatus = VerificationStatus.failed;
                });
              });
            } else {
              _verificationStatus = VerificationStatus.failed;
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
