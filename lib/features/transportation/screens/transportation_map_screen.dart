// ignore_for_file: deprecated_member_use

import 'package:travel_club/core/exports.dart';
import 'package:travel_club/features/location/cubit/location_cubit.dart';
import 'package:travel_club/features/location/cubit/location_state.dart';
import 'package:travel_club/features/location/screens/transportation_map.dart';

class TransportationMapScreen extends StatefulWidget {
  const TransportationMapScreen({super.key});
  @override
  State<TransportationMapScreen> createState() =>
      _TransportationMapScreenState();
}

class _TransportationMapScreenState extends State<TransportationMapScreen> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      height: getHeightSize(context),
      child: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: getHeightSize(context),
              child: const TransportationMap()),

        ],
      ),
    );
  }
}
