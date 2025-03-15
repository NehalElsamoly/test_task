// ignore_for_file: deprecated_member_use

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_club/core/exports.dart';

import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';

class PositionMap extends StatefulWidget {
  const PositionMap({super.key, required this.lat, required this.long});
  final double lat;
  final double long;
  @override
  State<PositionMap> createState() => _PositionMapState();
}

class _PositionMapState extends State<PositionMap> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context
            .read<LocationCubit>()
            .getAddressFromLatLng(widget.lat, widget.long);
      }
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   context.read<LocationCubit>().mapControllerPosition?.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    LocationCubit cubit = context.read<LocationCubit>();
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTranslations.locationOnMap,
              style: getMediumStyle(
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 10.h),
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              child: Container(
                width: double.infinity,
                height: getHeightSize(context) * 0.3,
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: getHeightSize(context) * 0.3,
                        child: GoogleMap(
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          mapType: MapType.normal,
                          onTap: (argument) {
                            print("sssssssssss");
                            cubit.openGoogleMapsRoute(widget.lat, widget.long);
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              widget.lat,
                              widget.long,
                            ),
                            zoom: 10,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            cubit.mapControllerPosition = controller;
                          },
                          markers: {
                            Marker(
                              markerId: const MarkerId('currentLocation'),
                              icon: cubit.markerIcon != null
                                  ? BitmapDescriptor.bytes(cubit.markerIcon!)
                                  : BitmapDescriptor.defaultMarker,
                              position: LatLng(
                                widget.lat,
                                widget.long,
                              ),
                            ),
                          },
                        )),
                    PositionedDirectional(
                      bottom: 10.0,
                      end: 10.0,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: getWidthSize(context) * 0.7),
                        child: Container(
                          // width: getWidthSize(context) * 0.7,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          // alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cubit.address,
                              maxLines: 2,
                              style: getMediumStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
