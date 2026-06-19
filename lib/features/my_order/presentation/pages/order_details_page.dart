import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/my_order/data/orders_repository.dart';
import 'package:auto_hub_app/features/my_order/domain/models/order_model.dart';
import 'package:auto_hub_app/features/my_order/presentation/widgets/address_card.dart';
import 'package:auto_hub_app/features/my_order/presentation/widgets/status_badge.dart';
import 'package:auto_hub_app/features/my_order/presentation/widgets/timeline_view.dart';
import 'package:auto_hub_app/features/my_order/presentation/widgets/tracking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({required this.orderId, super.key});

  final String orderId;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late Order _order;

  @override
  void initState() {
    super.initState();
    _loadOrder();
  }

  void _loadOrder() {
    final found = OrdersRepository.instance.getOrderById(widget.orderId);
    if (found != null) {
      _order = found;
    }
  }

  Future<void> _showCancelDialog() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: AppColors.onboardingSurfaceLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
            side: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
              width: 0.8,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.15),
                      width: 0.8,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 28.sp,
                    color: AppColors.error,
                  ),
                ),
                SizedBox(height: 18.h),
                Text(
                  'Cancel Order?',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onboardingTextPrimary,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'This action cannot be undone. If payment was already '
                  'processed, a refund will be initiated within 3-5 '
                  'business days.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onboardingTextSecondary,
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: Navigator.of(dialogContext).pop,
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColors.onboardingBackground,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.05),
                              width: 0.8,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColors.onboardingTextPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          OrdersRepository.instance.cancelOrder(_order.id);
                          Navigator.of(dialogContext).pop();
                          setState(_loadOrder);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Order cancel request submitted',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: AppColors.error,
                              ),
                            );
                        },
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.error
                                    .withValues(alpha: 0.3),
                                blurRadius: 16,
                                offset: Offset(0, 4.h),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel Order',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 8.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMainCard(),
                    SizedBox(height: 16.h),
                    if (_order.trackingNumber != null &&
                        _order.status != OrderStatus.cancelled) ...[
                      TrackingCard(trackingNumber: _order.trackingNumber!),
                      SizedBox(height: 16.h),
                    ],
                    AddressCard(address: _order.address),
                    SizedBox(height: 24.h),
                    TimelineView(
                      events: _order.timeline,
                      status: _order.status,
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Order Details',
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: AppColors.onboardingSurface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.07),
                  width: 0.8,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.close_rounded,
                size: 18.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCard() {
    String? estDeliveryDate;
    if (_order.status == OrderStatus.inTransit) {
      estDeliveryDate = 'Est. Apr 2, 2026';
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onboardingSurfaceLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusBadge(status: _order.status),
              if (estDeliveryDate != null)
                Text(
                  estDeliveryDate,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onboardingTextSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            _order.title,
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '${_order.id} · \$${_order.price.toStringAsFixed(2)}',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    if (_order.status == OrderStatus.delivered) {
      return Container(
        height: 76.h + bottomInset,
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h + bottomInset),
        decoration: BoxDecoration(
          color: AppColors.onboardingBackground,
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.05),
              width: 0.8,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          'Reordering ${_order.title}...',
                          style: GoogleFonts.inter(color: Colors.white),
                        ),
                        backgroundColor: AppColors.onboardingCyan,
                      ),
                    );
                },
                child: Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.onboardingCyan,
                        AppColors.onboardingCyanDark,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.onboardingCyan
                            .withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Reorder',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          'Rating feature coming soon!',
                          style: GoogleFonts.inter(color: Colors.white),
                        ),
                        backgroundColor: AppColors.warning,
                      ),
                    );
                },
                child: Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: AppColors.onboardingSurface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.warning
                          .withValues(alpha: 0.3),
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_outline_rounded,
                        size: 16.sp,
                        color: AppColors.warning,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Rate',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.warning,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (_order.status == OrderStatus.inTransit) {
      return Container(
        height: 76.h + bottomInset,
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h + bottomInset),
        decoration: BoxDecoration(
          color: AppColors.onboardingBackground,
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.05),
              width: 0.8,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    'Opening tracking page for ${_order.id}...',
                    style: GoogleFonts.inter(color: Colors.white),
                  ),
                  backgroundColor: AppColors.onboardingCyan,
                ),
              );
          },
          child: Container(
            width: double.infinity,
            height: 52.h,
            decoration: BoxDecoration(
              color: AppColors.onboardingSurfaceLight,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.onboardingCyan.withValues(alpha: 0.3),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.visibility_outlined,
                  size: 16.sp,
                  color: AppColors.onboardingCyan,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Track Package',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.onboardingCyan,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (_order.status == OrderStatus.processing) {
      return Container(
        height: 76.h + bottomInset,
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h + bottomInset),
        decoration: BoxDecoration(
          color: AppColors.onboardingBackground,
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.05),
              width: 0.8,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () async {
            await _showCancelDialog();
          },
          child: Container(
            width: double.infinity,
            height: 52.h,
            decoration: BoxDecoration(
              color: AppColors.onboardingErrorSurface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.error.withValues(alpha: 0.2),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cancel_outlined,
                  size: 16.sp,
                  color: AppColors.error,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Cancel Order',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.error,
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

    return const SizedBox.shrink();
  }
}
