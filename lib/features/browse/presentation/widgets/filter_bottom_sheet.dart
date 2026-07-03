import 'dart:async';

import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    required this.initialMakes,
    required this.initialCategories,
    required this.initialConditions,
    required this.initialMaxPrice,
    required this.onApply,
    required this.calculateResultsCount,
    super.key,
  });

  final List<String> initialMakes;
  final List<String> initialCategories;
  final List<String> initialConditions;
  final double initialMaxPrice;
  final void Function(
    List<String> makes,
    List<String> categories,
    List<String> conditions,
    double maxPrice,
  )
  onApply;
  final Future<int> Function(
    List<String> makes,
    List<String> categories,
    List<String> conditions,
    double maxPrice,
  )
  calculateResultsCount;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late List<String> _selectedMakes;
  late List<String> _selectedCategories;
  late List<String> _selectedConditions;
  late double _maxPrice;

  final List<String> _allMakes = [
    'All Makes',
    'Honda',
    'Ford',
    'Chevrolet',
    'Toyota',
    'BMW',
    'Nissan',
    'Subaru',
  ];

  final List<String> _allCategories = [
    'All Categories',
    'Engine',
    'Transmission',
    'Electrical',
    'Body',
    'Interior',
    'Cooling',
    'Suspension',
    'Brakes',
    'Exhaust',
  ];

  final List<String> _allConditions = [
    'All',
    'Excellent',
    'Good',
    'Fair',
    'Salvage',
  ];

  int _currentCount = 0;
  bool _isCalculating = false;

  @override
  void initState() {
    super.initState();
    _selectedMakes = List.from(widget.initialMakes);
    if (_selectedMakes.isEmpty) _selectedMakes.add('All Makes');

    _selectedCategories = List.from(widget.initialCategories);
    if (_selectedCategories.isEmpty) _selectedCategories.add('All Categories');

    _selectedConditions = List.from(widget.initialConditions);
    if (_selectedConditions.isEmpty) _selectedConditions.add('All');

    _maxPrice = widget.initialMaxPrice;
    unawaited(_updateCount());
  }

  Future<void> _updateCount() async {
    setState(() {
      _isCalculating = true;
    });
    final count = await widget.calculateResultsCount(
      _selectedMakes,
      _selectedCategories,
      _selectedConditions,
      _maxPrice,
    );
    if (mounted) {
      setState(() {
        _currentCount = count;
        _isCalculating = false;
      });
    }
  }

  void _resetAll() {
    setState(() {
      _selectedMakes = ['All Makes'];
      _selectedCategories = ['All Categories'];
      _selectedConditions = ['All'];
      _maxPrice = 2000.0;
    });
    unawaited(_updateCount());
  }

  void _toggleFilter(List<String> currentList, String option, String allLabel) {
    setState(() {
      if (option == allLabel) {
        currentList
          ..clear()
          ..add(allLabel);
      } else {
        currentList.remove(allLabel);
        if (currentList.remove(option)) {
          if (currentList.isEmpty) {
            currentList.add(allLabel);
          }
        } else {
          currentList.add(option);
        }
      }
    });
    unawaited(_updateCount());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onboardingBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(
          color: AppColors.colorWhite.withValues(alpha: 0.07),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Indicator
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.colorWhite.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorWhite,
                    ),
                  ),
                  GestureDetector(
                    onTap: _resetAll,
                    child: Text(
                      'Reset all',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColors.colorWhite.withValues(alpha: 0.07),
              height: 1,
            ),
            // Content (Scrollable)
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // MAKE
                    _buildSectionHeader('MAKE'),
                    SizedBox(height: 10.h),
                    _buildChipsWrap(_allMakes, _selectedMakes, 'All Makes'),
                    SizedBox(height: 24.h),

                    // CATEGORY
                    _buildSectionHeader('CATEGORY'),
                    SizedBox(height: 10.h),
                    _buildChipsWrap(
                      _allCategories,
                      _selectedCategories,
                      'All Categories',
                    ),
                    SizedBox(height: 24.h),

                    // CONDITION
                    _buildSectionHeader('CONDITION'),
                    SizedBox(height: 10.h),
                    _buildChipsWrap(_allConditions, _selectedConditions, 'All'),
                    SizedBox(height: 24.h),

                    // MAX PRICE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSectionHeader('MAX PRICE'),
                        Text(
                          '\$${_maxPrice.toStringAsFixed(0)}',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.info,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.info,
                        inactiveTrackColor: AppColors.colorWhite.withValues(
                          alpha: 0.1,
                        ),
                        thumbColor: AppColors.info,
                        overlayColor: AppColors.info.withValues(alpha: 0.2),
                        trackHeight: 4.h,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 8.r,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 16.r,
                        ),
                      ),
                      child: Slider(
                        value: _maxPrice,
                        min: 10,
                        max: 2000,
                        onChanged: (val) {
                          setState(() {
                            _maxPrice = val;
                          });
                        },
                        onChangeEnd: (val) {
                          unawaited(_updateCount());
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            r'$10',
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            r'$2,000',
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            // Sticky Bottom Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: GestureDetector(
                onTap: () {
                  widget.onApply(
                    _selectedMakes,
                    _selectedCategories,
                    _selectedConditions,
                    _maxPrice,
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  height: 52.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.info,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.info.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _isCalculating
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: const CircularProgressIndicator(
                            color: AppColors.colorWhite,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Show $_currentCount Results',
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.colorWhite,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildChipsWrap(
    List<String> options,
    List<String> selectedList,
    String allLabel,
  ) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: options.map((option) {
        final isSelected = selectedList.contains(option);
        return GestureDetector(
          onTap: () => _toggleFilter(selectedList, option, allLabel),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.info.withValues(alpha: 0.1)
                  : AppColors.onboardingSurface,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? AppColors.info : Colors.transparent,
              ),
            ),
            child: Text(
              option,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.info : AppColors.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
