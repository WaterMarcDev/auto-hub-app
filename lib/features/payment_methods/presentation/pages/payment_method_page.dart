import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/payment_methods/data/repositories/payment_methods_repository_impl.dart';
import 'package:auto_hub_app/features/payment_methods/domain/entities/payment_card.dart';
import 'package:auto_hub_app/features/payment_methods/domain/repositories/payment_methods_repository.dart';
import 'package:auto_hub_app/features/payment_methods/presentation/widgets/add_card_bottom_sheet.dart';
import 'package:auto_hub_app/features/payment_methods/presentation/widgets/looping_card_stack.dart';
import 'package:auto_hub_app/features/payment_methods/presentation/widgets/manage_cards_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// The responsive and adaptive Payment Methods Page.
class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  // In a real app, this repository would be injected via dependency injection (e.g. GetIt, Provider, Riverpod).
  late final PaymentMethodsRepository _repository;
  
  List<PaymentCard> _cards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _repository = PaymentMethodsRepositoryImpl();
    _loadPaymentMethods();
  }

  Future<void> _loadPaymentMethods() async {
    setState(() => _isLoading = true);
    try {
      final cards = await _repository.getPaymentMethods();
      if (mounted) {
        setState(() {
          _cards = cards;
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _addCard({
    required String cardHolder,
    required String cardNumber,
    required String expiry,
    required String cvc,
  }) async {
    setState(() => _isLoading = true);
    try {
      await _repository.addPaymentMethod(
        cardHolder: cardHolder,
        cardNumber: cardNumber,
        expiry: expiry,
        cvc: cvc,
      );
      await _loadPaymentMethods();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Card Added Successfully!')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _removeCard(String cardId) async {
    setState(() => _isLoading = true);
    try {
      await _repository.removePaymentMethod(cardId);
      await _loadPaymentMethods();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Card Removed Successfully!')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _setDefaultCard(String cardId) async {
    setState(() => _isLoading = true);
    try {
      await _repository.setDefaultPaymentMethod(cardId);
      await _loadPaymentMethods();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Card set as default.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showAddCardSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCardBottomSheet(
        onAddCard: _addCard,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.h),
              _buildHeader(context),
              SizedBox(height: 24.h),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isTablet = constraints.maxWidth >= 600;

                    if (_isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.onboardingCyan,
                        ),
                      );
                    }

                    if (_cards.isEmpty) {
                      return _buildEmptyState(context);
                    }

                    if (isTablet) {
                      return _buildTabletLayout(context);
                    }

                    return _buildMobileLayout(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (context.canPop()) {
              context.pop();
            }
          },
          child: Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColors.onboardingSurfaceLight,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.colorWhite.withValues(alpha: 0.08),
                width: 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 4.r,
                  offset: Offset(0, 1.h),
                ),
              ],
            ),
            padding: EdgeInsets.all(10.w),
            child: const Icon(
              AppIcons.arrowLeft
            )
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          'Payment Methods',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.colorWhite,
            fontWeight: FontWeight.w800,
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoopingCardStack(
                  cards: _cards,
                  onCardChanged: (card) {},
                ),
                SizedBox(height: 24.h),
                ManageCardsWidget(
                  cards: _cards,
                  onRemove: _removeCard,
                  onSetDefault: _setDefaultCard,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16.h, top: 8.h),
          child: _buildAddMethodButton(context),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 11,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(right: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'SAVED CARDS',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.onboardingTextSecondary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5.w,
                  ),
                ),
                SizedBox(height: 24.h),
                LoopingCardStack(
                  cards: _cards,
                  onCardChanged: (card) {},
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          flex: 13,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ManageCardsWidget(
                  cards: _cards,
                  onRemove: _removeCard,
                  onSetDefault: _setDefaultCard,
                ),
                SizedBox(height: 24.h),
                _buildAddMethodButton(context),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: AppColors.onboardingSurfaceLight,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            AppIcons.creditCardOffRounded,
            color: AppColors.onboardingTextSecondary,
            size: 36.w,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'No Payment Methods Saved',
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.colorWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Add a credit/debit card to simplify your purchases.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onboardingTextSecondary,
          ),
        ),
        SizedBox(height: 32.h),
        _buildAddMethodButton(context),
      ],
    );
  }

  Widget _buildAddMethodButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAddCardSheet(context),
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color: AppColors.onboardingSurface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.onboardingCyan.withValues(alpha: 0.35),
            width: 1.5.w,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.addRounded,
              color: AppColors.onboardingCyan,
              size: 20.w,
            ),
            SizedBox(width: 8.w),
            Text(
              'Add Payment Method',
              style: AppTextStyles.button.copyWith(
                color: AppColors.onboardingCyan,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
