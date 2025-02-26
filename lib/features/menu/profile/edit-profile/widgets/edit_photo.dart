import 'dart:io';

import 'package:flutter/material.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/core/constants/app_constants.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';

class EditPhoto extends StatelessWidget {
  final String? photoUrl;
  final File? imageFile;
  final VoidCallback onCameraTap;

  const EditPhoto({
    super.key,
    this.photoUrl,
    this.imageFile,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Foto Profil
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.white,
                width: 8,
              ),
              image: DecorationImage(
                image: (imageFile != null) // Mengecek apakah ada gambar lokal yang dipilih
                    ? FileImage(imageFile!) as ImageProvider // Jika ada, gunakan gambar dari file lokal
                    : (photoUrl != null && photoUrl!.isNotEmpty) // Jika tidak ada gambar lokal, cek apakah ada URL foto dari backend
                        ? NetworkImage('${AppConstants.photoUrl}/$photoUrl') as ImageProvider // Jika ada, gunakan gambar dari backend
                        : AssetImage(Assets.images.placeholder.path) as ImageProvider, // Jika tidak ada keduanya, gunakan gambar placeholder bawaan
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay Hitam Transparan
          GestureDetector(
            onTap: onCameraTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.3), // Efek transparan
              ),
              child: const Center(
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 24, // Ukuran ikon lebih besar
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectPhotoUpload extends StatelessWidget {
  final VoidCallback onGallerySelected;
  final VoidCallback onCameraSelected;

  const SelectPhotoUpload({
    super.key,
    required this.onGallerySelected,
    required this.onCameraSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Pilih foto dari galeri'),
            onTap: () {
              Navigator.pop(context);
              onGallerySelected();
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Ambil foto dengan kamera'),
            onTap: () {
              Navigator.pop(context);
              onCameraSelected();
            },
          ),
        ],
      ),
    );
  }
}
