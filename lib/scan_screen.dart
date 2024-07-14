import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:share_plus/share_plus.dart';
import 'db_helper.dart';
import 'history_screen.dart';

class ScanScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanningPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> history = await DatabaseHelper().getHistory();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen(history: history)),
                  );
                },
                child: Text('View History'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isScanningPaused) {
        setState(() {
          isScanningPaused = true;
        });
        _showResultDialog(scanData.code);
      }
    });
  }

  void _showResultDialog(String? qrText) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('QR Code Scanned'),
          content: Text(qrText ?? 'No data'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                DatabaseHelper().insertHistory(qrText ?? 'No data');
                Navigator.of(context).pop();
                setState(() {
                  isScanningPaused = false;
                });
              },
              child: Text('OK'),
            ),
            ElevatedButton(
              onPressed: () {
                if (qrText != null) {
                  Share.share(qrText);
                }
              },
              child: Text('Share'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
