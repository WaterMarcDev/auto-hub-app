import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoutes {
  /// Base URL from environment variables
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'http://localhost:5000';

  // ==========================================
  // Auth APIs
  // ==========================================
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String profile = '/api/auth/profile';
  static const String logout = '/api/auth/logout';

  // ==========================================
  // Dashboard Analytics APIs
  // ==========================================
  static const String dashboardSummary = '/api/dashboard/summary';
  static const String dashboardRevenueTrend = '/api/dashboard/revenue-trend';
  static const String dashboardSummaryCounts = '/api/dashboard/summary-counts';
  static const String dashboardEarningGoal = '/api/dashboard/earning-goal';

  // ==========================================
  // Inventory Management APIs
  // ==========================================
  static const String inventory = '/api/inventory';
  static const String inventoryExport = '/api/inventory/export';
  static String inventoryByVin(String vin) => '/api/inventory/vin/$vin';
  static const String inventoryParts = '/api/inventory/parts';

  // ==========================================
  // Junk Car Request APIs
  // ==========================================
  static const String junkCar = '/api/junk-car';
  static String junkCarStatus(String id) => '/api/junk-car/$id/status';

  // ==========================================
  // Customer Part Request APIs
  // ==========================================
  static const String partRequestTest = '/api/part-request/test';
  static const String partRequest = '/api/part-request';
  static String partRequestById(String id) => '/api/part-request/$id';

  // ==========================================
  // User Management APIs
  // ==========================================
  static const String users = '/api/users';
  static String userById(String id) => '/api/users/$id';
  static String userPassword(String id) => '/api/users/$id/password';

  // ==========================================
  // Car Intake APIs
  // ==========================================
  static const String carIntake = '/api/car-intake';
  static String carIntakeById(String id) => '/api/car-intake/$id';
}
