import 'package:flutter/material.dart';
import 'package:overtime_connect_app/features/auth/onboarding/onboarding_view.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/profile/edit-email/edit_email_view.dart';
import 'package:overtime_connect_app/features/menu/profile/edit-password/edit_password_view.dart';
import 'package:overtime_connect_app/features/menu/profile/edit-profile/edit_profile_view.dart';
import 'package:overtime_connect_app/features/menu/profile/profile_view_model.dart';
import 'package:overtime_connect_app/features/menu/profile/widgets/profile_image.dart';
import 'package:overtime_connect_app/features/menu/profile/widgets/profile_info.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/components/custom_loading_dialog.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      model: ProfileViewModel(
        authApi: Provider.of(context),
      ),
      onModelReady: (ProfileViewModel model) => model.initModel(),
      onModelDispose: (ProfileViewModel model) => model.disposeModel(),
      builder: (BuildContext context, ProfileViewModel model, _) {
        return _buildBody(context, model);
      },
    );
  }
}

Widget _buildBody(BuildContext context, ProfileViewModel model) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Container(
        width: double.infinity,
        height: 300,
        color: AppColor.primary,
      ),
      Container(
        margin: const EdgeInsets.only(top: 150.0),
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(80.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Column(
            children: [
              ProfileInfo(
                fullName: model.user?.fullname,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 3,
                color: AppColor.stroke.withValues(alpha: 0.5),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        _profileMenu(
                          icon: Icons.person_outlined,
                          title: 'Edit Profile',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileView(
                                  user: model.user!,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        _profileMenu(
                          icon: Icons.email_outlined,
                          title: 'Edit Email',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditEmailView(
                                  user: model.user!,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        _profileMenu(
                          icon: Icons.lock_outline,
                          title: 'Edit Password',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPasswordView(
                                  user: model.user!,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        _profileMenu(
                          icon: Icons.info_outline,
                          title: 'Tentang Aplikasi',
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        _profileMenu(
                          icon: Icons.gpp_good_outlined,
                          title: 'Privacy Policy',
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        Button.filled(
                          color: AppColor.red,
                          borderRadius: 10,
                          height: 48,
                          onPressed: () {
                            showLoadingDialog(context);
                            model.logout(
                              success: (message) {
                                hideLoadingDialog(context);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => OnboardingView()),
                                  (route) => false,
                                );
                              },
                              error: (message) {
                                hideLoadingDialog(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                            );
                          },
                          label: 'Keluar',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 80,
        left: 0,
        right: 0,
        child: ProfileImage(
          photoUrl: model.user?.photo,
        ),
      ),
    ],
  );
}

Widget _profileMenu({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10.0),
          Text(
            title,
            style: AppFont.medium.copyWith(
              color: AppColor.black,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Icon(
            Icons.chevron_right_rounded,
            color: AppColor.primary,
          ),
        ],
      ),
    ),
  );
}
