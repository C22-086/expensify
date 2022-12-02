// ignore_for_file: must_be_immutable

import 'package:core/core.dart';
import 'package:core/presentation/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatelessWidget {
  static const routeName = '/edit-profile';

  final TextEditingController _editTextController = TextEditingController();
  bool showPassword = false;

  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final dbRef = FirebaseDatabase.instance.ref('users/$uid').once();

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 130,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: buildBody(dbRef),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(dbRef) {
    return FutureBuilder(
        future: dbRef,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          final user = snapshot.data.snapshot.value;
          return snapshot.hasData
              ? Container(
                  padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: ListView(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              radius: 50,
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
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
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
                      buildTextField(user['name']),
                      SizedBox(
                        height: 46,
                        child: Text(
                          "Email",
                          style: kHeading6.copyWith(
                            color: kSoftBlack,
                          ),
                        ),
                      ),
                      buildTextField(user['email']),
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
                                    borderRadius:
                                        BorderRadius.circular(defaultRadius),
                                    side: const BorderSide(
                                        color: kGrey, width: 2)),
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
                            child:
                                CustomButton(title: "Save", onPressed: () {}),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container();
        });
  }

  Widget buildTextField(String placeholder) {
    return Container(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
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
          controller: _editTextController,
        ));
  }

  Container buildHeader(BuildContext context) {
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
