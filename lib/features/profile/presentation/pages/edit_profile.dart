// features/profile/presentation/pages/edit_profile.dart
import 'dart:io';

import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/custom_widget/textfieldflorm_widget.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/auth/data/response/new_password_response/user.dart';
import 'package:bookia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.model});
  final User model;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  String path = '';

  uploadImage() async {
    var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      setState(() {
        path = pickedImage.path;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController = TextEditingController(text: widget.model.name);
    phoneController = TextEditingController(text: widget.model.phone);
    addressController = TextEditingController(text: widget.model.address);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is UpdateProfileLoadingState) {
          showLoadingDialog(context);
        } else if (state is UpdateProfileSuccessState) {
          context.read<ProfileBloc>().add(GetProfileEvent());
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is UpdateProfileErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
            ),
          );
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: gettitleTextStyle26(),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (path.isNotEmpty) {
                    context.read<ProfileBloc>().add(UpdateProfileEvent(
                            model: User(
                          name: usernameController.text,
                          phone: phoneController.text,
                          address: addressController.text,
                          image: path,
                        )));
                  } else {
                    context.read<ProfileBloc>().add(UpdateProfileEvent(
                            model: User(
                          name: usernameController.text,
                          phone: phoneController.text,
                          address: addressController.text,
                        )));
                  }
                }
              },
              text: 'Update Profile',
              textcolor: AppColor.whiteColor,
              fontsize: 20,
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColor.grayColor,
                          radius: 80,
                          backgroundImage: path.isNotEmpty
                              ? FileImage(File(path)) as ImageProvider
                              : NetworkImage(
                                  widget.model.image ?? '',
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColor.whiteColor,
                            child: IconButton(
                                onPressed: () {
                                  uploadImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColor.primaryColor,
                                )),
                          ),
                        ),
                      ],
                    ),
                    const Gap(60),
                    TextfieldflormWidget(
                      isobsecure: false,
                      hinttext: "Full Name",
                      fontsize: 16,
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    TextfieldflormWidget(
                      isobsecure: false,
                      hinttext: "Phone",
                      fontsize: 16,
                      controller: phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    TextfieldflormWidget(
                      isobsecure: false,
                      hinttext: "Address",
                      fontsize: 16,
                      controller: addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
