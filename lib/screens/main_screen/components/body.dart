import 'package:file_sharing/components/command_button_icon.dart';
import 'package:file_sharing/services/control_command_receiver.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // text
  String text = '';

  //subject
  String subject = '';
  TextEditingController _newMediaLinkAddressController =
      TextEditingController();
  TextEditingController _newMediaLinkAddressController1 =
      TextEditingController();
  TextEditingController _newMediaLinkAddressController2 =
      TextEditingController();

  // imagePaths
  List<String> imagePaths = [];

  void _onDeleteImage(int position) {
    setState(() {
      imagePaths.removeAt(position);
    });
  }

  void _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  void showBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      // backgroundColor: Colors.,
      context: context,
      // isScrollControlled: true,
      enableDrag: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Enter your address',
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'adddrss'),
                    autofocus: true,
                    controller: _newMediaLinkAddressController,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(hintText: 'adddrss'),
                    autofocus: true,
                    controller: _newMediaLinkAddressController1,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(hintText: 'adddrss'),
                    autofocus: true,
                    controller: _newMediaLinkAddressController2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CommandButtonIcon(
                onPressed: () =>
                    context.read<ControlCommandReceiver>().backwardLeft(),
                icon: Icon(Icons.arrow_right),
                label: 'forward left',
                isLoading: context.watch<ControlCommandReceiver>().loading,
              ),
              CommandButtonIcon(
                onPressed: () =>
                    context.read<ControlCommandReceiver>().backwardLeft(),
                icon: Icon(Icons.arrow_right),
                label: 'forward left',
                isLoading: context.watch<ControlCommandReceiver>().loading,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CommandButtonIcon(
                onPressed: () => showBottomSheet(),
                icon: Icon(Icons.arrow_right),
                label: 'forward left',
                isLoading: context.watch<ControlCommandReceiver>().loading,
              ),
              CommandButtonIcon(
                onPressed: () =>
                    context.read<ControlCommandReceiver>().backwardLeft(),
                icon: Icon(Icons.arrow_right),
                label: 'forward left',
                isLoading: context.watch<ControlCommandReceiver>().loading,
              ),
            ],
          )
        ],
      ),
    );
    // return Container(
    //   child: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.all(24.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           TextField(
    //             decoration: const InputDecoration(
    //               labelText: 'Share text',
    //               hintText: 'Enter some text and/or link to share',
    //             ),
    //             maxLines: 2,
    //             onChanged: (String value) => setState(() {
    //               text = value;
    //             }),
    //           ),
    //           TextField(
    //             decoration: const InputDecoration(
    //               labelText: 'Share object:',
    //               hintText: 'Enter subject to share (optional)',
    //             ),
    //             maxLines: 2,
    //             onChanged: (String value) => setState(() {
    //               text = value;
    //             }),
    //           ),
    //           ImagePreviews(imagePaths, onDelete: _onDeleteImage),
    //           ListTile(
    //             leading: const Icon(Icons.add),
    //             title: const Text('Add image'),
    //             onTap: () async {
    //               final imagePicker = ImagePicker();
    //               final pickedFile = await imagePicker.pickImage(
    //                 source: ImageSource.gallery,
    //               );
    //               if (pickedFile != null) {
    //                 setState(() {
    //                   imagePaths.add(pickedFile.path);
    //                 });
    //               }
    //             },
    //           ),
    //           const Padding(padding: EdgeInsets.only(top: 12.0)),
    //           Builder(
    //             builder: (BuildContext context) {
    //               return ElevatedButton(
    //                 onPressed: text.isEmpty && imagePaths.isEmpty
    //                     ? null
    //                     : () => _onShare(context),
    //                 child: const Text('Share'),
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
