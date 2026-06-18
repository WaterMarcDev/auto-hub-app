import 'dart:math' as math;

import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/your_addresses/presentation/models/address_model.dart';
import 'package:auto_hub_app/features/your_addresses/presentation/widgets/address_card.dart';
import 'package:auto_hub_app/features/your_addresses/presentation/widgets/address_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YourAddressesPage extends StatefulWidget {
  const YourAddressesPage({super.key});

  @override
  State<YourAddressesPage> createState() => _YourAddressesPageState();
}

class _YourAddressesPageState extends State<YourAddressesPage> {
  // Mock initial address list matching the provided screenshot data
  final List<AddressModel> _addresses = [
    const AddressModel(
      id: '1',
      type: 'home',
      label: 'Home',
      streetAddress: '4521 Westheimer Rd',
      city: 'Houston',
      state: 'TX',
      zip: '77027',
      isDefault: true,
    ),
    const AddressModel(
      id: '2',
      type: 'work',
      label: 'Work',
      streetAddress: '1200 McKinney St, Suite 450',
      city: 'Houston',
      state: 'TX',
      zip: '77010',
      isDefault: false,
    ),
  ];

  void _setDefaultAddress(String id) {
    setState(() {
      for (var i = 0; i < _addresses.length; i++) {
        _addresses[i] = _addresses[i].copyWith(
          isDefault: _addresses[i].id == id,
        );
      }
    });
    _showSnackBar('Default address updated');
  }

  void _deleteAddress(String id) {
    final deletedIndex = _addresses.indexWhere((a) => a.id == id);
    if (deletedIndex == -1) return;

    final deletedAddress = _addresses[deletedIndex];

    setState(() {
      _addresses.removeAt(deletedIndex);
      // If we deleted the default address, and we still have addresses left, make the first one default
      if (deletedAddress.isDefault && _addresses.isNotEmpty) {
        _addresses[0] = _addresses[0].copyWith(isDefault: true);
      }
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted "${deletedAddress.label}"'),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: AppColors.onboardingCyan,
          onPressed: () {
            setState(() {
              _addresses.insert(deletedIndex, deletedAddress);
              // Restore default state if necessary
              if (deletedAddress.isDefault) {
                for (var i = 0; i < _addresses.length; i++) {
                  _addresses[i] = _addresses[i].copyWith(
                    isDefault: _addresses[i].id == deletedAddress.id,
                  );
                }
              }
            });
          },
        ),
      ),
    );
  }

  void _saveAddress(AddressModel address) {
    final index = _addresses.indexWhere((a) => a.id == address.id);
    setState(() {
      if (index != -1) {
        // Edit Mode
        _addresses[index] = address;
        _showSnackBar('Address "${address.label}" updated');
      } else {
        // Add Mode
        // If this is the very first address, automatically make it default
        final isFirst = _addresses.isEmpty;
        final newAddress = address.copyWith(isDefault: isFirst);
        _addresses.add(newAddress);
        _showSnackBar('Address "${address.label}" added');
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _openAddressForm([AddressModel? address]) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(maxWidth: 600),
      builder: (context) => AddressForm(
        initialAddress: address,
        onSave: _saveAddress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_addresses.isEmpty) ...[
                        _buildEmptyState(),
                      ] else ...[
                        _buildAddressesCard(),
                      ],
                      SizedBox(height: 20.h),
                      _buildAddButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.onboardingSurface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.07),
                    width: 0.8,
                  ),
                ),
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: math.pi,
                  child: SvgPicture.asset(
                    AppIcons.chevronRight,
                    width: 15.w,
                    height: 15.h,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Text(
              'Your Addresses',
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.onboardingTextPrimary,
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressesCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 19.h, 16.w, 8.h),
            child: Text(
              '${_addresses.length} SAVED ADDRESSES',
              style: AppTextStyles.labelLarge.copyWith(
                color: const Color(0xFF484F58),
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _addresses.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withValues(alpha: 0.05),
              height: 1,
              thickness: 0.8,
            ),
            itemBuilder: (context, index) {
              final address = _addresses[index];
              return AddressCard(
                address: address,
                onEdit: () => _openAddressForm(address),
                onDelete: () => _deleteAddress(address.id),
                onSetDefault: address.isDefault
                    ? null
                    : () => _setDefaultAddress(address.id),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () => _openAddressForm(),
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(
            color: AppColors.onboardingCyan.withValues(alpha: 0.3),
            width: 1.2,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              color: AppColors.onboardingCyan,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Add New Address',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.onboardingCyan,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
          width: 0.8,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: AppColors.onboardingCyan.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_off_outlined,
              color: AppColors.onboardingCyan,
              size: 28.sp,
            ),
          ),
          SizedBox(height: 18.h),
          Text(
            'No Saved Addresses',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Save your home, work, or other addresses here to checkout quickly.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 13.sp,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
