import 'package:auto_hub_app/features/payment_methods/data/datasources/mock_payment_data.dart';
import 'package:auto_hub_app/features/payment_methods/domain/entities/payment_card.dart';
import 'package:auto_hub_app/features/payment_methods/domain/repositories/payment_methods_repository.dart';

class PaymentMethodsRepositoryImpl implements PaymentMethodsRepository {
  // Simulating a database or remote source using local memory
  final List<PaymentCard> _cards = List.from(mockPaymentCards);

  @override
  Future<List<PaymentCard>> getPaymentMethods() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return List.unmodifiable(_cards);
  }

  @override
  Future<PaymentCard> addPaymentMethod({
    required String cardHolder,
    required String cardNumber,
    required String expiry,
    required String cvc,
  }) async {
    // In a real app, this is where tokenization happens. 
    // The raw PAN and CVC are sent securely to a payment gateway, 
    // and we receive a token or just store the safe details.
    
    // Simulate network processing
    await Future.delayed(const Duration(milliseconds: 1000));

    final cleanNumber = cardNumber.replaceAll(RegExp(r'\s+'), '');
    
    // Determine last 4
    final last4 = cleanNumber.length >= 4 
        ? cleanNumber.substring(cleanNumber.length - 4) 
        : cleanNumber;

    // Detect brand based on first digits
    String detectedBrand = 'Visa';
    if (cleanNumber.startsWith('4')) {
      detectedBrand = 'Visa';
    } else if (cleanNumber.startsWith('5')) {
      detectedBrand = 'Mastercard';
    } else if (cleanNumber.startsWith(RegExp(r'3[47]'))) {
      detectedBrand = 'AmEx';
    } else if (cleanNumber.startsWith('6')) {
      detectedBrand = 'Discover';
    } else {
      detectedBrand = 'Unknown';
    }

    final newCard = PaymentCard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cardHolder: cardHolder.toUpperCase(),
      last4: last4,
      expiry: expiry,
      brand: detectedBrand,
      isDefault: _cards.isEmpty,
    );

    _cards.add(newCard);
    return newCard;
  }

  @override
  Future<void> removePaymentMethod(String cardId) async {
    // Simulate network processing
    await Future.delayed(const Duration(milliseconds: 400));
    
    final index = _cards.indexWhere((c) => c.id == cardId);
    if (index == -1) return;

    final cardToRemove = _cards[index];
    _cards.removeAt(index);

    // Promote another card to default if the default card was removed
    if (cardToRemove.isDefault && _cards.isNotEmpty) {
      _cards[0] = _cards[0].copyWith(isDefault: true);
    }
  }

  @override
  Future<void> setDefaultPaymentMethod(String cardId) async {
    // Simulate network processing
    await Future.delayed(const Duration(milliseconds: 400));
    
    for (int i = 0; i < _cards.length; i++) {
      _cards[i] = _cards[i].copyWith(isDefault: _cards[i].id == cardId);
    }
  }
}
