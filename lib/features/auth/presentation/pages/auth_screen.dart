import 'dart:async';

import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:auto_hub_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:auto_hub_app/features/auth/presentation/widgets/auth_toggle_tab.dart';
import 'package:auto_hub_app/features/auth/presentation/widgets/social_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.initialTabIndex = 0});
  final int initialTabIndex;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late PageController _pageController;
  late int _currentIndex;

  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  final TextEditingController _signupNameController = TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();
  final TextEditingController _signupPasswordController =
      TextEditingController();

  final bool _obscureLoginPassword = true;
  final bool _obscureSignupPassword = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
    _pageController = PageController(initialPage: widget.initialTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupNameController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    super.dispose();
  }

  void _switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
    unawaited(
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              // Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                  child: Container(
                    width: 36.9,
                    height: 36.9,
                    decoration: BoxDecoration(
                      color: AppColors.onboardingSurfaceLight,
                      borderRadius: BorderRadius.circular(16.41),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                        width: 0.82,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 4.1,
                          offset: const Offset(0, 1.03),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      AppIcons.arrowLeft,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Header Texts (Animated based on tab)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _currentIndex == 0
                    ? _buildHeader(
                        'Welcome back 👋',
                        'Sign in to find parts, save listings & more',
                      )
                    : _buildHeader(
                        'Create your account 🔧',
                        'Join 94K+ buyers on AutoHub Express',
                      ),
              ),
              const SizedBox(height: 32),
              
              // Auth Toggle
              AuthToggleTab(
                isSignIn: _currentIndex == 0,
                onSignInTap: () => _switchTab(0),
                onSignUpTap: () => _switchTab(1),
              ),
              const SizedBox(height: 24),
              
              // Social Buttons
              SocialButton(
                text: _currentIndex == 0
                    ? 'Continue with Google'
                    : 'Sign up with Google',
                iconPath: AppIcons.google,
                backgroundColor: AppColors.onboardingSurfaceLight,
                textColor: AppColors.onboardingTextPrimary,
                shadowColor: Colors.black.withValues(alpha: 0.3),
                borderColor: Colors.white.withValues(alpha: 0.1),
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              SocialButton(
                text: _currentIndex == 0
                    ? 'Continue with Facebook'
                    : 'Sign up with Facebook',
                iconPath: AppIcons.facebook,
                backgroundColor: const Color(0xFF1877F2),
                textColor: Colors.white,
                shadowColor: const Color(0xFF1877F2).withValues(alpha: 0.35),
                onPressed: () {},
              ),
              const SizedBox(height: 24),
              
              // Divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.white.withValues(alpha: 0.07),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or continue with email',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: const Color(0xFF484F58),
                        fontSize: 12.3,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.white.withValues(alpha: 0.07),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Form PageView
              SizedBox(
                height: 250, // Fixed height for form area
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    _buildLoginForm(),
                    _buildSignupForm(),
                  ],
                ),
              ),
              
              // Continue as Guest
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Continue as ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: const Color(0xFF484F58),
                      fontSize: 13.3,
                    ),
                    children: [
                      TextSpan(
                        text: 'Guest',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onboardingCyan,
                          fontSize: 13.3,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          context.go('/');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Terms & Privacy
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "By continuing, you agree to AutoHub Express's ",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: const Color(0xFF484F58),
                    fontSize: 10.2,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.onboardingCyan,
                        fontSize: 10.2,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.onboardingCyan,
                        fontSize: 10.2,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title, String subtitle) {
    return Column(
        key: ValueKey<String>(title),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppTextStyles.displayLarge.copyWith(
              color: AppColors.onboardingTextPrimary,
              fontSize: 26.6,
              height: 1.2,
              letterSpacing: -0.82,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onboardingTextSecondary,
              fontSize: 13.3,
            ),
          ),
        ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        AuthTextField(
          hintText: 'Email address',
          prefixIcon: SvgPicture.asset(AppIcons.mail),
        ),
        const SizedBox(height: 12),
        AuthTextField(
          hintText: 'Password',
          prefixIcon: SvgPicture.asset(AppIcons.lock),
          isPassword: _obscureLoginPassword,
          suffixIconPath: AppIcons.eyeOutline,
          suffixIconPathActive: AppIcons.eyeDot,
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Forgot password?',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.onboardingCyan,
                fontSize: 12.3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        AuthButton(
          text: 'Sign In',
          isPrimary: false,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSignupForm() {
    return Column(
      children: [
        const AuthTextField(
          hintText: 'Full name',
          prefixIcon: Text('👤', style: TextStyle(fontSize: 14.36)),
        ),
        const SizedBox(height: 12),
        AuthTextField(
          hintText: 'Email address',
          prefixIcon: SvgPicture.asset(AppIcons.mail),
        ),
        const SizedBox(height: 12),
        AuthTextField(
          hintText: 'Password',
          prefixIcon: SvgPicture.asset(AppIcons.lock),
          isPassword: _obscureSignupPassword,
          suffixIconPath: AppIcons.eyeOutline,
          suffixIconPathActive: AppIcons.eyeDot,
        ),
        const SizedBox(height: 24),
        AuthButton(
          text: 'Create Account',
          isPrimary: false,
          onPressed: () {},
        ),
      ],
    );
  }
}
