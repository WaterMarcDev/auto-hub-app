import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/payment_methods/presentations/widgets/add_card_bottom_sheet.dart';
import 'package:auto_hub_app/features/payment_methods/presentations/widgets/looping_card_stack.dart';
import 'package:auto_hub_app/features/payment_methods/presentations/widgets/manage_cards_widget.dart';
import 'package:auto_hub_app/features/payment_methods/presentations/widgets/payment_card.dart';
import 'package:auto_hub_app/features/payment_methods/presentations/widgets/toast_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The responsive and adaptive Payment Methods Page (pure UI with local state).
class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  // Local list of cards pre-populated with mock data
  late List<PaymentCard> _cards;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
  }

  /// Simulates loading of payment methods
  void _loadPaymentMethods() {
    setState(() {
      _isLoading = true;
    });

    // Load initial mock cards
    _cards = [
      const PaymentCard(
        id: '1',
        cardHolder: 'MIKE JOHNSON',
        cardNumber: '4291',
        expiry: '08/27',
        cvc: '123',
        brand: 'Visa',
        isDefault: true,
      ),
      const PaymentCard(
        id: '2',
        cardHolder: 'MIKE JOHNSON',
        cardNumber: '7832',
        expiry: '03/28',
        cvc: '456',
        brand: 'Mastercard',
        isDefault: false,
      ),
    ];

    setState(() {
      _isLoading = false;
    });
  }

  /// Adds a new payment card
  void _addCard({
    required String cardHolder,
    required String cardNumber,
    required String expiry,
    required String cvc,
  }) {
    final cleanNumber = cardNumber.replaceAll(RegExp(r'\s+'), '');
    final detectedBrand = cleanNumber.startsWith('4')
        ? 'Visa'
        : (cleanNumber.startsWith('5') ? 'Mastercard' : 'Visa');

    final newCard = PaymentCard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cardHolder: cardHolder.toUpperCase(),
      cardNumber: cleanNumber,
      expiry: expiry,
      cvc: cvc,
      brand: detectedBrand,
      isDefault: _cards.isEmpty, // Make default if it is the first card
    );

    setState(() {
      _cards.add(newCard);
    });

    ToastNotification.show(context, 'Card Added Successfully!');
  }

  /// Removes a payment card
  void _removeCard(String cardId) {
    final cardToRemove = _cards.firstWhere((card) => card.id == cardId);
    
    setState(() {
      _cards.removeWhere((card) => card.id == cardId);

      // Promote another card to default if the default card was removed
      if (cardToRemove.isDefault && _cards.isNotEmpty) {
        final firstCard = _cards.first;
        _cards[0] = firstCard.copyWith(isDefault: true);
      }
    });

    ToastNotification.show(context, 'Card Removed Successfully!');
  }

  /// Sets a card as the default option
  void _setDefaultCard(String cardId) {
    setState(() {
      _cards = _cards.map((card) {
        return card.copyWith(isDefault: card.id == cardId);
      }).toList();
    });

    ToastNotification.show(context, 'Card set as default.');
  }

  void _showAddCardSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCardBottomSheet(
        onAddCard: ({
          required String cardHolder,
          required String cardNumber,
          required String expiry,
          required String cvc,
        }) {
          _addCard(
            cardHolder: cardHolder,
            cardNumber: cardNumber,
            expiry: expiry,
            cvc: cvc,
          );
        },
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
              // Header Row
              _buildHeader(context),
              SizedBox(height: 24.h),

              // Responsive Body Layout
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

  /// Builds the top app bar / header row containing the back button and title.
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColors.onboardingSurfaceLight,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
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
            child: SvgPicture.asset(
              AppIcons.arrowLeft,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          'Payment Methods',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }

  /// Builds a vertical scrollable column layout optimized for narrow mobile screens.
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Premium Looping Stacked Cards
                LoopingCardStack(
                  cards: _cards,
                  onCardChanged: (card) {},
                ),
                SizedBox(height: 24.h),

                // Manage Section
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
        // Sticky Add Payment Method button at the bottom of the page
        Padding(
          padding: EdgeInsets.only(bottom: 16.h, top: 8.h),
          child: _buildAddMethodButton(context),
        ),
      ],
    );
  }

  /// Builds a side-by-side multi-column layout optimized for wider tablet/landscape screens.
  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Premium Looping Stacked Cards
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

        // Right Column: Manage listing and Add Payment button
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

  /// Builds an empty state display if all cards are removed.
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
            Icons.credit_card_off_rounded,
            color: AppColors.onboardingTextSecondary,
            size: 36.w,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'No Payment Methods Saved',
          style: AppTextStyles.headlineSmall.copyWith(
            color: Colors.white,
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

  /// Custom outline Add Payment Method button.
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
              Icons.add_rounded,
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
