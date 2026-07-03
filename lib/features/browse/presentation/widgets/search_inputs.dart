import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/features/browse/presentation/widgets/search_type_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchInputs extends StatefulWidget {
  const SearchInputs({
    required this.searchType,
    required this.partController,
    required this.vinController,
    required this.onFilterTap,
    super.key,
  });

  final SearchType searchType;
  final TextEditingController partController;
  final TextEditingController vinController;
  final VoidCallback onFilterTap;

  @override
  State<SearchInputs> createState() => _SearchInputsState();
}

class _SearchInputsState extends State<SearchInputs> {
  @override
  void initState() {
    super.initState();
    widget.vinController.addListener(_onVinTextChanged);
  }

  @override
  void dispose() {
    widget.vinController.removeListener(_onVinTextChanged);
    super.dispose();
  }

  void _onVinTextChanged() {
    setState(() {}); // Rebuild to update helper text & validation states
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchType == SearchType.part) {
      return _buildPartSearch();
    } else {
      return _buildVinLookup();
    }
  }

  Widget _buildPartSearch() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 52.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F26),
              borderRadius: BorderRadius.circular(26.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: widget.partController,
              cursorColor: AppColors.info,
              textAlignVertical: TextAlignVertical.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                isDense: true,
                hintText: 'Part name, make, model...',
                hintStyle: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                ),
                prefixIcon: Container(
                  margin: EdgeInsets.only(left: 16.w, right: 12.w),
                  child: const Icon(
                    Icons.search_rounded,
                    color: AppColors.textSecondary,
                    size: 22,
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 50.w,
                  minHeight: 22,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16.h),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: widget.onFilterTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 52.w,
            height: 52.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F26),
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVinLookup() {
    final vin = widget.vinController.text;
    final len = vin.length;

    // Determine states
    var borderC = Colors.transparent;
    Widget? suffixI;
    final helperL = '$len/17 digits';
    String? helperR;
    var helperColor = AppColors.textSecondary;

    if (len == 0) {
      // State 1: Empty
      borderC = Colors.transparent;
      suffixI = null;
      helperColor = AppColors.textSecondary;
    } else if (len < 17) {
      // State 2: Incomplete
      borderC = AppColors.warning.withValues(alpha: 0.3);
      suffixI = const Icon(
        Icons.error_outline_rounded,
        color: AppColors.warning,
      );
      helperR = 'Keep typing...';
      helperColor = AppColors.warning;
    } else {
      // State 3: Valid (17 characters)
      borderC = AppColors.success;
      suffixI = const Icon(
        Icons.check_circle_outline_rounded,
        color: AppColors.success,
      );
      helperR = 'Valid VIN — showing compatible parts';
      helperColor = AppColors.success;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 52.h,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F26),
            borderRadius: BorderRadius.circular(16.r),
            border: borderC == Colors.transparent
                ? null
                : Border.all(
                    color: borderC,
                    width: len == 17 ? 1.5.w : 1.w,
                  ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: widget.vinController,
            textCapitalization: TextCapitalization.characters,
            onChanged: (val) {
              if (val.length > 17) {
                // Restrict length to 17
                widget.vinController.text = val.substring(0, 17);
                widget.vinController.selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.vinController.text.length),
                );
              }
            },
            cursorColor: AppColors.info,
            textAlignVertical: TextAlignVertical.center,
            style: GoogleFonts.spaceMono(
              fontSize: 13.sp,
              color: AppColors.onboardingTextPrimary,
              letterSpacing: 1.5,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(17),
              _UpperCaseFormatter(),
              FilteringTextInputFormatter.allow(
                RegExp('[A-HJ-NPR-Za-hj-npr-z0-9]'),
              ),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              isDense: true,
              hintText: 'Enter 17-digit VIN number...',
              hintStyle: GoogleFonts.spaceMono(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
                letterSpacing: 1,
              ),
              prefixIcon: Container(
                margin: EdgeInsets.only(left: 16.w, right: 12.w),
                child: Icon(
                  Icons.qr_code_scanner,
                  color: len == 0
                      ? AppColors.textSecondary
                      : (len < 17
                            ? AppColors.warning
                            : AppColors.success),
                  size: 22,
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 50.w,
                minHeight: 22,
              ),
              suffixIcon: suffixI != null
                  ? Container(
                      margin: EdgeInsets.only(right: 16.w),
                      child: suffixI,
                    )
                  : null,
              suffixIconConstraints: BoxConstraints(
                minWidth: 40.w,
                minHeight: 22,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 16.h),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                helperL,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
              if (helperR != null)
                Text(
                  helperR,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: helperColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}
