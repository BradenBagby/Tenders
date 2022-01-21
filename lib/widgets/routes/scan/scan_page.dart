import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/permissions.dart';
import 'package:tenders/services/interfaces/i_room.dart';

class ScanPage extends StatefulWidget {
  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool hasPermissions = false;

  @override
  void initState() {
    if (kIsWeb) {
      hasPermissions = true;
    } else {
      Permissions.camera().then((value) {
        setState(() {
          hasPermissions = value;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _build(),
        Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ))
      ],
    ));
  }

  Widget _build() {
    return Builder(
      builder: (context) {
        if (!hasPermissions) {
          return Center(
            child: Text("Give Tender camera permissions to scan a QR code"),
          );
        }

        return Center(
          child: kIsWeb
              ? Text("Scan QR Code of your friend to join")
              : QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController controller) {
                    _onQRViewCreated(controller, context);
                  }),
        );
      },
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    controller.scannedDataStream.listen((scanData) async {
      try {
        final code = scanData.code;
        final success = await GetIt.I<RoomAuthCubit>().joinRoom(code!);
        if (!success) throw Exception();
      } catch (er) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Failed to join room. If this problem persists contact support"),
        ));
      }
    });
  }
}
