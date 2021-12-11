import 'package:file_sharing/services/control_command_receiver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'components/body.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PanelController panelController = PanelController();
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ControlCommandReceiver>(
            create: (BuildContext context) {
          return ControlCommandReceiver(
              robotLocation: RobotLocation(),
              flutterSecureStorage:
                  Provider.of<FlutterSecureStorage>(context, listen: false));
        }),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('File Sharing ')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
        ),
        body: SlidingUpPanel(
          renderPanelSheet: isOpen,
          panel: Container(),
          controller: panelController,
          body: Body(),
        ),
      ),
    );
  }
}
