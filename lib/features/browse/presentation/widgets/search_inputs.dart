import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_type_toggle.dart';

class SearchInputs extends StatefulWidget {
  const SearchInputs({
    super.key,
    required this.searchType,
    required this.partController,
    required this.vinController,
    required this.onFilterTap,
    required this.onPartChanged,
    required this.onVinChanged,
  });

  final SearchType searchType;
  final TextEditingController partController;
  final TextEditingController vinController;
  final VoidCallback onFilterTap;
  final ValueChanged<String> onPartChanged;
  final ValueChanged<String> onVinChanged;

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
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: widget.partController,
              onChanged: widget.onPartChanged,
              cursorColor: const Color(0xFF00A8CC),
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
                  color: const Color(0xFF8B929A),
                  fontSize: 14.sp,
                ),
                prefixIcon: Container(
                  margin: EdgeInsets.only(left: 16.w, right: 12.w),
                  child: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF8B929A),
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
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Color(0xFF8B929A),
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
    Color borderC = Colors.transparent;
    Widget? suffixI;
    String helperL = '$len/17 digits';
    String? helperR;
    Color helperColor = const Color(0xFF8B929A);

    if (len == 0) {
      // State 1: Empty
      borderC = Colors.transparent;
      suffixI = null;
      helperColor = const Color(0xFF8B929A);
    } else if (len < 17) {
      // State 2: Incomplete
      borderC = const Color(0xFFFBBF24).withOpacity(0.3);
      suffixI = const Icon(
        Icons.error_outline_rounded,
        color: Color(0xFFFBBF24),
      );
      helperR = 'Keep typing...';
      helperColor = const Color(0xFFFBBF24);
    } else {
      // State 3: Valid (17 characters)
      borderC = const Color(0xFF22C55E);
      suffixI = const Icon(
        Icons.check_circle_outline_rounded,
        color: Color(0xFF22C55E),
      );
      helperR = 'Valid VIN — showing compatible parts';
      helperColor = const Color(0xFF22C55E);
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
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: widget.vinController,
            textCapitalization: TextCapitalization.characters,
            onChanged: (val) {
              widget.onVinChanged(val);
              if (val.length > 17) {
                // Restrict length to 17
                widget.vinController.text = val.substring(0, 17);
                widget.vinController.selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.vinController.text.length),
                );
              }
            },
            cursorColor: const Color(0xFF00A8CC),
            textAlignVertical: TextAlignVertical.center,
            style: GoogleFonts.spaceMono(
              fontSize: 13.sp,
              color: const Color(0xFFF0F6FC),
              letterSpacing: 1.5,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(17),
              _UpperCaseFormatter(),
              FilteringTextInputFormatter.allow(
                RegExp(r'[A-HJ-NPR-Za-hj-npr-z0-9]'),
              ),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              isDense: true,
              hintText: 'Enter 17-digit VIN number...',
              hintStyle: GoogleFonts.spaceMono(
                fontSize: 13.sp,
                color: const Color(0xFF8B929A),
                letterSpacing: 1.0,
              ),
              prefixIcon: Container(
                margin: EdgeInsets.only(left: 16.w, right: 12.w),
                child: Icon(
                  Icons.qr_code_scanner,
                  color: len == 0
                      ? const Color(0xFF8B929A)
                      : (len < 17
                            ? const Color(0xFFFBBF24)
                            : const Color(0xFF22C55E)),
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
                  color: const Color(0xFF8B929A),
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
