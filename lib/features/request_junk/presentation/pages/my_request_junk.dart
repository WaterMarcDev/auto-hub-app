import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/request_junk/models/junk_models.dart';
import 'package:auto_hub_app/features/request_junk/widgets/empty_requests_state.dart';
import 'package:auto_hub_app/features/request_junk/widgets/filter_tabs.dart';
import 'package:auto_hub_app/features/request_junk/widgets/request_item_card.dart';
import 'package:auto_hub_app/features/request_junk/widgets/start_new_request_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Page displaying the user's junk requests.
class MyRequestJunk extends StatefulWidget {
  /// Creates the MyRequestJunk page.
  const MyRequestJunk({super.key});

  @override
  State<MyRequestJunk> createState() => _MyRequestJunkState();
}

class _MyRequestJunkState extends State<MyRequestJunk> {
  String _selectedTab = 'All';

  final List<JunkRequest> _allRequests = const [
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

  List<JunkRequest> get _filteredRequests {
    if (_selectedTab == 'All') {
      return _allRequests;
    } else if (_selectedTab == 'Active') {
      return _allRequests
          .where(
            (r) =>
                r.status == JunkRequestStatus.pickupScheduled ||
                r.status == JunkRequestStatus.offerPending,
          )
          .toList();
    } else if (_selectedTab == 'Completed') {
      return _allRequests
          .where((r) => r.status == JunkRequestStatus.completed)
          .toList();
    } else if (_selectedTab == 'Cancelled') {
      return _allRequests
          .where((r) => r.status == JunkRequestStatus.cancelled)
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final requests = _filteredRequests;

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(context),
            SizedBox(height: 16.h),
            FilterTabs(
              tabs: const ['All', 'Active', 'Completed', 'Cancelled'],
              selectedTab: _selectedTab,
              onTabSelected: (tab) {
                setState(() {
                  _selectedTab = tab;
                });
              },
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: Stack(
                children: [
                  if (requests.isEmpty)
                    const EmptyRequestsState()
                  else
                    _buildRequestsList(requests),
                  StartNewRequestButton(
                    onTap: () {
                      context.push('/new-junk-request');
                    },
                  ),
                ],
              ),
            ),
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
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: AppColors.onboardingSurface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.colorWhite.withValues(alpha: 0.08),
                  width: 1.0,
                ),
              ),
              child: const Icon(
                AppIcons.chevronLeft,
                color: AppColors.colorWhite,
                size: 24,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'My Junk Requests',
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

  Widget _buildRequestsList(List<JunkRequest> requests) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
            child: Text(
              '${requests.length} ${requests.length == 1 ? 'REQUEST' : 'REQUESTS'}',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onboardingTextSecondary,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.onboardingSurface,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: AppColors.colorWhite.withValues(alpha: 0.06),
                width: 1.0,
              ),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: requests.length,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.colorWhite.withValues(alpha: 0.06),
                height: 1.h,
              ),
              itemBuilder: (context, index) {
                final request = requests[index];
                return RequestItemCard(
                  request: request,
                  onTap: () {
                    context.push('/my-request-junk/junk?junk=${request.id}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}