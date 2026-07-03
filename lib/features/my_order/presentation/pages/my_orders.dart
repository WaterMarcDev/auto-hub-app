import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/my_order/data/orders_repository.dart';
import 'package:auto_hub_app/features/my_order/domain/models/order_model.dart';
import 'package:auto_hub_app/features/my_order/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

enum OrderTab { all, active, completed, cancelled }

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  OrderTab _selectedTab = OrderTab.all;

  bool _isOrderInTab(Order order, OrderTab tab) {
    switch (tab) {
      case OrderTab.all:
        return true;
      case OrderTab.active:
        return order.status == OrderStatus.inTransit ||
            order.status == OrderStatus.processing;
      case OrderTab.completed:
        return order.status == OrderStatus.delivered;
      case OrderTab.cancelled:
        return order.status == OrderStatus.cancelled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: ValueListenableBuilder<List<Order>>(
          valueListenable: OrdersRepository.instance.ordersNotifier,
          builder: (context, ordersList, _) {
            final filteredOrders = ordersList
                .where((order) => _isOrderInTab(order, _selectedTab))
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 18.h),
                _buildTabs(),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    '${filteredOrders.length} '
                    '${filteredOrders.length == 1 ? 'ORDER' : 'ORDERS'}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onboardingTextMuted,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: filteredOrders.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                          itemCount: filteredOrders.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 14.h),
                          itemBuilder: (context, index) {
                            final order = filteredOrders[index];
                            return OrderCard(
                              order: order,
                              onTap: () async {
                                await context.push(
                                  '/order-details',
                                  extra: order.id,
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.onboardingSurfaceLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.colorWhite.withValues(alpha: 0.07),
                  width: 0.8,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.chevron_left_rounded,
                size: 22.sp,
                color: AppColors.colorWhite,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Text(
            'My Orders',
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

  Widget _buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: OrderTab.values.map((tab) {
          final isSelected = _selectedTab == tab;
          String label;
          switch (tab) {
            case OrderTab.all:
              label = 'All';
            case OrderTab.active:
              label = 'Active';
            case OrderTab.completed:
              label = 'Completed';
            case OrderTab.cancelled:
              label = 'Cancelled';
          }

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = tab;
                });
              },
              child: Container(
                height: 38.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.onboardingBackground
                      : AppColors.onboardingSurfaceLight,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.onboardingCyan
                        : AppColors.colorWhite.withValues(alpha: 0.05),
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.onboardingCyan
                        : AppColors.onboardingTextSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.onboardingSurface,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.colorWhite.withValues(alpha: 0.05),
                width: 0.8,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.inventory_2_outlined,
              size: 32.sp,
              color: AppColors.onboardingTextSecondary,
            ),
          ),
          SizedBox(height: 18.h),
          Text(
            'No orders found',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.onboardingTextPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'You do not have any orders in this section',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: AppColors.onboardingTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
