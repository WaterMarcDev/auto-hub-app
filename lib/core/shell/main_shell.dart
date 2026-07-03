import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/features/browse/presentation/pages/browse_page.dart';
import 'package:auto_hub_app/features/home/presentation/pages/home_page.dart';
import 'package:auto_hub_app/features/profile/presentation/pages/profile_page.dart';
import 'package:auto_hub_app/features/saved/presentation/pages/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class _NavItem {
  const _NavItem(this.label, this.iconPath);
  final String label;
  final String iconPath;
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  static const List<_NavItem> _items = [
    _NavItem('Home', 'assets/icons/ic_nav_home.svg'),
    _NavItem('Browse', 'assets/icons/ic_nav_browse.svg'),
    _NavItem('Saved', 'assets/icons/ic_nav_saved.svg'),
    _NavItem('Profile', 'assets/icons/ic_nav_profile.svg'),
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const BrowsePage(),
      SavedPage(onBrowseTap: () => _goToTab(1)),
      const ProfilePage(),
    ];
  }

  void _goToTab(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildNavBar() {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return Container(
      height: 76.h + bottomInset,
      decoration: const BoxDecoration(
        color: AppColors.onboardingBackground,
        border: Border(
          top: BorderSide(
            color: Color(0x12FFFFFF), // rgba(255,255,255,0.07)
            width: 0.8,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x80000000), // rgba(0,0,0,0.5)
            blurRadius: 32,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, bottomInset),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            _items.length,
            _buildNavButton,
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(int index) {
    final isActive = _currentIndex == index;
    final item = _items[index];

    return GestureDetector(
      onTap: () => _goToTab(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72.w,
        height: 66.h,
        child: Column(
          children: [
            SizedBox(height: 6.h),
            SizedBox(
              width: 40.w,
              height: 40.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Active background gradient
                  if (isActive)
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0x330DA0CE), // rgba(13,160,206,0.2)
                            Color(0x1F0B8FB5), // rgba(11,143,181,0.12)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.onboardingCyan.withValues(
                              alpha: 0.2,
                            ),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                    ),

                  // Icon — centered at left:10, top:10 within the 40×40 container
                  Positioned(
                    left: 10.w,
                    top: 10.h,
                    child: SvgPicture.asset(
                      item.iconPath,
                      width: 20.w,
                      height: 20.h,
                      colorFilter: ColorFilter.mode(
                        isActive
                            ? AppColors.onboardingCyan
                            : AppColors.onboardingTextSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  // Active indicator dot — positioned at left:18, top:38 (bleeds below container)
                  if (isActive)
                    Positioned(
                      left: 18.w,
                      top: 38.h,
                      child: Container(
                        width: 4.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0DA0CE),
                          borderRadius: BorderRadius.circular(2.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xCC0DA0CE), // rgba(13,160,206,0.8)
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Gap between icon container bottom (at 46px) and label start (at 50px) = 4px
            SizedBox(height: 4.h),
            Text(
              item.label,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive
                    ? const Color(0xFF0DA0CE)
                    : const Color(0xFF4B5563),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
