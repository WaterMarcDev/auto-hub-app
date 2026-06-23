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
}
