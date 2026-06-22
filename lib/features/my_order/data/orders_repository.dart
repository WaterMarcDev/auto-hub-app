import 'package:auto_hub_app/features/my_order/data/mock_orders_data.dart';
import 'package:auto_hub_app/features/my_order/domain/models/order_model.dart';
import 'package:flutter/material.dart';

class OrdersRepository {
  OrdersRepository._();
  static final OrdersRepository instance = OrdersRepository._();

  final ValueNotifier<List<Order>> ordersNotifier =
      ValueNotifier<List<Order>>(List.from(mockOrders));


  List<Order> getOrders() => ordersNotifier.value;

  Order? getOrderById(String id) {
    for (final order in ordersNotifier.value) {
      if (order.id == id) {
        return order;
      }
    }
    return null;
  }

  String _formatDateTime(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final month = months[dt.month - 1];
    final day = dt.day;
    final hour24 = dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = hour24 >= 12 ? 'PM' : 'AM';
    var hour = hour24 % 12;
    if (hour == 0) hour = 12;
    return '$month $day, $hour:$minute $period';
  }

  void cancelOrder(String id) {
    final list = List<Order>.from(ordersNotifier.value);
    final index = list.indexWhere((o) => o.id == id);
    if (index != -1) {
      final currentOrder = list[index];
      
      final orderPlacedEvent = currentOrder.timeline.firstWhere(
        (e) => e.title == 'Order Placed',
        orElse: () => OrderTimelineEvent(
          title: 'Order Placed',
          time: _formatDateTime(currentOrder.date),
          isCompleted: true,
        ),
      );

      final nowString = _formatDateTime(DateTime.now());
      final updatedTimeline = [
        orderPlacedEvent,
        OrderTimelineEvent(
          title: 'Cancelled',
          time: nowString,
          isCompleted: true,
        ),
      ];
      list[index] = currentOrder.copyWith(
        status: OrderStatus.cancelled,
        timeline: updatedTimeline,
      );
      ordersNotifier.value = list;
    }
  }
}
