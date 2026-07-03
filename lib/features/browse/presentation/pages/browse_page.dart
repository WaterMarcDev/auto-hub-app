import 'dart:async';

import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/features/browse/data/repositories/mock_browse_repository.dart';
import 'package:auto_hub_app/features/browse/domain/models/product_part_item.dart';
import 'package:auto_hub_app/features/browse/domain/repositories/browse_repository.dart';
import 'package:auto_hub_app/features/browse/presentation/widgets/browse_parts_header.dart';
import 'package:auto_hub_app/features/browse/presentation/widgets/empty_parts_view.dart';
import 'package:auto_hub_app/features/browse/presentation/widgets/filter_bottom_sheet.dart';
import 'package:auto_hub_app/features/browse/presentation/widgets/product_card.dart';
import 'package:auto_hub_app/features/browse/presentation/widgets/search_inputs.dart';
import 'package:auto_hub_app/features/browse/presentation/widgets/search_type_toggle.dart';
import 'package:auto_hub_app/features/browse/presentation/widgets/sort_chips_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  // State variables
  SearchType _searchType = SearchType.part;
  SortType _sortType = SortType.newest;
  final TextEditingController _partController = TextEditingController();
  final TextEditingController _vinController = TextEditingController();

  // Filters State
  List<String> _selectedMakes = ['All Makes'];
  List<String> _selectedCategories = ['All Categories'];
  List<String> _selectedConditions = ['All'];
  double _maxPrice = 2000;

  // Repository & State
  final BrowseRepository _repository = MockBrowseRepository();
  bool _isLoading = true;
  List<ProductPartItem> _parts = [];
  int _totalCount = 0; // To keep track of listed count

  @override
  void initState() {
    super.initState();
    unawaited(_loadInitialCount());
    unawaited(_fetchParts());

    _partController.addListener(_onPartSearchChanged);
    _vinController.addListener(_onVinSearchChanged);
  }

  Future<void> _loadInitialCount() async {
    final allParts = await _repository.getParts();
    if (mounted) {
      setState(() {
        _totalCount = allParts.length;
      });
    }
  }

  @override
  void dispose() {
    _partController.dispose();
    _vinController.dispose();
    super.dispose();
  }

  void _onPartSearchChanged() {
    unawaited(_fetchParts());
  }

  void _onVinSearchChanged() {
    unawaited(_fetchParts());
  }

  void _clearFilters() {
    setState(() {
      _selectedMakes = ['All Makes'];
      _selectedCategories = ['All Categories'];
      _selectedConditions = ['All'];
      _maxPrice = 2000.0;
      _partController.clear();
      _vinController.clear();
    });
    unawaited(_fetchParts());
  }

  bool _areFiltersApplied() {
    final makesApplied =
        _selectedMakes.isNotEmpty && !_selectedMakes.contains('All Makes');
    final catsApplied =
        _selectedCategories.isNotEmpty &&
        !_selectedCategories.contains('All Categories');
    final condsApplied =
        _selectedConditions.isNotEmpty && !_selectedConditions.contains('All');
    final priceApplied = _maxPrice < 2000.0;
    final queryApplied = _partController.text.isNotEmpty;
    return makesApplied ||
        catsApplied ||
        condsApplied ||
        priceApplied ||
        queryApplied;
  }

  Future<int> _calculateResultsCount(
    List<String> makes,
    List<String> categories,
    List<String> conditions,
    double maxPrice,
  ) async {
    final results = await _repository.searchParts(
      query: _partController.text.trim(),
      makes: makes,
      categories: categories,
      conditions: conditions,
      maxPrice: maxPrice,
    );
    return results.length;
  }

  Future<void> _fetchParts() async {
    setState(() {
      _isLoading = true;
    });

    var results = <ProductPartItem>[];
    if (_searchType == SearchType.vin) {
      final vinText = _vinController.text.trim();
      results = await _repository.searchByVin(vinText);
    } else {
      results = await _repository.searchParts(
        query: _partController.text.trim(),
        makes: _selectedMakes,
        categories: _selectedCategories,
        conditions: _selectedConditions,
        maxPrice: _maxPrice,
      );
    }

    // Apply Sorting
    switch (_sortType) {
      case SortType.priceAsc:
        results.sort((a, b) => a.price.compareTo(b.price));
      case SortType.priceDesc:
        results.sort((a, b) => b.price.compareTo(a.price));
      case SortType.topRated:
        results.sort((a, b) => b.rating.compareTo(a.rating));
      case SortType.newest:
    }

    if (mounted) {
      setState(() {
        _parts = results;
        _isLoading = false;
      });
    }
  }

  void _openFilterBottomSheet() {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return FilterBottomSheet(
            initialMakes: _selectedMakes,
            initialCategories: _selectedCategories,
            initialConditions: _selectedConditions,
            initialMaxPrice: _maxPrice,
            calculateResultsCount: _calculateResultsCount,
            onApply: (makes, categories, conditions, maxPrice) {
              setState(() {
                _selectedMakes = makes;
                _selectedCategories = categories;
                _selectedConditions = conditions;
                _maxPrice = maxPrice;
              });
              unawaited(_fetchParts());
            },
          );
        },
      ),
    );
  }

  Future<void> _toggleFavorite(String partId) async {
    await _repository.toggleFavorite(partId);
    await _fetchParts();
  }

  @override
  Widget build(BuildContext context) {
    final showVinBanner =
        _searchType == SearchType.vin && _vinController.text.length == 17;

    return Scaffold(
      backgroundColor: AppColors.surfaceDark,
      body: SafeArea(
        child: Column(
          children: [
            // Top Header and Filters section
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
              child: Column(
                children: [
                  BrowsePartsHeader(listedCount: _totalCount),
                  SizedBox(height: 16.h),
                  SearchTypeToggle(
                    selectedType: _searchType,
                    onChanged: (type) {
                      setState(() {
                        _searchType = type;
                      });
                      unawaited(_fetchParts());
                    },
                  ),
                  SizedBox(height: 16.h),
                  SearchInputs(
                    searchType: _searchType,
                    partController: _partController,
                    vinController: _vinController,
                    onFilterTap: _openFilterBottomSheet,
                  ),
                  SizedBox(height: 16.h),
                  SortChipsRow(
                    selectedSort: _sortType,
                    onChanged: (sort) {
                      setState(() {
                        _sortType = sort;
                      });
                      unawaited(_fetchParts());
                    },
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
            const Divider(color: Color(0x12FFFFFF), height: 1),

            // Scrollable content area
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                children: [
                  // VIN banner if valid VIN typed
                  if (showVinBanner) ...[
                    Container(
                      padding: EdgeInsets.all(14.r),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            color: AppColors.success,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Showing parts compatible with VIN:\n'
                              '${_vinController.text}',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // Results header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_parts.length} parts found',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (_searchType == SearchType.part &&
                          _areFiltersApplied())
                        GestureDetector(
                          onTap: _clearFilters,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.close,
                                size: 14.r,
                                color: AppColors.info,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Clear filters',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.info,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  if (_isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.info,
                          ),
                        ),
                      ),
                    )
                  else if (_parts.isEmpty)
                    EmptyPartsView(onClearFilters: _clearFilters)
                  else
                    ..._parts.map((part) {
                      return ProductCard(
                        part: part,
                        onFavoriteTap: () =>
                            unawaited(_toggleFavorite(part.id)),
                        onTap: () {
                          unawaited(context.push('/part-details'));
                        },
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
