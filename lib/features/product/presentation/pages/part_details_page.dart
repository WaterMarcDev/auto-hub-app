import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PartDetailsPage extends StatefulWidget {
  const PartDetailsPage({super.key});

  @override
  State<PartDetailsPage> createState() => _PartDetailsPageState();
}

class _PartDetailsPageState extends State<PartDetailsPage> {
  int _currentTabIndex = 0;

  static const List<_DetailsRowData> _specRows = [
    _DetailsRowData(
      icon: AppIcons.confirmationNumber,
      label: 'Part Number',
      value: 'ALT-8912-HON',
    ),
    _DetailsRowData(
      icon: AppIcons.category,
      label: 'Category',
      value: 'Electrical',
    ),
    _DetailsRowData(
      icon: AppIcons.directionsCar,
      label: 'Compatible Make',
      value: 'Honda',
    ),
    _DetailsRowData(
      icon: AppIcons.precisionManufacturing,
      label: 'Compatible Model',
      value: 'Civic',
    ),
    _DetailsRowData(
      icon: AppIcons.calendarMonth,
      label: 'Year Range',
      value: '2016-2021',
    ),
    _DetailsRowData(
      icon: AppIcons.speed,
      label: 'Donor Mileage',
      value: '48,000 mi',
    ),
    _DetailsRowData(
      icon: AppIcons.scale,
      label: 'Weight',
      value: '4.2 kg',
    ),
    _DetailsRowData(
      icon: AppIcons.verifiedUser,
      label: 'Warranty',
      value: '90 Days',
    ),
  ];

  static const List<_DetailsRowData> _yardRows = [
    _DetailsRowData(
      icon: AppIcons.warehouse,
      label: 'Yard Name',
      value: 'Houston Auto Recyclers',
    ),
    _DetailsRowData(
      icon: AppIcons.starBorder,
      label: 'Yard Rating',
      value: '4.8 (94)',
    ),
    _DetailsRowData(
      icon: AppIcons.locationOn,
      label: 'Address',
      value: 'Houston, TX',
    ),
    _DetailsRowData(
      icon: AppIcons.call,
      label: 'Contact',
      value: '(832) 555-0142',
    ),
    _DetailsRowData(
      icon: AppIcons.schedule,

      label: 'Business Hours',
      value: 'Mon-Sat 8AM-6PM',
    ),
    _DetailsRowData(
      icon: AppIcons.localShipping,
      label: 'Pickup',
      value: 'Available',
    ),
    _DetailsRowData(
      icon: AppIcons.deliveryDining,
      label: 'Delivery',
      value: 'Nationwide',
    ),
    _DetailsRowData(
      icon: AppIcons.verified,
      label: 'Verified Seller',
      value: 'Yes',
    ),
  ];

  void _switchTab(int index) {
    if (_currentTabIndex == index) {
      return;
    }
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.onboardingBackground,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(context),
                Transform.translate(
                  offset: Offset(0, -32.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleBlock(),
                        SizedBox(height: 19.h),
                        _buildQuickFactsCard(),
                        SizedBox(height: 21.h),
                        _buildFitsCard(),
                        SizedBox(height: 19.h),
                        _DetailsToggleTab(
                          currentIndex: _currentTabIndex,
                          onSpecificationsTap: () => _switchTab(0),
                          onYardInfoTap: () => _switchTab(1),
                        ),
                        SizedBox(height: 16.h),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: _currentTabIndex == 0
                                ? const _DetailsCard(
                                    key: ValueKey<String>(
                                      'specifications',
                                    ),
                                    rows: _specRows,
                                  )
                                : const _DetailsCard(
                                    key: ValueKey<String>('yard-info'),
                                    rows: _yardRows,
                                  ),
                          ),
                        ),
                        SizedBox(height: 19.h),
                        _buildDescriptionCard(),
                        SizedBox(height: 20.h),
                        _buildSimilarPartsSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/home_part_engine.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.colorBlack.withValues(alpha: 0.35),
                  Colors.transparent,
                  AppColors.onboardingBackground,
                ],
                stops: [0, 0.4, 1],
              ),
            ),
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            top: 12.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HeroActionButton(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/');
                    }
                  },
                  child: const Icon(AppIcons.arrowLeft),
                ),
                Row(
                  children: [
                    _HeroActionButton(
                      onTap: () {},
                      child: Icon(
                        AppIcons.share,

                        size: 16.sp,
                        color: AppColors.colorWhite,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    _HeroActionButton(
                      onTap: () {},
                      child: const Icon(
                        AppIcons.heart,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 16.w,
            top: 220.h,
            child: Container(
              width: 72.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: AppColors.onboardingCyan.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.onboardingCyan.withValues(alpha: 0.3),
                  width: 0.8,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Featured',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onboardingCyan,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OEM Alternator',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: AppColors.onboardingTextPrimary,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  _MetaLine(
                    iconPath: AppIcons.mapPin,
                    text: 'Houston, TX',
                    textStyle: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onboardingTextSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  _MetaLine(
                    iconPath: AppIcons.tag,
                    text: 'ALT-8912-HON',
                    textStyle: GoogleFonts.cousine(
                      color: AppColors.textTertiary,
                      fontSize: 11.sp,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              width: 70.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: AppColors.onboardingGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: AppColors.onboardingGreen.withValues(alpha: 0.14),
                  width: 0.8,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Excellent',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onboardingGreen,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r'$185',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.onboardingTextPrimary,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                    height: 1,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Warranty: 90 Days',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                    fontSize: 11.sp,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            Container(
              width: 110.w,
              height: 42.h,
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.warning.withValues(alpha: 0.15),
                  width: 0.8,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Row(
                children: [
                  const Icon(
                    AppIcons.star,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '4.8',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.warning,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '(94)',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickFactsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.colorWhite.withValues(alpha: 0.07),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.8.w, vertical: 16.8.h),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuickFactItem(
            icon: AppIcons.electricalServices,
            value: 'Electrical',
            label: 'Category',
          ),
          _QuickFactItem(
            icon: AppIcons.calendarToday,
            value: '2016-2021',
            label: 'Years',
          ),
          _QuickFactItem(
            icon: AppIcons.shield,
            value: '90 Days',
            label: 'Warranty',
          ),
        ],
      ),
    );
  }

  Widget _buildFitsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onboardingCyan.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.onboardingCyan.withValues(alpha: 0.15),
          width: 0.8,
        ),
      ),
      padding: EdgeInsets.fromLTRB(16.8.w, 13.h, 12.w, 13.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            AppIcons.directionsCar,
            size: 16.sp,
            color: AppColors.onboardingCyan,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fits: Honda Civic',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.onboardingTextPrimary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Model years 2016-2021 · Donor mileage: 48,000 mi',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onboardingTextSecondary,
                    fontSize: 11.sp,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Container(
      width: double.infinity,
      height: 162.h,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.colorWhite.withValues(alpha: 0.07),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 9.h),
          Text(
            'OEM alternator pulled from a 2019 Honda Civic with only 48K miles '
            'on the donor vehicle. Tested and confirmed working at charging '
            'specification.',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 13.sp,
              height: 1.8,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Read more',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.onboardingCyan,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 2.w),
              const Icon(
                AppIcons.chevronRight,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarPartsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Similar Parts',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.onboardingTextPrimary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                Text(
                  'See all',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.onboardingCyan,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 2.w),
                const Icon(
                  AppIcons.arrowUpRight,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          width: 174.w,
          decoration: BoxDecoration(
            color: AppColors.onboardingSurfaceLight,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.colorWhite.withValues(alpha: 0.07),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 12.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 172.w,
                height: 100.h,
                child: Image.asset(
                  'assets/images/home_part_headlight.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LED Headlight Assembly - Left',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.onboardingTextPrimary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Toyota Camry',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                        fontSize: 10.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      r'$275',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.onboardingCyan,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}

class _HeroActionButton extends StatelessWidget {
  const _HeroActionButton({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.onboardingBackground.withValues(alpha: 0.7),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.colorWhite.withValues(alpha: 0.1),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({
    required this.iconPath,
    required this.text,
    required this.textStyle,
  });

  final IconData iconPath;
  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconPath,
        ),
        SizedBox(width: 6.w),
        Text(text, style: textStyle),
      ],
    );
  }
}

class _QuickFactItem extends StatelessWidget {
  const _QuickFactItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88.w,
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.onboardingCyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 16.sp,
              color: AppColors.onboardingCyan,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textTertiary,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsToggleTab extends StatelessWidget {
  const _DetailsToggleTab({
    required this.currentIndex,
    required this.onSpecificationsTap,
    required this.onYardInfoTap,
  });

  final int currentIndex;
  final VoidCallback onSpecificationsTap;
  final VoidCallback onYardInfoTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / 2;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: currentIndex == 0 ? 0 : tabWidth,
                width: tabWidth,
                height: constraints.maxHeight,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.onboardingCyan,
                        AppColors.onboardingCyanDark,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.onboardingCyan.withValues(alpha: 0.35),
                        blurRadius: 8.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onSpecificationsTap,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: AppTextStyles.labelLarge.copyWith(
                            color: currentIndex == 0
                                ? AppColors.colorWhite
                                : AppColors.textTertiary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          child: const Text('Specifications'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onYardInfoTap,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: AppTextStyles.labelLarge.copyWith(
                            color: currentIndex == 1
                                ? AppColors.colorWhite
                                : AppColors.textTertiary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          child: const Text('Yard Info'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.rows, super.key});

  final List<_DetailsRowData> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.colorWhite.withValues(alpha: 0.07),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++)
            _DetailsInfoRow(
              row: rows[index],
              showDivider: index != rows.length - 1,
            ),
        ],
      ),
    );
  }
}

class _DetailsInfoRow extends StatelessWidget {
  const _DetailsInfoRow({required this.row, required this.showDivider});

  final _DetailsRowData row;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: AppColors.colorWhite.withValues(alpha: 0.05),
                  width: 0.8,
                ),
              )
            : null,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.onboardingSurface,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                alignment: Alignment.center,
                child: Icon(
                  row.icon,
                  size: 13.sp,
                  color: AppColors.iconSlate,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                row.label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onboardingTextSecondary,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          Flexible(
            child: Text(
              row.value,
              textAlign: TextAlign.right,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.onboardingTextPrimary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsRowData {
  const _DetailsRowData({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}
