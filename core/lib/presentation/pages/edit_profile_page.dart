// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:core/core.dart';
import 'package:core/presentation/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatelessWidget {
  static const routeName = '/edit-profile';

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final dynamic user;

  bool showPassword = false;

  EditProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DatabaseBloc, DatabaseState>(
        listener: (context, state) {
          if (state is DatabaseSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  _buildHeader(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 130,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: _buildBody(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Container(
      padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  InkWell(
                    onTap: () async {
                      final file = await ImagePicker.platform
                          .pickImage(source: ImageSource.gallery);
                    },
                    child: const CircleAvatar(
                      radius: 50,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 43,
                        width: 43,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: kDarkGreen,
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 46,
              child: Text(
                "Nama",
                style: kHeading6.copyWith(
                  color: kSoftBlack,
                ),
              ),
            ),
            _buildTextField(user['name'], false),
            SizedBox(
              height: 46,
              child: Text(
                "Email",
                style: kHeading6.copyWith(
                  color: kSoftBlack,
                ),
              ),
            ),
            _buildTextField(user['email'], true),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: TextButton(
                    onPressed: (() {}),
                    style: TextButton.styleFrom(
                      backgroundColor: kWhite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          side: const BorderSide(color: kGrey, width: 2)),
                    ),
                    child: Text(
                      "Cancel",
                      style: kSubtitle.copyWith(
                        color: kSoftBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: CustomButton(
                      title: "Save",
                      onPressed: () {
                        BlocProvider.of<DatabaseBloc>(context).add(
                          DatabaseEditUser(
                              name: _nameController.text, uid: uid),
                        );
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String placeholder, readOnly) {
    return Container(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextFormField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: kRichBlack, width: 2),
              borderRadius: BorderRadius.circular(14),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
            fillColor: const Color.fromARGB(255, 231, 231, 231),
            hintText: placeholder,
            filled: true,
            hintStyle:
                GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          controller: readOnly ? _emailController : _nameController,
          readOnly: readOnly,
        ));
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 30,
        left: 30,
        bottom: 30,
        top: 50,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
        ),
        color: kGreen,
        image: DecorationImage(
            image: AssetImage('assets/green_substract.png'), fit: BoxFit.cover),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 14),
            ),
          ),
          Text(
            'Edit Profile',
            style: kHeading6.copyWith(color: kWhite),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
