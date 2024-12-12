// features/profile/presentation/pages/contact_us_widget.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/custom_widget/textfieldflorm_widget.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri whatsApp = Uri.parse('https://wa.me/+201223442528');
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
              ),
              SizedBox(
                height: mediaQuery.height * .1,
                child: Text(
                  "Contact Us",
                  style: TextStyle(
                      fontSize: mediaQuery.height * .06,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "We are pleased to contact you at any time",
                  style: gettitleTextStyle22(),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(
                height: mediaQuery.height * .04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: mediaQuery.height * .42,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text(
                        "Contact Information",
                        style: gettitleTextStyle30(
                          color: AppColor.whiteColor,
                        ),
                      ),
                      const Gap(18),
                      Icon(
                        Icons.call,
                        color: Colors.white,
                        size: mediaQuery.height * .04,
                      ),
                      Text(
                        "+ 01068268354 \n + 01068268354",
                        style: gettitleTextStyle18(color: AppColor.whiteColor),
                      ),
                      const Gap(30),
                      Icon(
                        Icons.email,
                        color: Colors.white,
                        size: mediaQuery.height * .04,
                      ),
                      Text(
                        "info@codingarabic.online",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: mediaQuery.height * .017),
                      ),
                      const Gap(30),
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: mediaQuery.height * .04,
                      ),
                      InkWell(
                        onTap: () {
                          MapsLauncher.launchQuery(
                              'https://www.google.com/maps/place/Elkomy+Company+-+%D8%B4%D8%B1%D9%83%D8%A9+%D8%A7%D9%84%D9%83%D9%88%D9%85%D9%8A%E2%80%AD/@30.296927,31.743947,16z/data=!4m6!3m5!1s0x1457fd9499316035:0x43e8c580560a9107!8m2!3d30.2969266!4d31.7439468!16s%2Fg%2F11clyp56mh?hl=en&entry=ttu&g_ep=EgoyMDI0MDkyNS4wIKXMDSoASAFQAw%3D%3D');
                        },
                        child: Text(
                          "دعم فني على مدار اليوم للإجابة على اي استفسار لديك",
                          style:
                              gettitleTextStyle16(color: AppColor.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // subscribe
              SizedBox(
                height: mediaQuery.height * .04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: mediaQuery.height * .7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      //name
                      TextfieldflormWidget(
                        isobsecure: false,
                        labeltext: "Name",
                      ),
                      const Gap(30),

                      //e-mail
                      TextfieldflormWidget(
                        isobsecure: false,
                        labeltext: "E-mail",
                      ),
                      const Gap(30),

                      //phone number
                      TextfieldflormWidget(
                        isobsecure: false,
                        labeltext: "Phone",
                      ),
                      const Gap(30),

                      //message

                      TextfieldflormWidget(
                        isobsecure: false,
                        labeltext: "Message",
                      ),
                      const Gap(50),

                      //button
                      CustomButton(
                        text: "Send Message",
                        textcolor: AppColor.whiteColor,
                        fontsize: 20,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        tooltip: "whatsApp chat",
        autofocus: true,
        onPressed: () {
          launchUrl(whatsApp);
        },
        child: Image.asset(
          "assets/images/whatsapp.png",
        ),
      ),
    );
  }
}
