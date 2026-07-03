import 'package:flutter/material.dart';

/// AutoHub Express brand color palette.
abstract final class AppColors {
  // ── Brand Colors ──────────────────────────────────────────────────────

  /// Primary brand color — deep automotive blue.
  static const Color primary = Color(0xFF1A3A5C);

  /// Primary variant — lighter blue.
  static const Color primaryLight = Color(0xFF2E5D8A);

  /// Primary dark shade.
  static const Color primaryDark = Color(0xFF0F2440);

  /// Secondary accent — energetic orange.
  static const Color secondary = Color(0xFFFF6B35);

  /// Secondary variant — darker orange.
  static const Color secondaryDark = Color(0xFFE55A2B);

  // ── Neutral Colors ────────────────────────────────────────────────────

  /// Background color — off-white.
  static const Color background = Color(0xFFF8F9FA);

  /// Surface color — pure white.
  static const Color surface = Color(0xFFFFFFFF);

  /// Card/elevated surface color.
  static const Color surfaceElevated = Color(0xFFFFFFFF);

  /// Scaffold background.
  static const Color scaffoldBackground = Color(0xFFF5F5F7);

  // ── Text Colors ───────────────────────────────────────────────────────

  /// Primary text color — near-black.
  static const Color textPrimary = Color(0xFF1A1A2E);

  /// Secondary text color — medium gray.
  static const Color textSecondary = Color(0xFF6B7280);

  /// Hint/placeholder text color.
  static const Color textHint = Color(0xFF9CA3AF);

  /// Tertiary text / disabled color.
  static const Color textTertiary = Color(0xFF484F58);

  /// Text on primary surfaces — white.
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  /// Text on secondary surfaces — white.
  static const Color textOnSecondary = Color(0xFFFFFFFF);

  // ── Semantic Colors ───────────────────────────────────────────────────

  /// Success — green.
  static const Color success = Color(0xFF22C55E);

  /// Warning — amber.
  static const Color warning = Color(0xFFFBBF24);

  /// Error — red.
  static const Color error = Color(0xFFEF4444);

  /// Info — blue.
  static const Color info = Color(0xFF3B82F6);

  // ── Border & Divider ──────────────────────────────────────────────────

  /// Divider / border color.
  static const Color divider = Color(0xFFE5E7EB);

  /// Input border color.
  static const Color inputBorder = Color(0xFFD1D5DB);

  // ── Onboarding / Dark Mode Colors ─────────────────────────────────────

  /// Onboarding dark background.
  static const Color onboardingBackground = Color(0xFF0D1117);

  /// Onboarding card surface.
  static const Color onboardingSurface = Color(0xFF1C2330);

  /// Onboarding lighter surface.
  static const Color onboardingSurfaceLight = Color(0xFF161B22);

  /// Onboarding primary cyan accent.
  static const Color onboardingCyan = Color(0xFF0DA0CE);

  /// Onboarding primary cyan dark gradient stop.
  static const Color onboardingCyanDark = Color(0xFF0B8FB5);

  /// Onboarding success/highlight green.
  static const Color onboardingGreen = Color(0xFF34D399);

  /// Onboarding purple highlight.
  static const Color onboardingPurple = Color(0xFFA78BFA);

  /// Onboarding primary text (white/light blue-gray).
  static const Color onboardingTextPrimary = Color(0xFFF0F6FC);

  /// Onboarding secondary text (gray).
  static const Color onboardingTextSecondary = Color(0xFF8B929A);

  /// Onboarding/dark mode inactive element/border color.
  static const Color onboardingInactive = Color(0xFF222831);

  /// Onboarding/dark mode muted gray text/icon color.
  static const Color onboardingTextMuted = Color(0xFF484F58);

  /// Onboarding/dark mode error surface (for destructive actions).
  static const Color onboardingErrorSurface = Color(0xFF1C1A1E);

  static const Color colorWhite = Color(0xFFFFFFFF);

  static const Color colorBlack = Color(0xFF000000);

  static const Color colorRed = Color(0xFFFF6B6B);

  static const Color colorGreen = Color(0xFF34D399);

  static const Color colorBlue = Color(0xFF0DA0CE);

  static const Color colorPurple = Color(0xFFA78BFA);

  static const Color colorYellow = Color(0xFFFBBF24);

  static const Color colorGray = Color(0xFF8B929A);

  static const Color colorDarkGray = Color(0xFF484F58);

  static const Color colorLightGray = Color(0xFF2D333B);

  /// Deep dark blue-gray surface variant.
  static const Color surfaceDarkVariant = Color(0xFF1A1F26);

  // ── Page Gradients (Dark Theme) ──────────────────────────────────

  /// Dark gradient start — very dark navy.
  static const Color gradientDarkStart = Color(0xFF080D14);

  /// Dark gradient midpoint — dark midnight blue.
  static const Color gradientDarkMid = Color(0xFF0A1220);

  /// Dark gradient end — near-black.
  static const Color gradientDarkEnd = Color(0xFF050810);

  /// Dark gradient surface — dark navy.
  static const Color gradientDarkSurface = Color(0xFF08101A);

  /// Dark gradient alt 1 — dark charcoal.
  static const Color gradientDarkAlt1 = Color(0xFF0B1016);

  /// Dark gradient alt 2 — dark blue-black.
  static const Color gradientDarkAlt2 = Color(0xFF070E17);

  /// Card gradient start — dark steel blue.
  static const Color gradientCardStart = Color(0xFF0F1A28);

  // ── UI Surfaces & Containers ─────────────────────────────────────

  /// Dark surface — dark gray-blue (browse page).
  static const Color surfaceDark = Color(0xFF12161A);

  /// Dark slate surface (search toggle).
  static const Color surfaceSlate = Color(0xFF131922);

  /// Dark steel surface (text fields).
  static const Color surfaceSteel = Color(0xFF1B222D);

  /// Slate gray-blue icon color.
  static const Color iconSlate = Color(0xFF2B3445);

  /// Inactive tab label gray.
  static const Color tabInactive = Color(0xFF4B5563);

  /// Inactive toggle icon/text gray.
  static const Color toggleInactive = Color(0xFF4C5562);

  /// Inactive toggle switch track.
  static const Color toggleTrackInactive = Color(0xFF2E333D);

  // ── Accent & Semantic Colors ─────────────────────────────────────

  /// Teal/cyan accent (browse header).
  static const Color accentTeal = Color(0xFF00A8CC);

  /// Certified badge green.
  static const Color certifiedGreen = Color(0xFF10B981);

  /// Star rating amber.
  static const Color starRating = Color(0xFFF59E0B);

  /// Facebook brand blue.
  static const Color facebookBlue = Color(0xFF1877F2);

  /// Teal glow (junk car banner).
  static const Color glowTeal = Color(0xFF075067);

  // ── Credit Card Brand Gradients ──────────────────────────────────

  /// Amex dark blue.
  static const Color cardAmexDark = Color(0xFF00457C);

  /// Amex mid blue.
  static const Color cardAmexBlue = Color(0xFF007BC1);

  /// Amex light cyan.
  static const Color cardAmexLight = Color(0xFF55C1E7);

  /// Visa deep navy.
  static const Color cardVisaNavy = Color(0xFF162E4B);

  /// Mastercard crimson orange.
  static const Color cardMastercardCrimson = Color(0xFF9E3613);

  /// Default card dark.
  static const Color cardDefaultDark = Color(0xFF111111);

  /// Default card mid.
  static const Color cardDefaultMid = Color(0xFF333333);

  /// Default card light.
  static const Color cardDefaultLight = Color(0xFF555555);

  // ── Credit Card Gold Chip ────────────────────────────────────────

  /// Gold chip bright yellow-gold.
  static const Color chipGoldLight = Color(0xFFFFF099);

  /// Gold chip metallic gold.
  static const Color chipGoldMetallic = Color(0xFFE5B942);

  /// Gold chip dark bronze-gold.
  static const Color chipGoldDark = Color(0xFFB5841D);

  /// Gold chip center element.
  static const Color chipGoldCenter = Color(0xFFC79532);

  /// Gold chip micro-line bronze.
  static const Color chipGoldLine = Color(0xFF6B510B);
}
