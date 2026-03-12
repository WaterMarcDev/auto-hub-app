import 'package:auto_hub_app/features/vin/domain/entities/vin_decode_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class VinResultPage extends StatelessWidget {
  const VinResultPage({required this.result, super.key});

  final VinDecodeResult result;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        body: SafeArea(
          child: Column(
            children: [
              _AppBar(vin: result.vin),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DecodedBadge(result: result),
                      SizedBox(height: 16.h),
                      _VehicleCard(result: result),
                      SizedBox(height: 12.h),
                      _EngineCard(result: result),
                      SizedBox(height: 12.h),
                      _DrivetrainCard(result: result),
                      SizedBox(height: 12.h),
                      _OriginCard(result: result),
                      SizedBox(height: 24.h),
                      _CtaButton(result: result),
                    ],
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

// ─────────────────────────────────────────────────────────────────────────────
// App Bar
// ─────────────────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  const _AppBar({required this.vin});

  final String vin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: const BoxDecoration(
        color: Color(0xFF0D1117),
        border: Border(
          bottom: BorderSide(color: Color(0x12FFFFFF), width: 0.8),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: const Color(0xFF161B22),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0x14FFFFFF),
                  width: 0.8,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF8B929A),
                size: 16,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VIN Decoded',
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFF0F6FC),
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  vin,
                  style: GoogleFonts.spaceMono(
                    fontSize: 9.sp,
                    color: const Color(0xFF484F58),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          // Success badge chip
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: const Color(0xFF34D399).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color(0xFF34D399).withValues(alpha: 0.3),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6.w,
                  height: 6.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34D399),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  'Decoded',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF34D399),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Decoded Badge / Vehicle Title Hero
// ─────────────────────────────────────────────────────────────────────────────

class _DecodedBadge extends StatelessWidget {
  const _DecodedBadge({required this.result});

  final VinDecodeResult result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F1A28), Color(0xFF0A1220)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFF0DA0CE).withValues(alpha: 0.2),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Year badge + make
          Row(
            children: [
              if (result.year.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0DA0CE).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    result.year,
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0DA0CE),
                    ),
                  ),
                ),
              if (result.year.isNotEmpty) SizedBox(width: 8.w),
              if (result.make.isNotEmpty)
                Text(
                  result.make,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF8B929A),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          // Model (big)
          Text(
            result.model.isNotEmpty ? result.model : 'Unknown Model',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFF0F6FC),
              letterSpacing: -0.5,
            ),
          ),
          if (result.trim.isNotEmpty || result.series.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              [
                result.trim,
                result.series,
              ].where((s) => s.isNotEmpty).join(' · '),
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8B929A),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared card widget
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.iconPath,
    required this.iconColor,
    required this.title,
    required this.rows,
  });

  final String iconPath;
  final Color iconColor;
  final String title;
  final List<_DataRow> rows;

  @override
  Widget build(BuildContext context) {
    final visibleRows = rows.where((r) => r.value.isNotEmpty).toList();
    if (visibleRows.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0x14FFFFFF),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
            child: Row(
              children: [
                Container(
                  width: 26.w,
                  height: 26.h,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    iconPath,
                    width: 14.w,
                    height: 14.h,
                    colorFilter: ColorFilter.mode(
                      iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFF0F6FC),
                    letterSpacing: -0.1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          // Divider
          Container(
            height: 0.8,
            color: const Color(0x0FFFFFFF),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          // Data rows
          ...visibleRows.asMap().entries.map((entry) {
            final isLast = entry.key == visibleRows.length - 1;
            return _buildRow(entry.value, isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildRow(_DataRow row, bool isLast) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
      decoration: isLast
          ? null
          : const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0x08FFFFFF), width: 0.8),
              ),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            row.label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8B929A),
            ),
          ),
          Flexible(
            child: Text(
              row.value,
              textAlign: TextAlign.end,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF0F6FC),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataRow {
  const _DataRow(this.label, this.value);

  final String label;
  final String value;
}

// ─────────────────────────────────────────────────────────────────────────────
// Section cards
// ─────────────────────────────────────────────────────────────────────────────

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({required this.result});

  final VinDecodeResult result;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      iconPath: 'assets/icons/ic_wrench.svg',
      iconColor: const Color(0xFF0DA0CE),
      title: 'Vehicle Overview',
      rows: [
        _DataRow('Year', result.year),
        _DataRow('Make', result.make),
        _DataRow('Model', result.model),
        if (result.trim.isNotEmpty) _DataRow('Trim', result.trim),
        if (result.series.isNotEmpty) _DataRow('Series', result.series),
        _DataRow('Body Style', result.bodyClass),
        if (result.doors.isNotEmpty) _DataRow('Doors', result.doors),
      ],
    );
  }
}

class _EngineCard extends StatelessWidget {
  const _EngineCard({required this.result});

  final VinDecodeResult result;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      iconPath: 'assets/icons/ic_sparkles.svg',
      iconColor: const Color(0xFFFBBF24),
      title: 'Engine',
      rows: [
        _DataRow(
          'Horsepower',
          result.engineHp.isNotEmpty ? '${result.engineHp} HP' : '',
        ),
        _DataRow('Cylinders', result.engineCylinders),
        _DataRow('Displacement', result.displacementL),
        _DataRow('Fuel Type', result.fuelType),
      ],
    );
  }
}

class _DrivetrainCard extends StatelessWidget {
  const _DrivetrainCard({required this.result});

  final VinDecodeResult result;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      iconPath: 'assets/icons/ic_tag.svg',
      iconColor: const Color(0xFFA78BFA),
      title: 'Drivetrain',
      rows: [
        _DataRow('Drive Type', result.driveType),
        _DataRow('Transmission', result.transmissionStyle),
      ],
    );
  }
}

class _OriginCard extends StatelessWidget {
  const _OriginCard({required this.result});

  final VinDecodeResult result;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      iconPath: 'assets/icons/ic_map_pin.svg',
      iconColor: const Color(0xFF34D399),
      title: 'Manufacture Origin',
      rows: [
        _DataRow('Manufacturer', result.manufacturerName),
        _DataRow('Country', result.plantCountry),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CTA Button
// ─────────────────────────────────────────────────────────────────────────────

class _CtaButton extends StatelessWidget {
  const _CtaButton({required this.result});

  final VinDecodeResult result;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: navigate to parts search filtered by this vehicle
      },
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF0DA0CE), Color(0xFF0B8FB5)],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0DA0CE).withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Browse Matching Parts',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(width: 8.w),
            SvgPicture.asset(
              'assets/icons/ic_arrow_up_right.svg',
              width: 16.w,
              height: 16.h,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
