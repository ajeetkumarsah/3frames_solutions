import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/controller/auth_controller.dart';
import 'package:new_app/utils/routes/app_pages.dart';
import 'package:new_app/view/widgets/custom_text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              title: 'eg. Ajeet Kumar Sah',
              label: 'Name',
              controller: controller.nameCtlr,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                }
                return 'Required field!';
              },
            ),
            CustomTextFormField(
              title: '+91 987654321',
              label: 'Phone',
              keyboardType: TextInputType.phone,
              controller: controller.phoneCtlr,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                }
                return 'Phone field is required! ';
              },
            ),
            Obx(() {
              if (controller.otpSent.value) {
                return CustomTextFormField(
                  controller: controller.otpCtlr,
                  label: 'OTP',
                  title: 'eg.123456',
                );
              }
              return const SizedBox();
            }),
            Obx(
              () => GestureDetector(
                onTap: () => controller.otpSent.value
                    ? controller.sendOtp
                    : controller.submit(),
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.teal[900],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    controller.otpSent.value ? 'Verify OTP' : 'Send OTP',
                    style: GoogleFonts.ptSansCaption(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppPages.landingScreen),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.teal[900],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Go To Home Page',
                  style: GoogleFonts.ptSansCaption(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
