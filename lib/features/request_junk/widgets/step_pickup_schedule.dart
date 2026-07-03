import 'dart:io';
import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// Step 3: Pickup location & notes.
class StepPickupSchedule extends StatelessWidget {
  /// Creates a [StepPickupSchedule] widget.
  const StepPickupSchedule({
    required this.addressController,
    required this.notesController,
    required this.onChanged,
    required this.vehicleTitle,
    required this.condition,
    required this.selectedImages,
    required this.onImagesChanged,
    super.key,
  });

  /// Controller for the pickup address input.
  final TextEditingController addressController;

  /// Controller for additional notes.
  final TextEditingController notesController;

  /// Callback when text input changes.
  final VoidCallback onChanged;

  /// Combined vehicle title from Step 1.
  final String vehicleTitle;

  /// Selected condition from Step 2.
  final String condition;

  /// Selected image file paths.
  final List<String> selectedImages;

  /// Callback when the list of selected images changes.
  final ValueChanged<List<String>> onImagesChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pickup location & notes',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 24.h),
          _buildLabel('PICKUP ADDRESS'),
          _buildTextField(
            controller: addressController,
            hintText: '4521 Westheimer Rd, Houston, TX 77027',
            onChanged: (_) => onChanged(),
          ),
          SizedBox(height: 20.h),
          _buildLabel('ADDITIONAL NOTES'),
          _buildTextField(
            controller: notesController,
            hintText: 'e.g. Car is in the driveway, keys under the mat...',
            maxLines: 4,
            onChanged: (_) => onChanged(),
          ),
          SizedBox(height: 20.h),
          _buildAddPhotosButton(context),
          if (selectedImages.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildSelectedImagesGrid(),
          ],
          SizedBox(height: 24.h),
          _buildLabel('SUMMARY'),
          _buildSummaryCard(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.onboardingTextSecondary.withValues(alpha: 0.6),
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    void Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.onboardingTextPrimary,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: AppColors.onboardingCyan,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onboardingTextSecondary.withValues(alpha: 0.5),
            fontSize: 15.sp,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(
              color: AppColors.onboardingCyan,
              width: 1.5,
            ),
          ),
          filled: false,
        ),
      ),
    );
  }

  // Future<void> _pickImages(BuildContext context) async {
  //   final picker = ImagePicker();
  //   try {
  //     final pickedFiles = await picker.pickMultiImage();
  //     if (pickedFiles.isNotEmpty) {
  //       final paths = pickedFiles.map((file) => file.path).toList();
  //       final currentList = List<String>.from(selectedImages)..addAll(paths);
  //       onImagesChanged(currentList);
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to pick images: $e'),
  //           backgroundColor: AppColors.error,
  //         ),
  //       );
  //     }
  //   }
  // }

  Widget _buildAddPhotosButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // unawaited(_pickImages(context));
      },
      borderRadius: BorderRadius.circular(16.r),
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: Colors.white.withValues(alpha: 0.15),
          strokeWidth: 1,
          borderRadius: 16.r,
          dashWidth: 6,
          dashSpace: 4,
        ),
        child: Container(
          width: double.infinity,
          height: 54.h,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                AppIcons.cameraAltOutlined,
                color: AppColors.onboardingTextSecondary,
                size: 20.r,
              ),
              SizedBox(width: 8.w),
              Text(
                'Add Photos (Optional)',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onboardingTextSecondary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImagesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.r,
        crossAxisSpacing: 12.r,
        childAspectRatio: 1,
      ),
      itemCount: selectedImages.length,
      itemBuilder: (context, index) {
        final path = selectedImages[index];
        return Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.file(
                  File(path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 8.r,
              right: 8.r,
              child: GestureDetector(
                onTap: () {
                  final updated = List<String>.from(selectedImages)
                    ..removeAt(index);
                  onImagesChanged(updated);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(4.r),
                  child: Icon(
                    AppIcons.close,
                    color: Colors.white,
                    size: 16.r,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SUMMARY',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onboardingTextSecondary.withValues(alpha: 0.5),
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            vehicleTitle.isNotEmpty ? vehicleTitle : 'Vehicle Details Empty',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            condition.isNotEmpty ? condition : 'Condition Details Empty',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (addressController.text.trim().isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              addressController.text.trim(),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onboardingTextSecondary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Custom painter to draw a dashed border.
class DashedBorderPainter extends CustomPainter {
  /// Creates a [DashedBorderPainter].
  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.borderRadius,
    this.dashWidth = 6.0,
    this.dashSpace = 4.0,
  });

  /// Dash stroke color.
  final Color color;

  /// Stroke width.
  final double strokeWidth;

  /// Corner border radius.
  final double borderRadius;

  /// Width of each dash line.
  final double dashWidth;

  /// Space between dash lines.
  final double dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final nextDistance = distance + dashWidth;
        final extractPath = metric.extractPath(
          distance,
          nextDistance > metric.length ? metric.length : nextDistance,
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
