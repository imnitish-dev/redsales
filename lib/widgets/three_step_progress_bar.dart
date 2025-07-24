import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;

  const StepProgressBar({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    const stepLabels = ["Order Placed", "Order Received"];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(2, (index) {
        bool isActive = index + 1 <= currentStep;
        bool isLast = index == 1;

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Step Circle
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.pink : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? Colors.pink : Colors.pink.shade200,
                      width: 2,
                    ),
                    boxShadow: [
                      if (isActive)
                        const BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),

                /// Step Label
                SizedBox(
                  width: 80, // ensure labels are aligned
                  child: Text(
                    stepLabels[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: isActive ? Colors.black : Colors.grey,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),

            /// Connector Line (only between steps)
            if (!isLast)
              Container(
                height: 4,
                width: 60, // Fixed connector width
                margin: const EdgeInsets.only(top: 14), // aligns with circle center
                decoration: BoxDecoration(
                  color: (index + 1 < currentStep)
                      ? Colors.pink
                      : Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        );
      }),
    );
  }
}




