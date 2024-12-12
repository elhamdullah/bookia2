// features/profile/presentation/pages/profile_screen.dart
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/features/auth/presentation/page/login/forget_password.dart';
import 'package:bookia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bookia/features/profile/presentation/pages/about_us_widget.dart';
import 'package:bookia/features/profile/presentation/pages/contact_us_widget.dart';
import 'package:bookia/features/profile/presentation/pages/edit_profile.dart';
import 'package:bookia/features/profile/presentation/pages/terms_condition_widget.dart';
import 'package:bookia/features/profile/presentation/widget/mycard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          var profile = context.read<ProfileBloc>().profileResponse?.data;
          if (state is GetProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetProfileSuccessState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // image profile
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            profile?.image ?? "",
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // name
                            Text(
                              profile?.name ?? "",
                              style: gettitleTextStyle26(),
                            ),
                            // email address
                            Text(
                              profile?.email ?? "",
                              style: gettitleTextStyle16(
                                  color: AppColor.grayColor),
                            ),
                          ],
                        ))
                      ],
                    ),
                    const Gap(30),
                    MycardWidget(
                      title: Text(
                        'My Orders',
                        style: gettitleTextStyle18(),
                      ),
                      onTap: () {},
                    ),
                    const Gap(5),
                    MycardWidget(
                      onTap: () {
                        pushTo(
                            context,
                            EditProfile(
                              model: profile!,
                            ));
                      },
                      title: Text(
                        "Edit Profile",
                        style: gettitleTextStyle18(),
                      ),
                    ),
                    const Gap(5),
                    MycardWidget(
                      onTap: () {
                        pushTo(context, ForgetPassword());
                      },
                      title: Text(
                        'Reset Password',
                        style: gettitleTextStyle18(),
                      ),
                    ),
                    const Gap(5),
                    MycardWidget(
                        onTap: () {
                          pushTo(context, ContactUsWidget());
                        },
                        title: Text(
                          'Contact US',
                          style: gettitleTextStyle18(),
                        )),
                    const Gap(5),
                    MycardWidget(
                        onTap: () {
                          pushTo(context, AboutUsPage());
                        },
                        title: Text(
                          'About US',
                          style: gettitleTextStyle18(),
                        )),
                    const Gap(5),
                    MycardWidget(
                        onTap: () {
                          pushTo(context, TermsConditionWidget());
                        },
                        title: Text(
                          'Terms & Conditions',
                          style: gettitleTextStyle18(),
                        )),
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator(
              color: Colors.red,
            );
          }
        },
      ),
    );
  }
}
