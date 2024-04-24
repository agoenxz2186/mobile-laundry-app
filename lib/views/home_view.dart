import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/get.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/views/karyawan/listkaryawan_view.dart';
import 'package:laundry_owner/views/metodebayar/select_outlet_view.dart';
import 'package:laundry_owner/views/outlet/listoutlet_view.dart';
import 'package:laundry_owner/views/pelanggan/listpelanggan_view.dart';
import 'package:laundry_owner/views/pemasukan/select_outlet_view.dart';
import 'package:laundry_owner/views/pengeluaran/select_outlet_view.dart';
import 'package:laundry_owner/views/penjualan/listpenjualan_view.dart';
import 'package:laundry_owner/views/produk/listproduk_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          color: const Color.fromARGB(255, 240, 100, 19),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${Global.auth?.fullName}",
                      style: const TextStyle(color: Colors.white, fontSize: 29),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const _MenuData()
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuData extends StatelessWidget {
  const _MenuData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow:  [
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 0.7,
                color: Color.fromARGB(255, 219, 216, 216))
          ]),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        children: [
          _ItemMenuDashboard(
            onTap: () {
               Get.to(()=>const ListOutletView());
            },
            icon: const Icon(
              MdiIcons.store,
              size: 32,
              color: Color.fromARGB(255, 243, 72, 4),
            ),
            title: 'Outlet',
          ),
          _ItemMenuDashboard(
            onTap: () {
              Get.to(()=>const ListProdukView());
            },
            icon: const Icon(
              MdiIcons.iron,
              size: 32,
            ),
            title: 'Produk / Jasa',
          ),
          _ItemMenuDashboard(
            onTap: () {
              Get.to(()=>const ListKaryawanView());
            },
            icon: const Icon(
              MdiIcons.cardAccountDetails,
              size: 32,
              color: Colors.blue,
            ),
            title: 'Karyawan',
          ),
          _ItemMenuDashboard(
            onTap: () {
              Get.to(()=>const ListPelangganView());
            },
            icon: const Icon(
              MdiIcons.accountMultiple,
              size: 32,
              color: Color.fromARGB(255, 111, 5, 172),
            ),
            title: 'Pelanggan',
          ),
          _ItemMenuDashboard(
            onTap: () {
              Get.to(()=>const SelectOutletView());
            },
            icon: const Icon(
              MdiIcons.creditCard,
              size: 32,
              color: Color.fromARGB(255, 3, 133, 7),
            ),
            title: 'Metode Bayar',
          ),
          _ItemMenuDashboard(
            onTap: () {
              Get.to(()=>const SelectOutletPengeluaranView());
            },
            icon: const Icon(
              MdiIcons.cashMinus,
              size: 32,
              color: Color.fromARGB(255, 209, 42, 42),
            ),
            title: 'Pengeluar-an',
          ),
          _ItemMenuDashboard(
            onTap: () {
               Get.to(()=>const SelectOutletPemasukanView());
            },
            icon: const Icon(
              MdiIcons.cashPlus,
              size: 32,
              color: Color.fromARGB(255, 2, 131, 30),
            ),
            title: 'Pemasukan',
          ),
          _ItemMenuDashboard(
            onTap: () {
               Get.to(()=>const ListPenjualanView());
            },
            icon: const Icon(
              MdiIcons.washingMachine,
              size: 32,
              color: Color.fromARGB(255, 10, 66, 219),
            ),
            title: 'Penjualan / Jasa',
          ),
          _ItemMenuDashboard(
            onTap: () {},
            icon: const Icon(
              MdiIcons.bookAccount,
              size: 32,
              color: Color.fromARGB(255, 5, 108, 116),
            ),
            title: 'Jurnal Kas',
          ),
        ],
      ),
    );
  }
}

class _ItemMenuDashboard extends StatelessWidget {
  final String title;
  final Widget? icon;
  final VoidCallback? onTap;

  const _ItemMenuDashboard({super.key, this.icon, this.onTap, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        splashColor: const Color.fromARGB(255, 247, 229, 215),
        child: Container(
          width: 66,
          height: 75,
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              icon ?? const SizedBox.shrink(),
              Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
              )
            ],
          ),
        ),
      ),
    );
  }
}
