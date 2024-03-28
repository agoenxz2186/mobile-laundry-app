import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:latlong2/latlong.dart';
import 'package:laundry_owner/utils/global_variable.dart';

class MapChoiceView extends StatefulWidget {
  final LatLng? latLng;
  const MapChoiceView({super.key, this.latLng});

  @override
  State<MapChoiceView> createState() => _MapChoiceViewState();
}

class _MapChoiceViewState extends State<MapChoiceView> {
  late LatLng _latLng;

  @override
  void initState() {
    super.initState();
    _latLng = widget.latLng ?? (Global.currentLocation ?? const LatLng(0, 0));
  } 

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pilih titik lokasi'),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: (){
            Navigator.pop(context, _latLng);
          },
          child: const Icon(MdiIcons.mapCheck),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FlutterMap(
          options: MapOptions(
            initialCenter: Global.currentLocation ?? const LatLng(0, 0),
            initialZoom: 18
          ),
          children: [
            TileLayer(
              urlTemplate: 'http://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
            ),
            DragMarkers(
              markers: [
                DragMarker(point: _latLng, 
                  onDragEnd: (details, latLng) {
                      _latLng = latLng; 
                  },
                  builder: (context, pos, isDragging) {
                    return const Icon(MdiIcons.mapMarker, color: Colors.red,
                      size: 44,
                    );
                  }, size: const Size(44, 44))
              ],
            )
          ],
        ),
    );
  }
}
 