import 'dart:io';

import 'package:elanser_firebase/bloc/bloc/storage_bloc.dart';
import 'package:elanser_firebase/bloc/events/storage_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/states/storage_states.dart';
import '../../helpers/helpers.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> with Helpers {
  ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedFile;
  double? _linearProgressValue = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Upload Image',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<StorageBloc, StorageStates>(
        listenWhen: (previous, current) =>
            current is ProcessState && current.process == Process.create,
        listener: (context, state) {
          state as ProcessState;
          showSnackBar(
              context: context, message: state.message, error: !state.status);
          changeProgressValue(value: state.status ? 1 : 0);
        },
        child: Column(
          children: [
            LinearProgressIndicator(
              color: Colors.lightBlue,
              backgroundColor: Colors.grey,
              minHeight: 7,
              value: _linearProgressValue,
            ),
            Expanded(
              child: _pickedFile != null
                  ? Image.file(File(_pickedFile!.path))
                  : TextButton(
                      onPressed: () async => await _pickImage(),
                      style: TextButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text('Pick Image'),
                    ),
            ),
            ElevatedButton.icon(
              onPressed: () async => await performUpload(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: Colors.cyan,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20),
                  ),
                ),
              ),
              icon: const Icon(
                Icons.cloud_upload,
                color: Colors.white,
                size: 30,
              ),
              label: const Text('Upload',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? xFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (xFile != null) {
      setState(() {
        _pickedFile = xFile;
      });
    }
  }

  Future<void> performUpload() async {
    if (checkData()) {
      await uploadImage();
    }
  }

  bool checkData() {
    if (_pickedFile != null) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Select image to upload',
      error: true,
    );

    return false;
  }

  Future<void> uploadImage() async {
    changeProgressValue(value: null);
    BlocProvider.of<StorageBloc>(context).add(UploadEvents(_pickedFile!.path));
  }

  void changeProgressValue({double? value}) {
    setState(() {
      _linearProgressValue = value;
    });
  }
}
