import 'package:easy_localization/easy_localization.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/features/my_account/cubit/account_cubit.dart';
import '../../my_account/screens/widgets/custom_container.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'widgets/custom_appbar.dart';
import 'widgets/custom_offers_section.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    if (context.read<HomeCubit>().homeModel.data == null) {
      //  context.read<HomeCubit>().getHomeData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return RefreshIndicator(
              onRefresh: () async {

              },
              child: Column(children: [
                SizedBox(height: getVerticalPadding(context) * 2),
                const CustomHomeAppbar(
                  isHome: true,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: 10.h,
                      ),
                      //search container

                      SizedBox(
                        height: 10.h,
                      ),

                      SizedBox(
                          height: getHeightSize(context) * 0.34,
                          child: ListView.builder(
                            itemBuilder: (context, index) => CustomOffersContainer(
                              isLast: index == 2,
                             title: "Test title",
                  description: "test descrebtion ",
                              image: "https://th.bing.com/th/id/R.17537dd217378f4f3c7d7ec8c22a6189?rik=h4REzWqODcgn5w&riu=http%3a%2f%2ftruechristianity.info%2fimg%2fgod_has_created_this%2fbig%2fflowers_wikimedia_0017_big.jpg&ehk=TM9ORS%2fkZuPGMYutP%2b9T%2fciKCMPFNqOTAj7OA00bAV0%3d&risl=&pid=ImgRaw&r=0",
                            ),
                            itemCount:3,
                            scrollDirection: Axis.horizontal,
                          )), 
                      Expanded(
                        // height: ,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                            const CustomContainer(title: 'nehal test title', desc: ' nehal test descrebtion',),
                            itemCount:5,
                            scrollDirection: Axis.vertical, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5.h,); },
                          ))

                    ],
                  ),
                ),
              ]),
            );
    });
  }
}
