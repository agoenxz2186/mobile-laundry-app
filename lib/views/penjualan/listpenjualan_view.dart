import 'package:flutter/material.dart';
import 'package:laundry_owner/views/penjualan/page_order_baru_view%20copy.dart';
import 'package:laundry_owner/views/penjualan/page_order_baru_view.dart';
import 'package:laundry_owner/views/penjualan/page_order_batal_view.dart';
import 'package:laundry_owner/views/penjualan/page_order_proses_view.dart';
 

class ListPenjualanView extends StatelessWidget { 
  const ListPenjualanView( {super.key});

  @override
  Widget build(BuildContext context) { 

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Jasa / Barang'),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromARGB(255, 240, 219, 187),
            isScrollable: false,
            tabs: [
              Tab(text: 'Baru',),
              Tab(text: 'Proses',),
              Tab(text: 'Selesai',),
              Tab(text: 'Batal',),
            ]),
        ),
        body:  const TabBarView( 
          children: [
            PageOrderBaruView(),
            PageOrderProsesView(),
            PageOrderSelesaiView(),
            PageOrderBatalView(),

          ],
        )
      ),
    );
  }
}