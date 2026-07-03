import 'package:auto_hub_app/features/account_details/data/mock/mock_user_data.dart';
import 'package:auto_hub_app/features/account_details/domain/models/user_profile.dart';

class AccountRepository {
  factory AccountRepository() => _instance;
  AccountRepository._internal();
  // Singleton pattern for simple state management without extra packages
  static final AccountRepository _instance = AccountRepository._internal();

  UserProfile _currentUser = mockUserProfile;

  Future<UserProfile> getUserProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }

  Future<void> updateUserProfile(UserProfile updatedUser) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    // Simple way to compute initials based on the updated full name
    final nameParts = updatedUser.fullName.trim().split(' ');
    var newInitials = '';
    if (nameParts.isNotEmpty) {
      newInitials += nameParts.first.isNotEmpty
          ? nameParts.first[0].toUpperCase()
          : '';
      if (nameParts.length > 1) {
        newInitials += nameParts.last.isNotEmpty
            ? nameParts.last[0].toUpperCase()
            : '';
      }
    }

    _currentUser = updatedUser.copyWith(
      initials: newInitials.isEmpty ? '?' : newInitials,
    );
  }
}
