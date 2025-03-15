// ignore_for_file: deprecated_member_use

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_club/core/exports.dart';

import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';

class TransportationMap extends StatefulWidget {
  const TransportationMap({super.key});
  @override
  State<TransportationMap> createState() => _TransportationMapState();
}

class _TransportationMapState extends State<TransportationMap> {
  @override
  void initState() {
    super.initState();
    context.read<LocationCubit>().checkAndRequestLocationPermission(context );
  }
  @override
  Widget build(BuildContext context) {
    LocationCubit cubit = context.read<LocationCubit>();
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return cubit.selectedLocation == null
            ? const Center(child: CustomLoadingIndicator())
            : GoogleMap(
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    cubit.selectedLocation?.latitude ?? 0.0,
                    cubit.selectedLocation?.longitude ?? 0.0,
                  ),
                  zoom: 12,
                ),
                onMapCreated: (GoogleMapController controller) {
                  cubit.mapControllerTransportation = controller;
                },
                markers: cubit.transportationMarkers,
          onTap:(LatLng latLng) => cubit.updateTransportationCameraPosition(latLng),
              );
      },
    );
  }
}
