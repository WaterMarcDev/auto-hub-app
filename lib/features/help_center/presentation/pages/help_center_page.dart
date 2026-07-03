import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/help_center/models/help_article.dart';
import 'package:auto_hub_app/features/help_center/presentation/widgets/category_chip.dart';
import 'package:auto_hub_app/features/help_center/presentation/widgets/help_article_tile.dart';
import 'package:auto_hub_app/features/help_center/presentation/widgets/help_search_field.dart';
import 'package:auto_hub_app/features/help_center/presentation/widgets/quick_help_card.dart';
import 'package:auto_hub_app/features/help_center/presentation/widgets/submit_ticket_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String? _expandedArticleId;
  final Map<String, bool?> _feedbackStatus = {};

  final List<String> _categories = [
    'All',
    'Orders',
    'Parts',
    'Junking',
    'Payments',
  ];

  @override
  Widget build(BuildContext context) {
    // Filter articles based on query and category
    final filteredArticles = HelpArticle.defaultArticles.where((article) {
      final matchesCategory =
          _selectedCategory == 'All' ||
          article.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch =
          _searchQuery.isEmpty ||
          article.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          article.content.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    // Search Bar
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: HelpSearchField(
                        value: _searchQuery,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Categories Scroll
                    _buildCategoryChips(),
                    SizedBox(height: 16.h),
                    // Quick Action Cards
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: QuickHelpCard(
                              icon: AppIcons.chatBubble,
                              iconColor: AppColors.onboardingCyan,
                              iconBgColor: AppColors.onboardingCyan.withValues(
                                alpha: 0.1,
                              ),
                              title: 'Submit Ticket',
                              description: 'Get help from our team',
                              onTap: () {
                                _showSubmitTicketBottomSheet(context);
                              },
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: QuickHelpCard(
                              icon: AppIcons.menuBookOutlined,
                              iconColor: AppColors.onboardingPurple,
                              iconBgColor: AppColors.onboardingPurple
                                  .withValues(
                                    alpha: 0.1,
                                  ),
                              title: 'User Guide',
                              description: 'Learn how to use the app',
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                      backgroundColor:
                                          AppColors.onboardingSurfaceLight,
                                      content: Text(
                                        'User Guide is opening...',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Articles Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: _buildArticlesList(filteredArticles),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
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
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
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
              alignment: Alignment.center,
              child: Icon(
                AppIcons.chevronLeft,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Help Center',
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

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 42.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return CategoryChip(
            label: category,
            isSelected: _selectedCategory == category,
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildArticlesList(List<HelpArticle> articles) {
    if (articles.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 40.h),
        decoration: BoxDecoration(
          color: AppColors.onboardingSurface,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.07),
            width: 0.8,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              AppIcons.searchOffRounded,
              color: AppColors.onboardingTextSecondary,
              size: 48.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'No articles found',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onboardingTextSecondary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Try searching for something else.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onboardingTextSecondary.withValues(alpha: 0.7),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
          child: Text(
            '${articles.length} ${articles.length == 1 ? "ARTICLE" : "ARTICLES"} FOUND',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.onboardingSurface,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.07),
              width: 0.8,
            ),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: articles.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withValues(alpha: 0.05),
              height: 1.h,
            ),
            itemBuilder: (context, index) {
              final article = articles[index];
              return HelpArticleTile(
                article: article,
                isExpanded: _expandedArticleId == article.id,
                onToggle: () {
                  setState(() {
                    if (_expandedArticleId == article.id) {
                      _expandedArticleId = null;
                    } else {
                      _expandedArticleId = article.id;
                    }
                  });
                },
                wasHelpful: _feedbackStatus[article.id],
                onFeedback: (helpful) {
                  setState(() {
                    _feedbackStatus[article.id] = helpful;
                  });
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.onboardingSurfaceLight,
                        content: Text(
                          'Thank you for your feedback!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showSubmitTicketBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SubmitTicketBottomSheet(),
    ).then((result) {
      if (result != null && result is Map<String, String>) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: AppColors.onboardingSurfaceLight,
              content: Text(
                'Ticket submitted successfully! We\'ll get back to you soon.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
              duration: const Duration(seconds: 3),
            ),
          );
      }
    });
  }
}
