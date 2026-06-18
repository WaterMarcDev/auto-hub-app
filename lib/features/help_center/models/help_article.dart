class HelpArticle {
  final String id;
  final String title;
  final String content;
  final String category;

  const HelpArticle({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
  });

  /// The static list of default help articles displayed in the Help Center.
  static const List<HelpArticle> defaultArticles = [
    HelpArticle(
      id: '1',
      title: 'How do I junk my car?',
      content:
          'Navigate to the Home screen and tap \'Junk Your Car\'. Fill out your vehicle details including make, model, year, and condition. You\'ll receive an instant cash offer, and we\'ll arrange free towing to pick up your car at a time that works for you.',
      category: 'Junking',
    ),
    HelpArticle(
      id: '2',
      title: 'How long does parts shipping take?',
      content:
          'Standard shipping takes 3-5 business days. Express shipping options are available at checkout and usually deliver within 1-2 business days.',
      category: 'Orders',
    ),
    HelpArticle(
      id: '3',
      title: 'Can I return a part?',
      content:
          'Yes, you can return any unused part within 30 days of purchase. Head to your orders page and select \'Return Item\' to generate a free return shipping label.',
      category: 'Orders',
    ),
    HelpArticle(
      id: '4',
      title: 'How does VIN lookup work?',
      content:
          'Our VIN lookup tool retrieves your vehicle\'s specific year, make, model, and trim details directly from the national database. This ensures you find the exact parts that fit your vehicle.',
      category: 'Parts',
    ),
    HelpArticle(
      id: '5',
      title: 'How do I contact a seller?',
      content:
          'You can contact the seller directly by tapping \'Contact Seller\' on the product details page or inside your order details screen.',
      category: 'Parts',
    ),
    HelpArticle(
      id: '6',
      title: 'What payment methods are accepted?',
      content:
          'We accept all major credit and debit cards, Apple Pay, Google Pay, and PayPal.',
      category: 'Payments',
    ),
    HelpArticle(
      id: '7',
      title: 'How are junk car offers calculated?',
      content:
          'Offers are calculated based on your vehicle\'s year, make, model, mileage, condition, and the current market value of salvage metal and parts.',
      category: 'Junking',
    ),
    HelpArticle(
      id: '8',
      title: 'Is my payment info secure?',
      content:
          'Yes, all payments are encrypted and processed securely. We do not store your full credit card details on our servers.',
      category: 'Payments',
    ),
  ];
}
