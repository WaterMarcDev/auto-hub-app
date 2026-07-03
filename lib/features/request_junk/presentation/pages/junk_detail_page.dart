import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/request_junk/models/junk_models.dart';
import 'package:auto_hub_app/features/request_junk/widgets/junk_overview_card.dart';
import 'package:auto_hub_app/features/request_junk/widgets/pickup_details_card.dart';
import 'package:auto_hub_app/features/request_junk/widgets/salvage_yard_card.dart';
import 'package:auto_hub_app/features/request_junk/widgets/vehicle_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Screen displaying the details of a specific junk request.
class JunkDetailPage extends StatelessWidget {
  /// Creates a [JunkDetailPage].
  const JunkDetailPage({
    required this.junkId,
    super.key,
  });

  /// The ID of the junk request to display.
  final String junkId;

  // Mock data matching MyRequestJunk list.
  static const List<JunkRequest> _requests = [
    JunkRequest(
      id: 'JNK-0412',
      status: JunkRequestStatus.pickupScheduled,
      vehicleTitle: '2009 Honda Accord – Silver',
      date: 'Mar 29, 2026',
      vin: '1HGCP26889A039821',
      condition: 'Non-running, minor body damage',
      notes: 'Keys available. Located in driveway.',
      salvageYardName: 'Houston Auto Salvage',
      salvageYardPhone: '+1 (713) 555-0182',
      offerAmount: 420,
      pickupDateTime: 'Apr 3, 2026 · 9:00 AM - 12:00 PM',
      towCompany: 'Houston Auto Salvage',
    ),
    JunkRequest(
      id: 'JNK-0401',
      status: JunkRequestStatus.offerPending,
      vehicleTitle: '2012 Nissan Altima – Black',
      date: 'Mar 31, 2026',
      vin: '1N4AL2AP5CC174829',
      condition: 'Running, 180K miles, transmission issues',
      notes: 'Title in hand. Parked on street.',
      salvageYardName: 'TX Auto Recyclers',
      salvageYardPhone: '+1 (713) 555-0344',
    ),
    JunkRequest(
      id: 'JNK-0389',
      status: JunkRequestStatus.completed,
      vehicleTitle: '2005 Toyota Camry – White',
      date: 'Feb 14, 2026',
      vin: '4T1BE30K85U638271',
      condition: 'Non-running, engine seized',
      notes: 'Picked up from parking lot.',
      salvageYardName: 'Gulf Coast Salvage',
      salvageYardPhone: '+1 (713) 555-0991',
      offerAmount: 350,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final request = _requests.firstWhere(
      (r) => r.id == junkId,
      orElse: () => _requests.first,
    );

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    JunkOverviewCard(request: request),
                    SizedBox(height: 16.h),
                    VehicleInfoCard(
                      condition: request.condition,
                      notes: request.notes,
                    ),
                    if (request.status == JunkRequestStatus.pickupScheduled &&
                        request.pickupDateTime != null) ...[
                      SizedBox(height: 16.h),
                      PickupDetailsCard(
                        pickupDateTime: request.pickupDateTime!,
                        towCompany: request.towCompany ?? '',
                      ),
                    ],
                    SizedBox(height: 16.h),
                    SalvageYardCard(
                      name: request.salvageYardName,
                      phone: request.salvageYardPhone,
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
            _buildBottomButtons(context, request),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.pop(),
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: AppColors.onboardingSurface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1.0,
                ),
              ),
              child: const Icon(
                AppIcons.chevronLeft,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Request Details',
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context, JunkRequest request) {
    if (request.status == JunkRequestStatus.completed ||
        request.status == JunkRequestStatus.cancelled) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: AppColors.onboardingBackground,
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            if (request.status == JunkRequestStatus.pickupScheduled) ...[
              Expanded(
                child: _buildActionButton(
                  icon: AppIcons.calendarToday,
                  label: 'Reschedule',
                  textColor: AppColors.onboardingCyan,
                  borderColor: AppColors.onboardingCyan.withValues(alpha: 0.3),
                  onTap: () => _showActionSnackbar(context, 'Reschedule'),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionButton(
                  icon: AppIcons.cancel,
                  label: 'Cancel',
                  textColor: AppColors.error,
                  borderColor: AppColors.error.withValues(alpha: 0.3),
                  onTap: () => _showActionSnackbar(context, 'Cancel'),
                ),
              ),
            ] else if (request.status == JunkRequestStatus.offerPending) ...[
              Expanded(
                child: _buildActionButton(
                  icon: AppIcons.cancel,
                  label: 'Cancel Request',
                  textColor: AppColors.error,
                  borderColor: AppColors.error.withValues(alpha: 0.3),
                  onTap: () => _showActionSnackbar(context, 'Cancel Request'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color textColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 18.r),
              SizedBox(width: 8.w),
              Text(
                label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showActionSnackbar(BuildContext context, String action) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$action action is coming soon!'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.onboardingSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
        ),
      );
  }
}
