import 'dart:convert';
import 'dart:ui';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class ImagePicketDialog extends StatefulWidget {
  ImagePicketDialog({Key key, @required this.remove}) : super(key: key);
  final bool remove;

  @override
  _ImagePicketDialogState createState() => _ImagePicketDialogState();
}

class _ImagePicketDialogState extends State<ImagePicketDialog> {
  final _userDataService = locator<UserDataService>();
  bool busy = false;

  var storedImage;
  Future<void> takePicture(bool camera) async {
    setState(() {
      busy = true;
    });
    final imagePicker = new ImagePicker();
    final imageFile = await imagePicker.getImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 500,
        maxWidth: 500);
    if (imageFile == null) {
      setState(() {
        busy = false;
      });
      return;
    }
    final bytes = await imageFile.readAsBytes();
    final img64 = base64Encode(bytes);
    await _userDataService.setMyImage(img64);

    setState(() {
      storedImage = base64Decode(img64);
      busy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: ksigmaX, sigmaY: ksigmaY),
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: Colors.black45,
          title: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: busy
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : _userDataService.user.myAvatar == null
                        ? Container(
                            child: AutoSizeText(
                              _userDataService.user.username[0].toUpperCase(),
                              style: kTextFormFieldStyle.copyWith(fontSize: 30),
                            ),
                          )
                        : ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: MemoryImage(
                                      _userDataService.user.myAvatar,
                                    )),
                              ),
                            ),
                          ),
              ),
              Text(
                "Choose a photo",
                style: kTextFormFieldStyle.copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (widget.remove)
              GestureDetector(
                  onTap: () async {
                    print("remove");
                    setState(() {
                      busy = true;
                    });
                    await _userDataService.removeMyImage();
                    setState(() {
                      busy = false;
                    });
                  },
                  child: Icon(CupertinoIcons.delete_solid,
                      color: Colors.white, size: 35)),
            if (widget.remove)
              SizedBox(
                width: 30,
              ),
            GestureDetector(
                onTap: () async {
                  print("camera");
                  await takePicture(true);
                },
                child: Icon(CupertinoIcons.photo_camera_solid,
                    color: Colors.white, size: 35)),
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () async {
                print('gallery');
                await takePicture(false);
              },
              child: Icon(
                Icons.photo_library,
                color: Colors.white,
                size: 35,
              ),
            ),
          ]),
        ));
  }
}
