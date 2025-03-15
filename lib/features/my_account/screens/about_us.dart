

import 'package:easy_localization/easy_localization.dart';
import 'package:travel_club/features/my_account/screens/widgets/custom_container.dart';

import '../../../core/exports.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../cubit/account_cubit.dart';
import '../cubit/account_state.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<AccountCubit>().getHomeData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit=context.read<AccountCubit>();
    return BlocBuilder<AccountCubit, AccountState>(builder: (BuildContext context, state) {
      return  RefreshIndicator(
        onRefresh: () {
          return cubit.getHomeData();
        },
        child: CustomScreen(
            appbarTitle: AppTranslations.aboutUs,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: getVerticalPadding(context) * .5,),
                  //imag
                  Center(
                    child: Image.asset(
                      ImageAssets.logoImage,
                      height: 140.h,
                       width:100.w,
                    ),
                  ),
                  SizedBox(height: getVerticalPadding(context) * .5,),

                  Expanded(
                    // height: ,
                      child:cubit.dataList==null?Center(child: CircularProgressIndicator(),):
                          cubit.dataList!.isEmpty?Center(child: NoDataWidget(title: "no_data".tr(),)):
                      ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                           CustomContainer(title: cubit.dataList![index].title.toString(), desc: cubit.dataList![index].body.toString()),
                        itemCount:5,
                        scrollDirection: Axis.vertical, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5.h,); },
                      )),
        SizedBox(height: 60.h,)
                ],
              ),
            )
        ),
      );
    },);
  }
}
