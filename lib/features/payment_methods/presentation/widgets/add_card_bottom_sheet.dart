import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Modal bottom sheet that enables users to input new credit card info securely.
class AddCardBottomSheet extends StatefulWidget {
  const AddCardBottomSheet({
    required this.onAddCard,
    super.key,
  });

  final void Function({
    required String cardHolder,
    required String cardNumber,
    required String expiry,
    required String cvc,
  })
  onAddCard;

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _numberController.addListener(_validateForm);
    _expiryController.addListener(_validateForm);
    _cvcController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final name = _nameController.text.trim();
    final number = _numberController.text.replaceAll(RegExp(r'\s+'), '');
    final expiry = _expiryController.text.trim();
    final cvc = _cvcController.text.trim();

    final isNameValid = name.isNotEmpty;
    final isNumberValid = number.length >= 12 && number.length <= 19;

    bool isExpiryValid = false;
    final cleanExpiry = expiry.replaceAll(RegExp(r'\D'), '');
    if (cleanExpiry.length == 4) {
      final month = int.tryParse(cleanExpiry.substring(0, 2)) ?? 0;
      final year = int.tryParse(cleanExpiry.substring(2)) ?? 0;
      isExpiryValid = month >= 1 && month <= 12 && year >= 0 && year <= 99;
    }

    final isCvcValid = cvc.length >= 3 && cvc.length <= 4;

    setState(() {
      _isButtonEnabled =
          isNameValid && isNumberValid && isExpiryValid && isCvcValid;
    });
  }

  void _submit() {
    if (_isButtonEnabled) {
      widget.onAddCard(
        cardHolder: _nameController.text.trim(),
        cardNumber: _numberController.text.trim(),
        expiry: _expiryController.text.trim(),
        cvc: _cvcController.text.trim(),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensuring the bottom sheet resizes dynamically when keyboard appears.
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.onboardingBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Horizontal Top Handle Pill
                Center(
                  child: Container(
                    width: 44.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(2.5.r),
                    ),
                  ),
                ),
                SizedBox(height: 18.h),

                // Title and Close Button Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Card',
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 22.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          AppIcons.close,
                          color: Colors.white.withValues(alpha: 0.6),
                          size: 16.w,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Secure Banner
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.onboardingGreen.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColors.onboardingGreen.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.lockOutlineRounded,
                        color: AppColors.onboardingGreen,
                        size: 16.w,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'Your card info is encrypted and secure',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.onboardingGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Field 1: Cardholder Name
                _buildFieldLabel('CARDHOLDER NAME'),
                _buildTextField(
                  controller: _nameController,
                  hintText: 'Mike Johnson',
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                ),
                SizedBox(height: 18.h),

                // Field 2: Card Number
                _buildFieldLabel('CARD NUMBER'),
                _buildTextField(
                  controller: _numberController,
                  hintText: '1234 5678 9012 3456',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberFormatter(),
                    LengthLimitingTextInputFormatter(19),
                  ],
                ),
                SizedBox(height: 18.h),

                // Fields 3 & 4: Expiry and CVC
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('EXPIRY'),
                          _buildTextField(
                            controller: _expiryController,
                            hintText: 'MM/YY',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              ExpiryDateFormatter(),
                              LengthLimitingTextInputFormatter(5),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('CVC'),
                          _buildTextField(
                            controller: _cvcController,
                            hintText: '123',
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Submit Button
                GestureDetector(
                  onTap: _submit,
                  child: Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? AppColors.onboardingCyan
                          : AppColors.onboardingCyan.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: _isButtonEnabled
                          ? [
                              BoxShadow(
                                color: AppColors.onboardingCyan.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 12.r,
                                offset: Offset(0, 4.h),
                              ),
                            ]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Add Card',
                      style: AppTextStyles.button.copyWith(
                        color: _isButtonEnabled
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper widget to build consistent field titles.
  Widget _buildFieldLabel(String labelText) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        labelText,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.onboardingTextSecondary,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.w,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  /// Helper widget to build dark fields with customized borders.
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        style: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
        cursorColor: AppColors.onboardingCyan,
        decoration: InputDecoration(
          filled: false,
          fillColor: Colors.transparent,
          hintText: hintText,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.25),
            fontSize: 14.sp,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

/// Custom TextInputFormatter to space digits every 4 numbers for cards.
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\s+'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 &&
          nonZeroIndex != text.length &&
          nonZeroIndex < 16) {
        buffer.write(' ');
      }
    }
    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

/// Custom TextInputFormatter to format text to MM/YY.
class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    if (newText.length < oldValue.text.length) {
      return newValue;
    }

    final cleanDigits = newText.replaceAll(RegExp(r'\D'), '');
    if (cleanDigits.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String formatted = '';
    final firstDigit = int.tryParse(cleanDigits[0]) ?? 0;

    if (cleanDigits.length == 1) {
      if (firstDigit >= 2 && firstDigit <= 9) {
        formatted = '0$firstDigit/';
      } else {
        formatted = cleanDigits;
      }
    } else {
      var month = cleanDigits.substring(0, 2);
      final monthVal = int.tryParse(month) ?? 0;
      if (monthVal > 12) {
        month = '12';
      } else if (monthVal == 0) {
        month = '01';
      }
      formatted = '$month/';

      if (cleanDigits.length > 2) {
        var year = cleanDigits.substring(2);
        if (year.length > 2) {
          year = year.substring(0, 2);
        }
        formatted += year;
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
