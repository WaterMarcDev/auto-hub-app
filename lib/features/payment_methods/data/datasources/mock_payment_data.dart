import 'package:auto_hub_app/features/payment_methods/domain/entities/payment_card.dart';

/// Pre-populated mock data for testing payment methods.
/// Note: No CVCs are stored here, addressing the previous PCI violation.
final List<PaymentCard> mockPaymentCards = [
  const PaymentCard(
    id: '1',
    cardHolder: 'MIKE JOHNSON',
    last4: '4291',
    expiry: '08/27',
    brand: 'Visa',
    isDefault: true,
  ),
  const PaymentCard(
    id: '2',
    cardHolder: 'MIKE JOHNSON',
    last4: '7832',
    expiry: '03/28',
    brand: 'Mastercard',
  ),
];
