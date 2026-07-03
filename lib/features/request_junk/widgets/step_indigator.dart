import 'package:auto_hub_app/core/constants/app_icons.dart';
import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final Color? completedColor;
  final Color? surfaceColor;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
    this.activeColor,
    this.inactiveColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.completedColor,
    this.surfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = activeColor ?? colorScheme.primary;
    final outlineColor = inactiveColor ?? colorScheme.outlineVariant;
    final inactiveTxtColor = inactiveTextColor ?? colorScheme.onSurfaceVariant;
    final complColor = completedColor ?? primaryColor;
    final surfColor = surfaceColor ?? colorScheme.surface;
    final actTxtColor = activeTextColor ?? primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background Connecting Line
          Positioned(
            left: 40,
            right: 40,
            top: 18,
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                color: outlineColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Active Progress Line
          Positioned(
            left: 40,
            right: 40,
            top: 18,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final progressWidth =
                    steps.length > 1
                        ? (constraints.maxWidth / (steps.length - 1)) *
                            currentStep
                        : 0.0;
                return Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: progressWidth,
                      height: 2,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Step Circles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (index) {
              final isCompleted = index < currentStep;
              final isActive = index == currentStep;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color:
                          isActive || isCompleted
                              ? (isActive ? surfColor : complColor)
                              : surfColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isActive || isCompleted
                                ? primaryColor
                                : outlineColor,
                        width: 2,
                      ),
                      boxShadow:
                          isActive
                              ? [
                                BoxShadow(
                                  color: primaryColor.withValues(alpha: 0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ]
                              : null,
                    ),
                    child: Center(
                      child:
                          isCompleted
                              ? const Icon(
                                AppIcons.check,
                                color: Colors.white,
                                size: 18,
                              )
                              : Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color:
                                      isActive || isCompleted
                                          ? (isActive
                                              ? actTxtColor
                                              : Colors.white)
                                          : inactiveTxtColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    steps[index],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          isActive || isCompleted
                              ? FontWeight.w600
                              : FontWeight.normal,
                      color:
                          isActive || isCompleted
                              ? primaryColor
                              : inactiveTxtColor,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}