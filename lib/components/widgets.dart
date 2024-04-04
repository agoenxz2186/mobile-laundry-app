import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class EmptyData extends StatelessWidget {
  final String? pesan;
  const EmptyData({super.key, this.pesan});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            MdiIcons.selectSearch,
            size: 150,
            color: Color.fromARGB(255, 253, 230, 204),
          ),
          Text(pesan ?? 'Belum ada data tersedia saat ini.'),
        ],
      )),
    );
  }
}



class LabelInfo extends StatelessWidget {
  const LabelInfo({
    super.key,
    required this.label,
  });

  final Widget label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 38, 200, 250),
        borderRadius: BorderRadius.circular(20)
      ),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: label));
  }
}
