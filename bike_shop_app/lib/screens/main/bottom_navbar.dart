import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/screen_index_value.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final List<String> selectedItemIcon;
  final List<String> unselectedItemIcon;
  final List<String> label;
  final ScreenIndexProvider manager;

  const BottomNavBar({
    Key? key,
    required this.selectedItemIcon,
    required this.unselectedItemIcon,
    required this.label,
    required this.manager,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<String> _selectedItemIcon = [];
  List<String> _unselectedItemIcon = [];
  List<String> _label = [];

  @override
  void initState() {
    super.initState();
    _selectedItemIcon = widget.selectedItemIcon;
    _unselectedItemIcon = widget.unselectedItemIcon;
    _label = widget.label;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItems = [];

    for (int i = 0; i < 3; i++) {
      _navBarItems.add(
        bottomNavBarItem(
          _selectedItemIcon[i],
          _unselectedItemIcon[i],
          _label[i],
          i,
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: darkBlue500,
        borderRadius: BorderRadius.vertical(top: borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _navBarItems,
      ),
    );
  }

  Widget bottomNavBarItem(activeIcon, inactiveIcon, label, index) {
    final currentIndex = widget.manager.index;
    return GestureDetector(
      onTap: () {
        widget.manager.setCurrentIndex(index);
      },
      child: Container(
        height: kBottomNavigationBarHeight,
        width: MediaQuery.of(context).size.width / _selectedItemIcon.length,
        decoration: const BoxDecoration(
          color: darkBlue500,
          borderRadius: BorderRadius.vertical(top: borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: currentIndex == index
              ? Container(
                  decoration: BoxDecoration(
                    color: primaryColor700,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        activeIcon,
                        width: 22,
                        height: 22,
                        color: colorYellow,
                      ),
                      Text(
                        label,
                        style: bottomNavTextStyle.copyWith(color: colorWhite),
                      )
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      inactiveIcon,
                      width: 22,
                      height: 22,
                      color: colorYellow,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
