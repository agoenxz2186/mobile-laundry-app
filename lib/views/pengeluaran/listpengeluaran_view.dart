import 'package:flutter/material.dart';
import 'package:laundry_owner/views/pengeluaran/page_bulan_ini_view.dart';

class ListPengeluaranView extends StatelessWidget {
  const ListPengeluaranView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pengeluaran'),
          bottom: const TabBar(
            labelStyle: TextStyle(color: Colors.white),
            unselectedLabelStyle: TextStyle(color: Color.fromARGB(255, 209, 185, 150)),
            tabs: [
              Tab(text: 'Bulan ini',),
              Tab(text: 'Bulan Lainnya',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
              PageBulanIniView(),
              Text('Bulan lainnya'),
          ],
        ),
      ),
    );
  }
}