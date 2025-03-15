import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/features/home/cubit/home_cubit.dart';

import '../../my_account/cubit/account_cubit.dart';

class CheckInternetWidget extends StatefulWidget {
  const CheckInternetWidget({super.key, this.whenResumed, required this.child});
  final void Function()? whenResumed;
  final Widget child;

  @override
  State<CheckInternetWidget> createState() => _CheckInternetWidgetState();
}

class _CheckInternetWidgetState extends State<CheckInternetWidget> {
  ConnectivityResult _connectionStatus = ConnectivityResult.wifi;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isDialogOpen = false;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) return;
    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });

    if (result == ConnectivityResult.none) {
      _showNoInternetDialog();
    } else {
      _fetchOnlineData();
    }
  }

  void _showNoInternetDialog() async {
    if (_isDialogOpen) return;
    _isDialogOpen = true;

    showDialog(
      context: context,
      barrierDismissible: false, // يمنع إغلاق الديالوج عن طريق النقر خارج النافذة
      builder: (context) => AlertDialog(
        title: Text("No Internet Connection"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.wifi_slash, size: 80, color: Colors.red),
            SizedBox(height: 10),
            Text("You are offline. Loading saved data..."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              _isDialogOpen = false;
              await _loadOfflineData();
            },
            child: Text("Load Offline Data"),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchOnlineData() async {
    try {
      final cubit = context.read<AccountCubit>();
      await cubit.getHomeData();
      _saveDataLocally(cubit.dataList);
    } catch (e) {
      developer.log('Error fetching data: $e');
    }
  }

  Future<void> _saveDataLocally(List<dynamic>? data) async {
    if (data == null) return;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("cachedData", data.toString());
  }

  Future<void> _loadOfflineData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString("cachedData");
    if (cachedData != null) {
      developer.log("Loaded offline data: $cachedData");
    } else {
      developer.log("No offline data available.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          // Icons.error,
          CupertinoIcons.wifi_exclamationmark,
          size: 180.h,
          color: AppColors.primary,
        ),
        20.h.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppTranslations.someThingWrong,
              style: getMediumStyle(
                color: AppColors.grey,
              ),
            ),
          ],
        ),
        10.h.verticalSpace,
        InkWell(
          onTap: onTap,
          child: Icon(
            // Icons.error,
            CupertinoIcons.refresh_thin,
            size: 50.h,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
