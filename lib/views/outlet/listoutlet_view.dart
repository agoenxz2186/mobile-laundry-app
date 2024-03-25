import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:laundry_owner/components/widgets.dart';
import 'package:laundry_owner/models/laundry_outlet_model.dart';
import 'package:laundry_owner/providers/listoutlet_provider.dart';
import 'package:laundry_owner/views/outlet/formoutlet_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListOutletView extends StatelessWidget {
  const ListOutletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ListOutletProvider>(builder: (context, prov, w) {
   
      return Scaffold(
        appBar: AppBar(
          title: const Text('Outlet Laundry'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const FormOutletView()))
                .then((value) {
              if (value == true) prov.refresh();
            });
          },
          child: const Icon(MdiIcons.storeEdit),
        ),
        body: SmartRefresher(
          controller: prov.refreshController,
          onLoading: () {
            prov.loadmore();
          },
          onRefresh: () {
            prov.refresh();
          },
          child: ListView(
            children: [
              if (prov.data.isEmpty)
                const EmptyData()
              else
                for (LaundryOutletModel v in prov.data) 
                  ListTile(
                    leading: Image.network(
                      v.icon(),
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(MdiIcons.store, size: 38,color: Colors.grey,);
                      },
                    ),
                    title: Text('${v.name}', style: const TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${v.address}, ${v.city ?? ''} ${v.district ?? ''}'),
                        Text('${v.phone}')
                      ],
                    ),
                  )
            ],
          ),
        ),
      );
    });
  }
}
