enum OrderStatus {
  delivered,
  inTransit,
  processing,
  cancelled,
}

class OrderTimelineEvent {
  const OrderTimelineEvent({
    required this.title,
    required this.isCompleted,
    this.time,
  });

  final String title;
  final String? time;
  final bool isCompleted;
}

class Order {
  const Order({
    required this.id,
    required this.title,
    required this.price,
    required this.address,
    required this.date,
    required this.status,
    required this.timeline,
    this.trackingNumber,
  });

  final String id;
  final String title;
  final double price;
  final String? trackingNumber;
  final String address;
  final DateTime date;
  final OrderStatus status;
  final List<OrderTimelineEvent> timeline;

  Order copyWith({
    OrderStatus? status,
    List<OrderTimelineEvent>? timeline,
  }) {
    return Order(
      id: id,
      title: title,
      price: price,
      address: address,
      date: date,
      status: status ?? this.status,
      timeline: timeline ?? this.timeline,
      trackingNumber: trackingNumber,
    );
  }
}
