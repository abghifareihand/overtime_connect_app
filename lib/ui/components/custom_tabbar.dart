import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';

class CustomTabbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final String leftLabel;
  final String rightLabel;

  const CustomTabbar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.leftLabel,
    required this.rightLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.secondary,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColor.primary,
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment: selectedIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5 - 20,
              height: 50,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onTabSelected(0),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.transparent,
                    foregroundColor: selectedIndex == 0 ? AppColor.white : AppColor.primary,
                    side: BorderSide.none,
                  ),
                  child: Text(
                    leftLabel,
                    style: TextStyle(
                      fontWeight: selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                      color: selectedIndex == 0 ? AppColor.white : AppColor.primary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onTabSelected(1),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.transparent,
                    foregroundColor: selectedIndex == 1 ? AppColor.white : AppColor.primary,
                    side: BorderSide.none,
                  ),
                  child: Text(
                    rightLabel,
                    style: TextStyle(
                      fontWeight: selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                      color: selectedIndex == 1 ? AppColor.white : AppColor.primary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
