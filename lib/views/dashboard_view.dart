import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:laundry_owner/providers/dashboard_provider.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/views/home_view.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('L-Dry Management '),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange.shade200,
          tooltip: 'Catat pemesanan baru',
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {},
          child: const Icon(
            MdiIcons.basket,
            color: Colors.red,
          ),
        ),
        body: const HomeView(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar:
            Consumer<DashboardProvider>(builder: (context, prov, w) {
          return AnimatedBottomNavigationBar(
            icons: const [
              MdiIcons.home,
              MdiIcons.clipboardListOutline,
              MdiIcons.wallet,
              MdiIcons.clipboardAccount,
            ],
            gapLocation: GapLocation.center,
            leftCornerRadius: 12,
            rightCornerRadius: 12,
            inactiveColor: Colors.grey,
            activeColor: Colors.deepOrange,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            activeIndex: prov.getActiveIndex(),
            onTap: (p0) {
              logD(p0);
              prov.setActiveIndex(p0);
            },
          );
        }));
  }
}
