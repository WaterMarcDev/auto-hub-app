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
}
