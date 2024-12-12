// features/nav_bar/presentation/page/nav_bar_screen.dart

import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/features/cart/data/presentation/cart_screen.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:bookia/features/profile/presentation/pages/profile_screen.dart';
import 'package:bookia/features/wishlist/presentation/views/wishlist_scrren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  List<Widget> pages = [
    const HomeScreen(),
    const WishlistView(),
    const CartView(),
    const ProfileView()
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Home.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/Home.svg',
                colorFilter: const ColorFilter.mode(
                    AppColor.primaryColor, BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Bookmark.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/Bookmark.svg',
                colorFilter: const ColorFilter.mode(
                    AppColor.primaryColor, BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Category.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/Category.svg',
                colorFilter: const ColorFilter.mode(
                    AppColor.primaryColor, BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Profile.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/Profile.svg',
                colorFilter: const ColorFilter.mode(
                    AppColor.primaryColor, BlendMode.srcIn),
              ),
              label: '',
            ),
          ]),
    );
  }
}
