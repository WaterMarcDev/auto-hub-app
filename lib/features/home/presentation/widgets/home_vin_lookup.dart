import 'dart:async';

import 'package:auto_hub_app/core/constants/app_icons.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';

class HomeVinLookup extends StatelessWidget {
  const HomeVinLookup({super.key});

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
      child: const _HomeVinLookupBody(),
    );
  }
}

class _HomeVinLookupBody extends StatefulWidget {
  const _HomeVinLookupBody();

  @override
  State<_HomeVinLookupBody> createState() => _HomeVinLookupBodyState();
}

class _HomeVinLookupBodyState extends State<_HomeVinLookupBody> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

  String get _vin => _controller.text.toUpperCase();
  int get _charCount => _controller.text.length;
  bool get _isComplete => _charCount == 17;
  bool get _isValid => VinValidator.isValid(_vin);

  String? get _inlineError {
    if (_charCount == 0) return null;
    if (_charCount == 17) return VinValidator.validate(_vin);
    return null;
  }

  void _onFindParts(BuildContext context) {
    if (!_isValid) return;
    _focusNode.unfocus();
    context.read<VinCubit>().lookupVin(_vin);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VinCubit, VinState>(
      listener: (context, state) {
        if (state is VinLoaded) {
          unawaited(
            context.push('/vin-result', extra: state.result).then((_) {
              if (context.mounted) context.read<VinCubit>().reset();
            }),
          );
        } else if (state is VinError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xFF1C2330),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: const BorderSide(
                    color: Color(0x33FF6B6B),
                    width: 0.8,
                  ),
                ),
                margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
                content: Row(
                  children: [
                    const Icon(
                      AppIcons.errorOutlineRounded,
                      color: Color(0xFFFF6B6B),
                      size: 18,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        state.message,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: const Color(0xFFF0F6FC),
                        ),
                      ),
                    ),
                  ],
                ),
                duration: const Duration(seconds: 4),
              ),
            );
          context.read<VinCubit>().reset();
        }
      },
      builder: (context, state) {
        final isLoading = state is VinLoading;

        return _buildCard(context, isLoading: isLoading);
      },
    );
  }

  Widget _buildCard(BuildContext context, {required bool isLoading}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: const Color(0xFF0DA0CE).withValues(alpha: 0.2),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0DA0CE).withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment(-0.81, -1.0),
            end: Alignment(0.81, 1.0),
            colors: [Color(0xFF0A1220), Color(0xFF08101A)],
          ),
        ),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 28.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0DA0CE).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/ic_scan_line.svg',
                    width: 14.w,
                    height: 14.h,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF0DA0CE),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VIN Parts Lookup',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF0F6FC),
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Find exact-fit parts for your vehicle',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8B929A),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // ── VIN TextFormField ────────────────────────────────
            TextFormField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: !isLoading,
              textCapitalization: TextCapitalization.characters,
              keyboardType: TextInputType.text,
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
                hintText: 'Enter 17-digit VIN...',
                hintStyle: GoogleFonts.spaceMono(
                  fontSize: 13.sp,
                  color: const Color(0x80F0F6FC),
                  letterSpacing: 1.0,
                ),
                filled: true,
                fillColor: const Color(0xFF1C2330),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 13.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(
                    color: Color(0x14FFFFFF),
                    width: 0.8,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(
                    color: Color(0x14FFFFFF),
                    width: 0.8,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: const Color(0xFF0DA0CE).withValues(alpha: 0.5),
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(
                    color: Color(0x80FF6B6B),
                    width: 0.8,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF6B6B),
                    width: 1.0,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(
                    color: Color(0x0AFFFFFF),
                    width: 0.8,
                  ),
                ),
                errorText: _inlineError,
                errorStyle: GoogleFonts.inter(
                  fontSize: 10.sp,
                  color: const Color(0xFFFF6B6B),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            // ── Bottom row: char count + button ─────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$_charCount/17 characters',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: _isComplete
                        ? (_isValid
                              ? const Color(0xFF34D399)
                              : const Color(0xFFFF6B6B))
                        : AppColors.textTertiary,
                  ),
                ),
                _FindPartsButton(
                  isLoading: isLoading,
                  isEnabled: _isValid && !isLoading,
                  onTap: () => _onFindParts(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Find Parts button
// ─────────────────────────────────────────────────────────────────────────────

class _FindPartsButton extends StatelessWidget {
  const _FindPartsButton({
    required this.isLoading,
    required this.isEnabled,
    required this.onTap,
  });

  final bool isLoading;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (isEnabled || isLoading) {
      return GestureDetector(
        onTap: isLoading ? null : onTap,
        child: Container(
          height: 36.h,
          width: 110.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF0DA0CE), Color(0xFF0B8FB5)],
            ),
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0DA0CE).withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: isLoading
              ? Center(
                  child: SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/ic_search.svg',
                      width: 12.w,
                      height: 12.h,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Find Parts',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      );
    }

    // Disabled state
    return Opacity(
      opacity: 0.5,
      child: Container(
        height: 36.h,
        width: 110.w,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.06),
            width: 0.8,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/ic_search.svg',
              width: 12.w,
              height: 12.h,
              colorFilter: const ColorFilter.mode(
                AppColors.textTertiary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              'Find Parts',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Text formatter: forces all input to uppercase in real time
// ─────────────────────────────────────────────────────────────────────────────

class _UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}
