import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerLocalStorageScreen extends StatefulWidget {
  const ImagePickerLocalStorageScreen({super.key});

  @override
  State<ImagePickerLocalStorageScreen> createState() =>
      _ImagePickerLocalStorageScreen();
}

class _ImagePickerLocalStorageScreen
    extends State<ImagePickerLocalStorageScreen> {
  File? image;

  List<File> imageList = [];

  void pick(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
      );
      if (pickedFile != null) {
        log(pickedFile.path, name: 'pickedFile');
        final imageFile = File(pickedFile.path);
        
        log(imageFile.path.toString(), name: 'ImageFile');

        final appDir = await getApplicationDocumentsDirectory();
        final filePath = appDir.path;
        final fileName = imageFile.path.split('/').last;

        final savedFile = await imageFile.copy('$filePath/$fileName');
        log(savedFile.path.toString(), name: 'savedFile');

        setState(() {
          image = savedFile;
        });
        // final base64 = base64Encode(await pickedFile.readAsBytes());
        // log(base64, name: 'Base64');
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s, name: 'ImagePicker error');
    }
  }

  void pickMultiImage() async {
    final picker = ImagePicker();
    List<File> imageFiles = [];
    final pickedFiles = await picker.pickMultiImage();
    for (XFile element in pickedFiles) {
      imageFiles.add(
        File(element.path),
      );
    }
    setState(() {
      imageList.addAll(imageFiles);

      // imageList = imageFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Image picker',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Wrap(
              children: List.generate(
                  imageList.length + 1,
                  (index) => index == imageList.length
                      ? GestureDetector(
                          onTap: pickMultiImage,
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                            ),
                            height: 80,
                            width: 80,
                            color: Colors.cyan[100],
                            child: const Icon(
                              Icons.add_photo_alternate_outlined,
                            ),
                          ),
                        )
                      : Image.file(
                          imageList[index],
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        )),
            ),
            GestureDetector(
              onTap: () {
                pick(ImageSource.camera);
                // pick(ImageSource.gallery);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 194, 229, 229),
                  borderRadius: BorderRadius.circular(50),
                ),
                margin: const EdgeInsets.only(top: 50),
                height: 100,
                width: 100,
                child: const Icon(
                  Icons.add_a_photo,
                  color: Color.fromARGB(255, 49, 121, 245),
                ),
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                // pick(ImageSource.camera);
                pick(ImageSource.gallery);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 194, 229, 229),
                  image: image == null
                      ? null
                      : DecorationImage(
                          image: FileImage(image!),
                          fit: BoxFit.fill,
                        ),
                ),
                height: 200,
                width: 200,
                child: image == null
                    ? const Icon(
                        Icons.image,
                        color: Color.fromARGB(255, 1, 151, 197),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
