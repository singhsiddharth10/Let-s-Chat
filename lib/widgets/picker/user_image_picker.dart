import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxWidth: 150,
        maxHeight: 50);

    setState(() {
      if (pickedFile != null)
        _image = File(pickedFile.path);
      else
        _image = null;
    });

    widget.imagePickFn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _image != null ? FileImage(_image) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _getImage,
          icon: Icon(
            Icons.image,
          ),
          label: Text('Add image'),
        ),
      ],
    );
  }
}
