// ignore_for_file: deprecated_member_use

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_club/core/exports.dart';

import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';

class AccomodationMap extends StatefulWidget {
  const AccomodationMap({super.key, required this.markers});
  final Set<Marker> markers;

  @override
  State<AccomodationMap> createState() => _AccomodationMapState();
}

class _AccomodationMapState extends State<AccomodationMap> {
  @override
  void initState() {
    super.initState();
    // context.read<LocationCubit>().checkAndRequestLocationPermission(context);
  }

  @override
  Widget build(BuildContext context) {
    LocationCubit cubit = context.read<LocationCubit>();
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return GoogleMap(
          mapType: MapType.terrain,

          // zoomGesturesEnabled: true,
          trafficEnabled: false,

          initialCameraPosition: CameraPosition(
            target: widget.markers.isNotEmpty
                ? widget.markers.first.position
                : LatLng(
                    cubit.currentLocation?.latitude ?? 0.0,
                    cubit.currentLocation?.longitude ?? 0.0,
                  ),
            zoom: 10,
          ),
          onMapCreated: (GoogleMapController controller) {
            cubit.mapControllerAccommodation = controller;
          },
          markers: widget.markers,
        );
      },
    );
  }
}
