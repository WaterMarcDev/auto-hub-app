import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/vin/data/datasources/vin_remote_datasource.dart';
import 'package:auto_hub_app/features/vin/data/repositories/vin_repository_impl.dart';
import 'package:auto_hub_app/features/vin/domain/usecases/decode_vin_usecase.dart';
import 'package:auto_hub_app/features/vin/domain/utils/vin_validator.dart';
import 'package:auto_hub_app/features/vin/presentation/cubit/vin_cubit.dart';
import 'package:auto_hub_app/features/vin/presentation/cubit/vin_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Step 1: Tell us about your vehicle.
class StepVehicleInfo extends StatefulWidget {
  /// Creates a [StepVehicleInfo] widget.
  const StepVehicleInfo({
    required this.yearController,
    required this.makeController,
    required this.modelController,
    required this.vinController,
    required this.onChanged,
    super.key,
  });

  /// Controller for the vehicle year input.
  final TextEditingController yearController;

  /// Controller for the vehicle make input.
  final TextEditingController makeController;

  /// Controller for the vehicle model input.
  final TextEditingController modelController;

  /// Controller for the vehicle VIN input.
  final TextEditingController vinController;

  /// Callback when any of the text fields change.
  final VoidCallback onChanged;

  @override
  State<StepVehicleInfo> createState() => _StepVehicleInfoState();
}

class _StepVehicleInfoState extends State<StepVehicleInfo> {
  final FocusNode _vinFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.vinController.addListener(_onVinChanged);
  }

  @override
  void dispose() {
    widget.vinController.removeListener(_onVinChanged);
    _vinFocusNode.dispose();
    super.dispose();
  }

  void _onVinChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VinCubit(
        DecodeVinUsecase(
          VinRepositoryImpl(
            VinRemoteDatasourceImpl(Dio()),
          ),
        ),
      ),
      child: BlocConsumer<VinCubit, VinState>(
        listener: (context, state) {
          if (state is VinLoaded) {
            widget.yearController.text = state.result.year;
            widget.makeController.text = state.result.make;
            widget.modelController.text = state.result.model;
            widget.onChanged();
          }
        },
        builder: (context, state) {
          final isLoading = state is VinLoading;
          final vinText = widget.vinController.text.toUpperCase();
          final isValidVin = VinValidator.isValid(vinText);

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tell us about your vehicle',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onboardingTextSecondary,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 24.h),

                // ── MANUAL DETAILS FORM (Year, Make, Model) ──────────────────
                _buildLabel('YEAR'),
                _buildTextField(
                  controller: widget.yearController,
                  hintText: 'e.g. 2010',
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  onChanged: (_) => widget.onChanged(),
                ),
                SizedBox(height: 20.h),

                _buildLabel('MAKE'),
                _buildTextField(
                  controller: widget.makeController,
                  hintText: 'e.g. Honda',
                  enabled: !isLoading,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (_) => widget.onChanged(),
                ),
                SizedBox(height: 20.h),

                _buildLabel('MODEL'),
                _buildTextField(
                  controller: widget.modelController,
                  hintText: 'e.g. Civic',
                  enabled: !isLoading,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (_) => widget.onChanged(),
                ),

                SizedBox(height: 24.h),

                // ── OR SEPARATOR ──────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white.withValues(alpha: 0.08),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'OR',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.onboardingTextSecondary.withValues(
                            alpha: 0.4,
                          ),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white.withValues(alpha: 0.08),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // ── VIN LOOKUP SECTION ────────────────────────────────────────
                _buildLabel('VIN (LOOKUP TO AUTO-FILL)'),
                _buildTextField(
                  controller: widget.vinController,
                  hintText: 'Enter 17-digit VIN number',
                  enabled: !isLoading,
                  focusNode: _vinFocusNode,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(17),
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[A-HJ-NPR-Za-hj-npr-z0-9]'),
                    ),
                  ],
                  onChanged: (val) {
                    widget.onChanged();
                    final vinText = val.toUpperCase();
                    if (vinText.length == 17) {
                      if (VinValidator.isValid(vinText)) {
                        _vinFocusNode.unfocus();
                        context.read<VinCubit>().lookupVin(vinText);
                      }
                    } else {
                      context.read<VinCubit>().reset();
                    }
                  },
                ),
                SizedBox(height: 12.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${vinText.length}/17 characters',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 11.sp,
                        color: vinText.length == 17
                            ? (isValidVin
                                  ? AppColors.onboardingGreen
                                  : AppColors.error)
                            : AppColors.onboardingTextSecondary,
                      ),
                    ),
                    if (isLoading)
                      Row(
                        children: [
                          SizedBox(
                            width: 14.w,
                            height: 14.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.onboardingCyan,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Decoding...',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.onboardingCyan,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),

                // ── DECODE STATUS RESULTS ────────────────────────────────────
                if (state is VinLoaded)
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.onboardingGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.onboardingGreen.withValues(
                            alpha: 0.3,
                          ),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            color: AppColors.onboardingGreen,
                            size: 20,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'VIN Decoded Successfully',
                                  style: AppTextStyles.titleMedium.copyWith(
                                    color: AppColors.onboardingTextPrimary,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  state.result.vehicleTitle,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.onboardingGreen,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (state is VinError)
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.error.withValues(alpha: 0.3),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            color: AppColors.error,
                            size: 20,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              state.message,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.onboardingTextPrimary,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                SizedBox(height: 24.h),
              ],
            ),
          );
        },
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
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    FocusNode? focusNode,
    bool enabled = true,
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
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        focusNode: focusNode,
        enabled: enabled,
        style: AppTextStyles.bodyMedium.copyWith(
          color: enabled
              ? AppColors.onboardingTextPrimary
              : AppColors.onboardingTextSecondary,
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(
              color: AppColors.onboardingCyan,
              width: 1.5,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.03),
            ),
          ),
          filled: false,
        ),
      ),
    );
  }
}
