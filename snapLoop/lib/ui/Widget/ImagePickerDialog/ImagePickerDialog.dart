import 'dart:convert';
import 'dart:ui';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class ImagePicketDialog extends StatefulWidget {
  ImagePicketDialog({Key key}) : super(key: key);

  @override
  _ImagePicketDialogState createState() => _ImagePicketDialogState();
}

class _ImagePicketDialogState extends State<ImagePicketDialog> {
  final _userDataService = locator<UserDataService>();

  var storedImage;
  Future<void> takePicture(bool camera) async {
    final imagePicker = new ImagePicker();
    final imageFile = await imagePicker.getImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 500,
        maxWidth: 500);
    if (imageFile == null) {
      return;
    }
    final bytes = await imageFile.readAsBytes();
    final img64 = base64Encode(bytes);
    _userDataService.setMyImage(img64);

    setState(() {
      storedImage = base64Decode(img64);
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
                child: storedImage == null
                    ? Container()
                    : ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(
                                  storedImage,
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
            GestureDetector(
                onTap: () {
                  print("camera");
                  takePicture(true);
                },
                child: Icon(CupertinoIcons.photo_camera,
                    color: Colors.white, size: 50)),
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () {
                print('gallery');
                takePicture(false);
              },
              child: Icon(
                Icons.photo_size_select_large,
                color: Colors.white,
                size: 45,
              ),
            ),
          ]),
        ));
  }
}
