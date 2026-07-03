import 'package:auto_hub_app/features/my_order/domain/models/order_model.dart';

final List<Order> mockOrders = [
  Order(
    id: 'ORD-2847',
    title: 'Alternator – 2018 Honda Civic',
    price: 89.99,
    trackingNumber: '1Z999AA10123456784',
    address: '4521 Westheimer Rd, Houston, TX',
    date: DateTime(2026, 3, 22),
    status: OrderStatus.delivered,
    timeline: const [
      OrderTimelineEvent(
        title: 'Order Placed',
        time: 'Mar 18, 2:14 PM',
        isCompleted: true,
      ),
      OrderTimelineEvent(
        title: 'Confirmed by Seller',
        time: 'Mar 18, 4:30 PM',
        isCompleted: true,
      ),
      OrderTimelineEvent(
        title: 'Shipped',
        time: 'Mar 19, 9:00 AM',
        isCompleted: true,
      ),
      OrderTimelineEvent(
        title: 'Out for Delivery',
        time: 'Mar 22, 8:15 AM',
        isCompleted: true,
      ),
      OrderTimelineEvent(
        title: 'Delivered',
        time: 'Mar 22, 1:47 PM',
        isCompleted: true,
      ),
    ],
  ),
  Order(
    id: 'ORD-2831',
    title: 'Headlight Assembly – 2020 Toyota Camry',
    price: 124.5,
    trackingNumber: '1Z999BB20234567891',
    address: '4521 Westheimer Rd, Houston, TX',
    date: DateTime(2026, 3, 28),
    status: OrderStatus.inTransit,
    timeline: const [
      OrderTimelineEvent(
        title: 'Order Placed',
        time: 'Mar 25, 11:20 AM',
        isCompleted: true,
      ),
      OrderTimelineEvent(
        title: 'Confirmed by Seller',
        time: 'Mar 25, 2:00 PM',
        isCompleted: true,
      ),
      OrderTimelineEvent(
        title: 'Shipped',
        time: 'Mar 27, 10:15 AM',
        isCompleted: true,
      ),
      OrderTimelineEvent(
        title: 'In Transit',
        time: 'Mar 28, 6:00 AM',
        isCompleted: true,
      ),
      OrderTimelineEvent(
        title: 'Out for Delivery',
        time: 'Pending',
        isCompleted: false,
      ),
      OrderTimelineEvent(
        title: 'Delivered',
        time: 'Pending',
        isCompleted: false,
      ),
    ],
  ),
  Order(
    id: 'ORD-2796',
    title: 'Brake Rotor Set – 2017 Ford F-150',
    price: 67,
    address: '1200 McKinney St, Houston, TX',
    date: DateTime(2026, 3, 30),
    status: OrderStatus.processing,
    timeline: const [
      OrderTimelineEvent(
        title: 'Order Placed',
        time: 'Mar 30, 9:45 AM',
        isCompleted: true,
      ),
      OrderTimelineEvent(
        title: 'Awaiting Confirmation',
        time: 'Pending',
        isCompleted: false,
      ),
      OrderTimelineEvent(
        title: 'Shipped',
        time: 'Pending',
        isCompleted: false,
      ),
      OrderTimelineEvent(
        title: 'Delivered',
        time: 'Pending',
        isCompleted: false,
      ),
    ],
  ),
];
