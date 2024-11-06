import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:notehub/controller/profile_controller.dart";
import "package:notehub/core/config/color.dart";
import "package:notehub/core/config/typography.dart";
import "package:notehub/view/widgets/normal_button.dart";

class SettingsDrawerController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
  }
}

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2, top: 1),
      child: Drawer(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Settings", style: AppTypography.subHead1)),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Liked documents", style: AppTypography.subHead2),
                trailing: _nextIcon(),
              ),
              NormalButton(
                onPressed: Get.find<ProfileController>().logoutUser,
                child: Text(
                  "Log out",
                  style: AppTypography.subHead2.copyWith(
                    color: OtherColors.appleRed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _nextIcon() {
    return Icon(
      Icons.arrow_forward_ios,
      size: AppTypography.subHead2.fontSize! + 2,
    );
  }
}
