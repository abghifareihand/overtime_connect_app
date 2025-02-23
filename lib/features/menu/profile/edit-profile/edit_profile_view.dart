import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/core/models/user_model.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/menu_view.dart';
import 'package:overtime_connect_app/features/menu/profile/edit-profile/edit_profile_view_model.dart';
import 'package:overtime_connect_app/features/menu/profile/edit-profile/widgets/dropdown_working_days.dart';
import 'package:overtime_connect_app/features/menu/profile/edit-profile/widgets/edit_photo.dart';
import 'package:overtime_connect_app/features/menu/profile/edit-salary/edit_salary_view.dart';
import 'package:overtime_connect_app/ui/components/custom_button.dart';
import 'package:overtime_connect_app/ui/components/custom_header.dart';
import 'package:overtime_connect_app/ui/components/custom_loading_dialog.dart';
import 'package:overtime_connect_app/ui/components/custom_textfield_label.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatelessWidget {
  final User user;
  const EditProfileView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<EditProfileViewModel>(
      model: EditProfileViewModel(
        authApi: Provider.of(context),
        user: user,
      ),
      onModelReady: (EditProfileViewModel model) => model.initModel(),
      onModelDispose: (EditProfileViewModel model) => model.disposeModel(),
      builder: (BuildContext context, EditProfileViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _buildBody(context, model, user),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, EditProfileViewModel model, User user) {
  return CustomScaffold(
    title: 'Edit Profil',
    subtitle: 'Update profil terbaru',
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          EditPhoto(
            onCameraTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColor.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.0),
                  ),
                ),
                builder: (context) {
                  return SelectPhotoUpload(
                    onGallerySelected: () => model.pickPhotoProfile(),
                    onCameraSelected: () => model.cameraPhotoProfile(),
                  );
                },
              );
            },
            photoUrl: user.photo,
            imageFile: model.photoProfile,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'Ubah Foto',
            style: AppFont.semiBold.copyWith(
              color: AppColor.black,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          CustomTextfieldLabel(
            controller: model.fullnameController,
            label: 'Nama',
            hintText: 'Nama',
            prefixIcon: Assets.svg.icProfile.svg(),
          ),
          const SizedBox(
            height: 16.0,
          ),
          CustomTextfieldLabel(
            controller: model.phoneController,
            keyboardType: TextInputType.phone,
            label: 'Nomor HP',
            hintText: 'Nomor HP',
            prefixIcon: Assets.svg.icPhone.svg(),
          ),
          const SizedBox(
            height: 16.0,
          ),
          DropdownWorkingDays(
            label: 'Waktu lembur',
            hintText: 'Ubah waktu lembur',
            value: model.selectedWorkingDays?.id,
            items: model.workingDays.map((e) => e.id).toList(),
            itemLabels: model.workingDays.map((e) => e.title).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                final selected = model.workingDays.firstWhere((e) => e.id == newValue);
                model.updateWorkingDays(selected);
              }
            },
            prefixIcon: Assets.svg.icCalender.svg(),
          ),
          const SizedBox(
            height: 16.0,
          ),
          CustomTextfieldLabel(
            readOnly: true,
            controller: model.salaryController,
            keyboardType: TextInputType.number,
            label: 'Gaji Pokok',
            hintText: 'Gaji Pokok',
            prefixIcon: Assets.svg.icWallet.svg(),
            suffixIcon: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditSalaryView(salary: user.salary),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                size: 16,
                color: AppColor.primary,
              ),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Button.filled(
            onPressed: () async {
              showLoadingDialog(context);
              model.updateProfile(
                success: (message) {
                  hideLoadingDialog(context);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MenuView()),
                    (Route<dynamic> route) => false,
                  );
                },
                error: (errorMessage) {
                  hideLoadingDialog(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                      backgroundColor: AppColor.red,
                    ),
                  );
                },
              );
            },
            label: 'Simpan',
          ),
        ],
      ),
    ),
  );
}
