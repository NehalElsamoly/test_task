import 'package:easy_localization/easy_localization.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/core/widgets/network_image.dart';
import 'package:travel_club/features/my_account/cubit/account_cubit.dart';

import '../../../my_account/cubit/account_state.dart';

class CustomHomeAppbar extends StatefulWidget {
  const CustomHomeAppbar({super.key, this.isHome = false, this.title});
  final bool isHome;
  final String? title;

  @override
  State<CustomHomeAppbar> createState() => _CustomHomeAppbarState();
}

class _CustomHomeAppbarState extends State<CustomHomeAppbar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AccountCubit>();
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (BuildContext context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getHorizontalPadding(context),
              vertical: getVerticalPadding(context)),
          child: Row(children: [
            if (widget.isHome == true) ...[
             // Text("nono"),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 30.w,
                        child: Image.asset(
                          ImageAssets.profile,
                          color: AppColors.white,
                        ),
                      ),
              ),
              SizedBox(
                width: getWidthSize(context) * 0.05,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          AppConst.isLogged
                              ? AppTranslations.welcome
                              : AppTranslations.hi,
                          style: getMediumStyle(
                              fontSize: 14.sp, color: AppColors.grey)),
                      Text(
                          AppTranslations.guest,
                          style: getSemiBoldStyle(
                              color: AppColors.blue, fontSize: 18.sp))
                    ]),
              ),
            ] else ...[
              Expanded(
                child: Row(
                  children: [
                    CustomBackButton(),
SizedBox(width: 5.w,),
                    Text(widget.title!,
                        style: getSemiBoldStyle(
                            color: AppColors.blue, fontSize: 18.sp)),
                  ],
                ),
              ),
            ],
            SizedBox(
              width: getWidthSize(context) * 0.05,
            ),
          widget.isHome==false? Container():
          GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.accountScreen);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child:Icon(Icons.settings,color: AppColors.primary,)
                        )),
                  )

          ]),
        );
      },
    );
  }
}
