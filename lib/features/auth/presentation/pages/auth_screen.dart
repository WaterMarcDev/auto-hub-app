import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:auto_hub_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:auto_hub_app/features/auth/presentation/widgets/auth_toggle_tab.dart';
import 'package:auto_hub_app/features/auth/presentation/widgets/social_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.initialTabIndex = 0});
  final int initialTabIndex;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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

  bool _isLoginValid = false;
  bool _isSignupValid = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;

    _loginEmailController.addListener(_updateLoginValidity);
    _loginPasswordController.addListener(_updateLoginValidity);
    _signupNameController.addListener(_updateSignupValidity);
    _signupEmailController.addListener(_updateSignupValidity);
    _signupPasswordController.addListener(_updateSignupValidity);
  }

  @override
  void dispose() {
    _loginEmailController.removeListener(_updateLoginValidity);
    _loginPasswordController.removeListener(_updateLoginValidity);
    _signupNameController.removeListener(_updateSignupValidity);
    _signupEmailController.removeListener(_updateSignupValidity);
    _signupPasswordController.removeListener(_updateSignupValidity);
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
  }

  void _updateLoginValidity() {
    setState(() {
      _isLoginValid = _loginEmailController.text.trim().isNotEmpty &&
          _loginPasswordController.text.trim().isNotEmpty;
    });
  }

  void _updateSignupValidity() {
    setState(() {
      _isSignupValid = _signupNameController.text.trim().isNotEmpty &&
          _signupEmailController.text.trim().isNotEmpty &&
          _signupPasswordController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 12.h),
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
                    child: const Icon(
                      AppIcons.arrowLeft
                    )
                  ),
                ),
              ),
              SizedBox(height: 32.h),

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
              SizedBox(height: 32.h),

              // Auth Toggle
              AuthToggleTab(
                isSignIn: _currentIndex == 0,
                onSignInTap: () => _switchTab(0),
                onSignUpTap: () => _switchTab(1),
              ),
              SizedBox(height: 24.h),

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
              SizedBox(height: 12.h),
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
              SizedBox(height: 24.h),

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
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      'or continue with email',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                        fontSize: 12.sp,
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
              SizedBox(height: 24.h),

              // Form content (auto-sizes to its content)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _currentIndex == 0
                      ? _buildLoginForm()
                      : _buildSignupForm(),
                ),
              ),
              SizedBox(height: 8.h),

              // Continue as Guest
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Continue as ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 13.sp,
                    ),
                    children: [
                      TextSpan(
                        text: 'Guest',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onboardingCyan,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go('/');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Terms & Privacy
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "By continuing, you agree to AutoHub Express's ",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                    fontSize: 10.sp,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.onboardingCyan,
                        fontSize: 10.sp,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.onboardingCyan,
                        fontSize: 10.sp,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
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
            fontSize: 26.sp,
            height: 1.2,
            letterSpacing: -0.8,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onboardingTextSecondary,
            fontSize: 13.sp,
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
          prefixIcon: const Icon(AppIcons.mail),
          controller: _loginEmailController,
        ),
        SizedBox(height: 12.h),
        AuthTextField(
          hintText: 'Password',
          prefixIcon: const Icon(AppIcons.lock),
          isPassword: _obscureLoginPassword,
          suffixIconPath: AppIcons.eyeOutline,
          suffixIconPathActive: AppIcons.eyeDot,
          controller: _loginPasswordController,
        ),
        SizedBox(height: 12.h),
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
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        AuthButton(
          text: 'Sign In',
          isPrimary: true,
          enabled: _isLoginValid,
          onPressed: () {
            if (!_isLoginValid) return;
            // TODO: trigger sign-in logic
          },
        ),
      ],
    );
  }

  Widget _buildSignupForm() {
    return Column(
      children: [
        AuthTextField(
          hintText: 'Full name',
          prefixIcon: const Icon(AppIcons.user),
          controller: _signupNameController,
        ),
        SizedBox(height: 12.h),
        AuthTextField(
          hintText: 'Email address',
          prefixIcon: Icon(AppIcons.mail),
          controller: _signupEmailController,
        ),
        SizedBox(height: 12.h),
        AuthTextField(
          hintText: 'Password',
          prefixIcon: Icon(AppIcons.lock),
          isPassword: _obscureSignupPassword,
          suffixIconPath: AppIcons.eyeOutline,
          suffixIconPathActive: AppIcons.eyeDot,
          controller: _signupPasswordController,
        ),
        SizedBox(height: 24.h),
        AuthButton(
          text: 'Create Account',
          isPrimary: true,
          enabled: _isSignupValid,
          onPressed: () {
            if (!_isSignupValid) return;
            // TODO: trigger sign-up logic
          },
        ),
      ],
    );
  }
}
