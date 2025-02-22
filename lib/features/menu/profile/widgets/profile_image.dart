import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/core/constants/app_constants.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';

class ProfileImage extends StatelessWidget {
  final String? photoUrl;

  const ProfileImage({super.key, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColor.primary,
            width: 8,
          ),
          image: DecorationImage(
            image: (photoUrl != null && photoUrl!.isNotEmpty)
                ? NetworkImage(
                    '${AppConstants.photoUrl}/$photoUrl',
                  )
                : AssetImage(
                    Assets.images.placeholder.path,
                  ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
