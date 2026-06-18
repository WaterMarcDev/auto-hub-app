import 'package:auto_hub_app/features/payment_methods/presentations/widgets/credit_card_widget.dart';
import 'package:auto_hub_app/features/payment_methods/presentations/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A premium card carousel widget displaying payment cards in a looping stack.
/// Swiping left or right moves cards in a loop with smooth transitions and rotations.
class LoopingCardStack extends StatefulWidget {
  const LoopingCardStack({
    required this.cards,
    required this.onCardChanged,
    super.key,
  });

  final List<PaymentCard> cards;
  final ValueChanged<PaymentCard> onCardChanged;

  @override
  State<LoopingCardStack> createState() => _LoopingCardStackState();
}

class _LoopingCardStackState extends State<LoopingCardStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dragOffset = 0.0;
  int _currentIndex = 0;
  bool _isAnimating = false;

  late Animation<double> _swipeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.addListener(() {
      if (_isAnimating) {
        setState(() {
          _dragOffset = _swipeAnimation.value;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant LoopingCardStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Safety check: ensure _currentIndex is still valid if list shrinks.
    if (_currentIndex >= widget.cards.length) {
      _currentIndex = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_isAnimating || widget.cards.length <= 1) return;
    setState(() {
      _dragOffset += details.delta.dx;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_isAnimating || widget.cards.length <= 1) return;
    final velocity = details.primaryVelocity ?? 0.0;

    // Thresholds to swipe off-screen or snap back
    if (_dragOffset.abs() > 140.w || velocity.abs() > 400.w) {
      _swipeOff(velocity);
    } else {
      _snapBack();
    }
  }

  void _swipeOff(double velocity) {
    _isAnimating = true;
    final endValue = _dragOffset > 0 ? 450.w : -450.w;

    _swipeAnimation = Tween<double>(begin: _dragOffset, end: endValue).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward(from: 0.0).then((_) {
      setState(() {
        if (_dragOffset > 0) {
          // Swipe Right: Show previous card
          _currentIndex = (_currentIndex - 1 + widget.cards.length) %
              widget.cards.length;
        } else {
          // Swipe Left: Show next card
          _currentIndex = (_currentIndex + 1) % widget.cards.length;
        }
        _dragOffset = 0.0;
        _isAnimating = false;
      });
      widget.onCardChanged(widget.cards[_currentIndex]);
    });
  }

  void _snapBack() {
    _isAnimating = true;
    _swipeAnimation = Tween<double>(begin: _dragOffset, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward(from: 0.0).then((_) {
      setState(() {
        _dragOffset = 0.0;
        _isAnimating = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) return const SizedBox.shrink();

    final cardCount = widget.cards.length;
    final frontIndex = _currentIndex;

    // If there is only 1 card, render it statically without swiping physics.
    if (cardCount == 1) {
      return Container(
        height: 224.h,
        alignment: Alignment.topCenter,
        child: CreditCardWidget(card: widget.cards[0]),
      );
    }

    final middleIndex = (frontIndex + 1) % cardCount;
    final backIndex = (frontIndex + 2) % cardCount;
    final dragProgress = (_dragOffset.abs() / 300.w).clamp(0.0, 1.0);

    return Container(
      height: 224.h,
      alignment: Alignment.topCenter,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // 3. Back Card (rendered lowest in paint order)
          if (cardCount >= 3)
            _buildStackedCard(
              card: widget.cards[backIndex],
              stackPosition: 2,
              dragProgress: dragProgress,
            ),

          // 2. Middle Card
          _buildStackedCard(
            card: widget.cards[middleIndex],
            stackPosition: 1,
            dragProgress: dragProgress,
          ),

          // 1. Front Card (painted last to sit on top)
          GestureDetector(
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            child: Transform.translate(
              offset: Offset(_dragOffset, _dragOffset.abs() * 0.08),
              child: Transform.rotate(
                angle: (_dragOffset / 400.w) * 0.15, // Sleek rotation
                child: CreditCardWidget(
                  card: widget.cards[frontIndex],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds stacked cards behind the active card with scales, offsets, and opacities.
  Widget _buildStackedCard({
    required PaymentCard card,
    required int stackPosition,
    required double dragProgress,
  }) {
    double scale = 1.0;
    double offset = 0.0;
    double opacity = 1.0;

    if (stackPosition == 1) {
      // Middle Card: Interpolates scale from 0.94 to 1.0, and offset from -14.h to 0.h.
      scale = 0.94 + (dragProgress * 0.06);
      offset = -14.h + (dragProgress * 14.h);
      opacity = 0.9 + (dragProgress * 0.1);
    } else if (stackPosition == 2) {
      // Back Card: Interpolates scale from 0.88 to 0.94, and offset from -28.h to -14.h.
      scale = 0.88 + (dragProgress * 0.06);
      offset = -28.h + (dragProgress * 14.h);
      opacity = 0.6 + (dragProgress * 0.3);
    }

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Opacity(
        opacity: opacity.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, offset),
          child: Transform.scale(
            scale: scale,
            child: CreditCardWidget(card: card),
          ),
        ),
      ),
    );
  }
}
