class UserProfile {

  UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.location,
    required this.memberSince,
    required this.accountType,
    required this.initials,
    this.isVerified = false,
  });
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String location;
  final String memberSince;
  final String accountType;
  final String initials;
  final bool isVerified;

  UserProfile copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? location,
    String? memberSince,
    String? accountType,
    String? initials,
    bool? isVerified,
  }) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      memberSince: memberSince ?? this.memberSince,
      accountType: accountType ?? this.accountType,
      initials: initials ?? this.initials,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
