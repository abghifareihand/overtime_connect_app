import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overtime_connect_app/core/assets/assets.gen.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/menu/calculator/calculator_view.dart';
import 'package:overtime_connect_app/features/menu/history/history_view.dart';
import 'package:overtime_connect_app/features/menu/home/home_view.dart';
import 'package:overtime_connect_app/features/menu/menu_view_model.dart';
import 'package:overtime_connect_app/features/menu/profile/profile_view.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MenuViewModel>(
      model: MenuViewModel(),
      onModelReady: (MenuViewModel model) => model.initModel(),
      onModelDispose: (MenuViewModel model) => model.disposeModel(),
      builder: (BuildContext context, MenuViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: IndexedStack(
            index: model.selectedIndex,
            children: [
              HomeView(),
              HistoryView(),
              CalculatorView(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: _buildBottomNavBar(context, model),
          ),
        );
      },
    );
  }
}

// Widget _buildBody(BuildContext context, MenuViewModel model) {
//   switch (model.selectedIndex) {
//     case 0:
//       return HomeView();
//     case 1:
//       return HistoryView();
//     case 2:
//       return CalculatorView();
//     case 3:
//       return ProfileView();
//     default:
//       return Center(child: const Text('Home'));
//   }
// }

Widget _buildBottomNavBar(BuildContext context, MenuViewModel model) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColor.primary,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNavItem(
          iconPath: Assets.svg.navHome.path,
          label: "Home",
          isSelected: model.selectedIndex == 0,
          onTap: () => model.onTabSelected(0),
        ),
        _buildNavItem(
          iconPath: Assets.svg.navHistory.path,
          label: "History",
          isSelected: model.selectedIndex == 1,
          onTap: () => model.onTabSelected(1),
        ),
        _buildNavItem(
          iconPath: Assets.svg.navCalculate.path,
          label: "Calculator",
          isSelected: model.selectedIndex == 2,
          onTap: () => model.onTabSelected(2),
        ),
        _buildNavItem(
          iconPath: Assets.svg.navProfile.path,
          label: "Profile",
          isSelected: model.selectedIndex == 3,
          onTap: () => model.onTabSelected(3),
        ),
      ],
    ),
  );
}

Widget _buildNavItem({
  required String iconPath,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isSelected ? AppColor.white : AppColor.primary,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColor.primary : AppColor.white,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          if (isSelected) ...[
            const SizedBox(width: 2),
            Text(
              label,
              style: AppFont.semiBold.copyWith(
                color: AppColor.primary,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
