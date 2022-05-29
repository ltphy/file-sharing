import 'dart:async';

import 'package:badges/badges.dart';
import 'package:file_sharing/components/command_button_icon.dart';
import 'package:file_sharing/components/custom_outline_icon_buttton.dart';
import 'package:file_sharing/constants/constants.dart';
import 'package:file_sharing/services/control_command_receiver.dart';
import 'package:file_sharing/services/file_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

enum Pitch { up, down }

class _BodyState extends State<Body> {
  // text
  String text = '';
  String dropdownValue = 'One';
  bool showElevatedButtonBadge = false;

  //subject
  String subject = '';
  TextEditingController _newMediaLinkAddressController =
      TextEditingController();
  TextEditingController _newMediaLinkAddressController1 =
      TextEditingController();
  TextEditingController _newMediaLinkAddressController2 =
      TextEditingController();
  FocusNode mediaFocus1 = FocusNode(canRequestFocus: false);
  FocusNode mediaFocus2 = FocusNode(canRequestFocus: false);
  FocusNode mediaFocus3 = FocusNode(canRequestFocus: false);
  int count = 1000;

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

  void showBottomSheetSingleChildScrollView() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      // backgroundColor: Colors.,
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
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
              CommandButtonIcon(
                onPressed: () {},
                icon: Icon(Icons.arrow_right),
                label: 'forward left',
                isLoading: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text('${i + 1}'),
                    );
                  },
                  itemCount: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget numberDropDown() {
    return Listener(
      onPointerDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onTap: () async {
          print('delay');
          await Future.delayed(Duration(milliseconds: 500));
          // print('onTap');
          // FocusScopeNode currentFocus = FocusScope.of(context);
          //
          // if (!currentFocus.hasPrimaryFocus) {
          //   currentFocus.unfocus();
          // }
        },
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['One', 'Two']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Future<void> saveToStorage() async {}

  void showBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      // backgroundColor: Colors.,
      context: context,

      isScrollControlled: true,
      enableDrag: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                    focusNode: mediaFocus1,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(hintText: 'adddrss'),
                          autofocus: true,
                          controller: _newMediaLinkAddressController1,
                          focusNode: mediaFocus2,
                        ),
                      ),
                      Expanded(flex: 1, child: numberDropDown()),
                    ],
                  ),

                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(hintText: 'adddrss'),
                    autofocus: true,
                    controller: _newMediaLinkAddressController2,
                    focusNode: mediaFocus3,
                  ),
                  CommandButtonIcon(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_right),
                    label: 'Save to storage',
                    isLoading: false,
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemBuilder: (context, i) {
                  //       return ListTile(
                  //         title: Text('${i + 1}'),
                  //       );
                  //     },
                  //     itemCount: 5,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isShow = true;

  Future<void> getFiles() async {
    final contents = await context.read<FilePickerService>().getSingleFile();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('Information Status',
                    style: Theme.of(context).textTheme.headline5),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                        icon: isShow
                            ? Icon(Icons.arrow_drop_up_outlined)
                            : Icon(Icons.arrow_drop_down_outlined),
                        onPressed: () {
                          setState(() {
                            isShow = !isShow;
                          });
                        }),
                    UnconstrainedBox(
                      child: Badge(
                        padding: EdgeInsets.all(7),
                        animationType: BadgeAnimationType.scale,
                        showBadge: count != 0,
                        badgeColor: Theme.of(context).backgroundColor,
                        badgeContent: Text('$count',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.white)),
                        child: CommandButtonIcon(
                          onPressed: () {},
                          icon: Icon(Icons.view_list),
                          label: 'View saved',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          AnimatedCrossFade(
            duration: Duration(milliseconds: 250),
            crossFadeState:
                isShow ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            secondChild: Container(),
            firstChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      for (int i = 0; i < 10; i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Name',
                                style: Theme.of(context).textTheme.headline6),
                            Text('Name',
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      UnconstrainedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: CommandButtonIcon(
                            edgeInsets: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            onPressed: () {
                              setState(() {
                                count++;
                              });
                            },
                            icon: Icon(Icons.save),
                            label: 'Save Information',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: "TextField",
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onTap: () {
                  // FocusScope.of(context).requestFocus(FocusNode());
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              GestureDetector(
                onTap: () {
                  print("Tapped blue");
                },
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.blue,
                ),
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
                onPressed: () => showBottomSheetSingleChildScrollView(),
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
                onPressed: () => getFiles(),
                icon: Icon(Icons.arrow_right),
                label: 'get file picker',
                isLoading: context.watch<ControlCommandReceiver>().loading,
              ),
            ],
          ),
          SizedBox(
            height: 100,
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
