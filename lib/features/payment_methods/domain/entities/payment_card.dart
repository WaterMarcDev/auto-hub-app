import 'package:flutter/foundation.dart';

/// Represents a user's payment credit card.
/// Note: For PCI compliance, this model never stores the CVC, 
/// and the full card number is kept only as its last 4 digits.
@immutable
class PaymentCard {
  const PaymentCard({
    required this.id,
    required this.cardHolder,
    required this.last4,
    required this.expiry,
    required this.brand,
    this.isDefault = false,
  });

  final String id;
  final String cardHolder;
  final String last4; // Only the last 4 digits are stored
  final String expiry; // Format: MM/YY
  final String brand; // e.g., 'Visa', 'Mastercard', 'AmEx', 'Discover'
  final bool isDefault;

  /// Returns the masked version of the card number (e.g., "•••• •••• •••• 4291").
  String get maskedNumber {
    // Basic formatting for a masked display
    return '••••  ••••  ••••  $last4';
  }

  PaymentCard copyWith({
    String? id,
    String? cardHolder,
    String? last4,
    String? expiry,
    String? brand,
    bool? isDefault,
  }) {
    return PaymentCard(
      id: id ?? this.id,
      cardHolder: cardHolder ?? this.cardHolder,
      last4: last4 ?? this.last4,
      expiry: expiry ?? this.expiry,
      brand: brand ?? this.brand,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PaymentCard &&
      other.id == id &&
      other.cardHolder == cardHolder &&
      other.last4 == last4 &&
      other.expiry == expiry &&
      other.brand == brand &&
      other.isDefault == isDefault;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      cardHolder.hashCode ^
      last4.hashCode ^
      expiry.hashCode ^
      brand.hashCode ^
      isDefault.hashCode;
  }
}
