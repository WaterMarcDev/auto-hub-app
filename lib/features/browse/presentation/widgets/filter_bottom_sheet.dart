import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required this.initialMakes,
    required this.initialCategories,
    required this.initialConditions,
    required this.initialMaxPrice,
    required this.onApply,
    required this.calculateResultsCount,
  });

  final List<String> initialMakes;
  final List<String> initialCategories;
  final List<String> initialConditions;
  final double initialMaxPrice;
  final Function(List<String> makes, List<String> categories, List<String> conditions, double maxPrice) onApply;
  final int Function(List<String> makes, List<String> categories, List<String> conditions, double maxPrice) calculateResultsCount;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late List<String> _selectedMakes;
  late List<String> _selectedCategories;
  late List<String> _selectedConditions;
  late double _maxPrice;

  final List<String> _allMakes = [
    'All Makes', 'Honda', 'Ford', 'Chevrolet', 'Toyota', 'BMW', 'Nissan', 'Subaru'
  ];

  final List<String> _allCategories = [
    'All Categories', 'Engine', 'Transmission', 'Electrical', 'Body',
    'Interior', 'Cooling', 'Suspension', 'Brakes', 'Exhaust'
  ];

  final List<String> _allConditions = [
    'All', 'Excellent', 'Good', 'Fair', 'Salvage'
  ];

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
  }

  void _resetAll() {
    setState(() {
      _selectedMakes = ['All Makes'];
      _selectedCategories = ['All Categories'];
      _selectedConditions = ['All'];
      _maxPrice = 2000.0;
    });
  }

  void _toggleFilter(List<String> currentList, String option, String allLabel) {
    setState(() {
      if (option == allLabel) {
        currentList.clear();
        currentList.add(allLabel);
      } else {
        currentList.remove(allLabel);
        if (currentList.contains(option)) {
          currentList.remove(option);
          if (currentList.isEmpty) {
            currentList.add(allLabel);
          }
        } else {
          currentList.add(option);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int count = widget.calculateResultsCount(
      _selectedMakes,
      _selectedCategories,
      _selectedConditions,
      _maxPrice,
    );

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF12161A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(
          color: const Color(0x12FFFFFF),
          width: 1,
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
                  color: Colors.white.withOpacity(0.1),
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
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: _resetAll,
                    child: Text(
                      'Reset all',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00A8CC),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0x12FFFFFF), height: 1),
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
                    _buildChipsWrap(_allCategories, _selectedCategories, 'All Categories'),
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
                            color: const Color(0xFF00A8CC),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFF00A8CC),
                        inactiveTrackColor: Colors.white.withOpacity(0.1),
                        thumbColor: const Color(0xFF00A8CC),
                        overlayColor: const Color(0xFF00A8CC).withOpacity(0.2),
                        trackHeight: 4.h,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 16.r),
                      ),
                      child: Slider(
                        value: _maxPrice,
                        min: 10.0,
                        max: 2000.0,
                        onChanged: (val) {
                          setState(() {
                            _maxPrice = val;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$10',
                            style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF8B929A)),
                          ),
                          Text(
                            '\$2,000',
                            style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF8B929A)),
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
                    color: const Color(0xFF00A8CC),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00A8CC).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Show $count Results',
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
        color: const Color(0xFF8B929A),
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildChipsWrap(List<String> options, List<String> selectedList, String allLabel) {
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
                  ? const Color(0xFF00A8CC).withOpacity(0.1)
                  : const Color(0xFF1A1F26),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? const Color(0xFF00A8CC) : Colors.transparent,
                width: 1,
              ),
            ),
            child: Text(
              option,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF00A8CC) : const Color(0xFF8B929A),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
