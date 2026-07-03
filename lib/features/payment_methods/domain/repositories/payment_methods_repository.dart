import 'package:auto_hub_app/features/payment_methods/domain/entities/payment_card.dart';

abstract class PaymentMethodsRepository {
  /// Gets all saved payment methods for the current user.
  Future<List<PaymentCard>> getPaymentMethods();

  /// Simulates adding a new payment card.
  /// 
  /// The CVC is required here for processing but will NOT be stored
  /// in the resulting [PaymentCard] entity.
  Future<PaymentCard> addPaymentMethod({
    required String cardHolder,
    required String cardNumber,
    required String expiry,
    required String cvc,
  });

  /// Removes a payment method by its ID.
  Future<void> removePaymentMethod(String cardId);

  /// Sets a payment method as the default option.
  Future<void> setDefaultPaymentMethod(String cardId);
}
