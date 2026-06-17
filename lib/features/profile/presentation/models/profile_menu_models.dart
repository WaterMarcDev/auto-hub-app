import 'package:flutter/material.dart';

@immutable
class ProfileMenuItemData {
  const ProfileMenuItemData({
    required this.title,
    required this.iconPath,
    required this.iconBackgroundColor,
    this.onTap,
  });

  final String title;
  final String iconPath;
  final Color iconBackgroundColor;
  final VoidCallback? onTap;
}

@immutable
class ProfileMenuSectionData {
  const ProfileMenuSectionData({
    required this.title,
    required this.items,
  });

  final String title;
  final List<ProfileMenuItemData> items;
}
