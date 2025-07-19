import 'package:flutter/material.dart';

class ThreeStepProgressBar extends StatelessWidget {
  final int currentStep; // 1, 2, or 3 (current active step)

  const ThreeStepProgressBar({Key? key, required this.currentStep})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        bool isActive = index + 1 <= currentStep; // highlight circle
        bool isLast = index == 2;

        return Expanded(
          child: Row(
            children: [
              /// Step Circle
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isActive ? Colors.pink : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive ? Colors.pink : Colors.pink.shade200,
                    width: 2,
                  ),
                  boxShadow: [
                    if (isActive)
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      )
                  ],
                ),
              ),

              /// Connector line (only highlight if both circles are active)
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: (index + 1 < currentStep)
                          ? Colors.pink // only highlight if previous step completed
                          : Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
