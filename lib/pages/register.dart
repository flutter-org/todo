import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPageArgument {
  final String className;
  final String url;

  RegisterPageArgument(this.className, this.url);
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ImagePicker _picker = ImagePicker();
  File? image;

  void _getImage() async {
    final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
    if (xFile?.path != null) {
      setState(() {
        image = File(xFile!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final RegisterPageArgument argument = ModalRoute.of(context)?.settings.arguments as RegisterPageArgument;
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: _getImage,
                      child: FractionallySizedBox(
                        widthFactor: 0.4,
                        heightFactor: 0.4,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 48,
                              backgroundImage: (image == null
                                  ? const AssetImage(
                                      'assets/images/default_avatar.png',
                                    )
                                  : FileImage(image!)) as ImageProvider,
                            ),
                            Positioned(
                              right: 20,
                              top: 5,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(17),
                                  ),
                                  color: Color.fromARGB(255, 80, 210, 194),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 34,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
