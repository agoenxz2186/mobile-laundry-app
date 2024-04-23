import 'package:flutter/material.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/views/pemasukan/page_bulan_ini_view.dart';
import 'package:laundry_owner/views/pemasukan/page_bulan_lainnya_view.dart';

class ListPemasukanView extends StatelessWidget {
  final LaundryOutletModel lo;
  const ListPemasukanView({super.key, required this.lo});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pemasukan'),
              Text('${lo.name}', style: const TextStyle(fontSize: 12),)
            ],
          ),
          
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
              PageBulanIniView(lo),
              PageBulanLainnyaView(lo)
          ],
        ),
      ),
    );
  }
}