import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:new_app/model/post_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/controller/landing_controller.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LandingController ctlr =
        Get.put<LandingController>(LandingController(landingRepo: Get.find()));
    return GetBuilder<LandingController>(
      init: LandingController(landingRepo: Get.find()),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Home Screen',
              style: GoogleFonts.ptSansCaption(),
            ),
          ),
          body: ctlr.isloading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal[900],
                    strokeWidth: 1,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: ctlr.posts.length,
                  itemBuilder: (_, i) {
                    PostModel item = ctlr.posts[i];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.teal[900],
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: ListTile(
                        title: Text(
                          item.title ?? '',
                          style: GoogleFonts.ptSansCaption(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          item.body ?? '',
                          style: GoogleFonts.ptSansCaption(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
