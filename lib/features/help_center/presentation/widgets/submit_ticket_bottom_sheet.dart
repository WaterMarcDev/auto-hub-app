import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitTicketBottomSheet extends StatefulWidget {
  const SubmitTicketBottomSheet({super.key});

  @override
  State<SubmitTicketBottomSheet> createState() => _SubmitTicketBottomSheetState();
}

class _SubmitTicketBottomSheetState extends State<SubmitTicketBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = 'General';

  final List<String> _categories = [
    'General',
    'Order Issue',
    'Part Question',
    'Junk Request',
    'Payment',
    'Bug Report',
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTicket() {
    if (_formKey.currentState?.validate() ?? false) {
      // Inputs are valid, close bottom sheet and return true to indicate success
      Navigator.of(context).pop({
        'category': _selectedCategory,
        'subject': _subjectController.text.trim(),
        'description': _descriptionController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onboardingBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.only(
        top: 8.h,
        left: 20.w,
        right: 20.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.colorWhite.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              
              // Header: Title and Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Submit a Ticket',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: AppColors.onboardingTextPrimary,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: AppColors.colorWhite.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.colorWhite.withValues(alpha: 0.08),
                          width: 0.8,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        AppIcons.close,
                        color: AppColors.onboardingTextSecondary,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              
              // Subtitle
              Text(
                "Describe your issue and we'll get back to you within 24 hours.",
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onboardingTextSecondary,
                  fontSize: 14.sp,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.h),
              
              // Category Section
              Text(
                'CATEGORY',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onboardingTextSecondary,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 10.h,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.onboardingCyan.withValues(alpha: 0.08)
                            : AppColors.colorWhite.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.onboardingCyan
                              : AppColors.colorWhite.withValues(alpha: 0.08),
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        category,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isSelected
                              ? AppColors.onboardingCyan
                              : AppColors.onboardingTextSecondary.withValues(alpha: 0.85),
                          fontSize: 13.sp,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),
              
              // Subject Section
              Text(
                'SUBJECT',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onboardingTextSecondary,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.onboardingSurfaceLight,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.colorWhite.withValues(alpha: 0.08),
                    width: 0.8,
                  ),
                ),
                child: TextFormField(
                  controller: _subjectController,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.colorWhite,
                    fontSize: 14.sp,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Brief description of your issue',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onboardingTextSecondary.withValues(alpha: 0.5),
                      fontSize: 14.sp,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 16.w,
                    ),
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.error,
                      height: 0.8,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Subject is required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 24.h),
              
              // Description Section
              Text(
                'DESCRIPTION',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onboardingTextSecondary,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.onboardingSurfaceLight,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.colorWhite.withValues(alpha: 0.08),
                    width: 0.8,
                  ),
                ),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  minLines: 4,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.colorWhite,
                    fontSize: 14.sp,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Please describe your issue in detail...',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onboardingTextSecondary.withValues(alpha: 0.5),
                      fontSize: 14.sp,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 16.w,
                    ),
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.error,
                      height: 0.8,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 32.h),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: _submitTicket,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.onboardingCyan,
                    foregroundColor: AppColors.colorWhite,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'Submit Ticket',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
