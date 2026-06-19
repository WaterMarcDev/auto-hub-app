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
  double _maxPrice = 2000.0;

  // Master lists
  late List<ProductPartItem> _allParts;
  late List<ProductPartItem> _parts;

  @override
  void initState() {
    super.initState();
    _initializeMockParts();
    _filterAndSortParts();

    _partController.addListener(_onPartSearchChanged);
    _vinController.addListener(_onVinSearchChanged);
  }

  @override
  void dispose() {
    _partController.dispose();
    _vinController.dispose();
    super.dispose();
  }

  void _onPartSearchChanged() {
    setState(() {
      _filterAndSortParts();
    });
  }

  void _onVinSearchChanged() {
    setState(() {
      _filterAndSortParts();
    });
  }

  void _initializeMockParts() {
    _allParts = [
      const ProductPartItem(
        id: '1',
        title: 'Front Strut Assembly — Pair',
        price: 190,
        condition: 'Good',
        rating: 4.5,
        make: 'Kia',
        model: 'Sorento',
        yearRange: '2017–2020',
        category: 'Suspension',
        warranty: '30 Days',
        location: 'Miami, FL',
        imagePath: 'assets/images/home_part_bumper.png',
      ),
      const ProductPartItem(
        id: '2',
        title: '2.5L 4-Cylinder Engine',
        price: 1650,
        condition: 'Excellent',
        rating: 4.8,
        make: 'Subaru',
        model: 'Outback',
        yearRange: '2015–2019',
        category: 'Engine',
        warranty: '6 Months',
        location: 'Seattle, WA',
        imagePath: 'assets/images/home_part_engine.png',
        tag: 'Featured',
      ),
      const ProductPartItem(
        id: '3',
        title: 'Driver Door Panel',
        price: 135,
        condition: 'Good',
        rating: 4.4,
        make: 'Nissan',
        model: 'Altima',
        yearRange: '2019–2023',
        category: 'Interior',
        warranty: '30 Days',
        location: 'Dallas, TX',
        imagePath: 'assets/images/home_part_bumper.png',
      ),
      const ProductPartItem(
        id: '4',
        title: 'Radiator Assembly',
        price: 210,
        condition: 'Good',
        rating: 4.6,
        make: 'BMW',
        model: '3 Series',
        yearRange: '2011–2016',
        category: 'Cooling',
        warranty: '45 Days',
        location: 'Atlanta, GA',
        imagePath: 'assets/images/home_part_alternator.png',
        tag: 'New',
      ),
      const ProductPartItem(
        id: '5',
        title: 'LED Headlight Assembly — Left',
        price: 275,
        condition: 'Excellent',
        rating: 4.7,
        make: 'Toyota',
        model: 'Camry',
        yearRange: '2018–2022',
        category: 'Electrical',
        warranty: '90 Days',
        location: 'Los Angeles, CA',
        imagePath: 'assets/images/home_part_headlight.png',
      ),
      const ProductPartItem(
        id: '6',
        title: '6-Speed Automatic Transmission',
        price: 750,
        condition: 'Excellent',
        rating: 4.9,
        make: 'Chevrolet',
        model: 'Malibu',
        yearRange: '2016–2019',
        category: 'Transmission',
        warranty: '6 Months',
        location: 'Chicago, IL',
        imagePath: 'assets/images/home_part_transmission.png',
        tag: 'Certified',
      ),
      const ProductPartItem(
        id: '7',
        title: 'Front Bumper Assembly',
        price: 320,
        condition: 'Good',
        rating: 4.0,
        make: 'Ford',
        model: 'F-150',
        yearRange: '2018–2021',
        category: 'Body',
        warranty: '30 Days',
        location: 'Phoenix, AZ',
        imagePath: 'assets/images/home_part_bumper.png',
        tag: '🔥 Hot Deal',
      ),
      const ProductPartItem(
        id: '8',
        title: 'OEM Alternator',
        price: 185,
        condition: 'Excellent',
        rating: 4.8,
        make: 'Honda',
        model: 'Civic',
        yearRange: '2016–2021',
        category: 'Electrical',
        warranty: '90 Days',
        location: 'Houston, TX',
        imagePath: 'assets/images/home_part_alternator.png',
        tag: 'Featured',
      ),
    ];
  }

  void _clearFilters() {
    setState(() {
      _selectedMakes = ['All Makes'];
      _selectedCategories = ['All Categories'];
      _selectedConditions = ['All'];
      _maxPrice = 2000.0;
      _partController.clear();
      _vinController.clear();
      _filterAndSortParts();
    });
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

  int _calculateResultsCount(
    List<String> makes,
    List<String> categories,
    List<String> conditions,
    double maxPrice,
  ) {
    return _applyFilterLogic(
      _allParts,
      makes,
      categories,
      conditions,
      maxPrice,
    ).length;
  }

  List<ProductPartItem> _applyFilterLogic(
    List<ProductPartItem> list,
    List<String> makes,
    List<String> categories,
    List<String> conditions,
    double maxPrice,
  ) {
    return list.where((part) {
      // Make filter
      if (makes.isNotEmpty && !makes.contains('All Makes')) {
        if (!makes.contains(part.make)) return false;
      }
      // Category filter
      if (categories.isNotEmpty && !categories.contains('All Categories')) {
        if (!categories.contains(part.category)) return false;
      }
      // Condition filter
      if (conditions.isNotEmpty && !conditions.contains('All')) {
        if (!conditions.contains(part.condition)) return false;
      }
      // Max price filter
      if (part.price > maxPrice) return false;

      return true;
    }).toList();
  }

  void _filterAndSortParts() {
    if (_searchType == SearchType.vin) {
      final vinText = _vinController.text.trim();
      if (vinText.length < 17) {
        _parts = [];
      } else if (vinText == '145454HASBJH7W27E') {
        // As per screenshot 1, typing the exact VIN '145454HASBJH7W27E' yields 0 parts found.
        _parts = [];
      } else {
        // For other 17 digit VINs, we can show compatible parts (e.g. OEM Alternator & Front Bumper)
        _parts = _allParts
            .where((part) => part.make == 'Honda' || part.make == 'Ford')
            .toList();
      }
    } else {
      // Standard Part search
      var filtered = _applyFilterLogic(
        _allParts,
        _selectedMakes,
        _selectedCategories,
        _selectedConditions,
        _maxPrice,
      );

      // Filter by keyword query
      final query = _partController.text.trim().toLowerCase();
      if (query.isNotEmpty) {
        filtered = filtered.where((part) {
          return part.title.toLowerCase().contains(query) ||
              part.make.toLowerCase().contains(query) ||
              part.model.toLowerCase().contains(query) ||
              part.category.toLowerCase().contains(query);
        }).toList();
      }

      _parts = filtered;
    }

    // Apply Sorting
    switch (_sortType) {
      case SortType.priceAsc:
        _parts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortType.priceDesc:
        _parts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortType.topRated:
        _parts.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortType.newest:
      default:
        // Keeps the default mocked order (newest list order)
        break;
    }
  }

  void _openFilterBottomSheet() {
    showModalBottomSheet(
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
              _filterAndSortParts();
            });
          },
        );
      },
    );
  }

  void _toggleFavorite(String partId) {
    setState(() {
      _allParts = _allParts.map((part) {
        if (part.id == partId) {
          return part.copyWith(isFavorite: !part.isFavorite);
        }
        return part;
      }).toList();
      _filterAndSortParts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final showVinBanner =
        _searchType == SearchType.vin && _vinController.text.length == 17;

    return Scaffold(
      backgroundColor: const Color(0xFF12161A),
      body: SafeArea(
        child: Column(
          children: [
            // Top Header and Filters section
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
              child: Column(
                children: [
                  BrowsePartsHeader(listedCount: _allParts.length),
                  SizedBox(height: 16.h),
                  SearchTypeToggle(
                    selectedType: _searchType,
                    onChanged: (type) {
                      setState(() {
                        _searchType = type;
                        _filterAndSortParts();
                      });
                    },
                  ),
                  SizedBox(height: 16.h),
                  SearchInputs(
                    searchType: _searchType,
                    partController: _partController,
                    vinController: _vinController,
                    onFilterTap: _openFilterBottomSheet,
                    onPartChanged: (_) {},
                    onVinChanged: (_) {},
                  ),
                  SizedBox(height: 16.h),
                  SortChipsRow(
                    selectedSort: _sortType,
                    onChanged: (sort) {
                      setState(() {
                        _sortType = sort;
                        _filterAndSortParts();
                      });
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
                        color: const Color(0xFF22C55E).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFF22C55E).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Color(0xFF22C55E),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Showing parts compatible with VIN:\n${_vinController.text}',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF22C55E),
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
                          color: const Color(0xFF8B929A),
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
                                color: const Color(0xFF00A8CC),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Clear filters',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF00A8CC),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Dynamic list or empty state
                  if (_parts.isEmpty)
                    EmptyPartsView(onClearFilters: _clearFilters)
                  else
                    ..._parts.map((part) {
                      return ProductCard(
                        part: part,
                        onFavoriteTap: () => _toggleFavorite(part.id),
                        onTap: () {
                          context.push('/part-details');
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
