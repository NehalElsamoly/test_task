import 'package:travel_club/features/home/cubit/home_cubit.dart';
import 'package:travel_club/features/home/cubit/home_state.dart';
import '../../../core/exports.dart';
import 'widgets/custom_offers_section.dart';

class NewOffersScreen extends StatelessWidget {
  const NewOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return CustomScreen(
            appbarTitle: AppTranslations.newOffers,
            body: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return CustomOffersContainer(
                  isLast: true,
                  isHome: false,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: getVerticalPadding(context) * 1,
                );
              },
              itemCount: 20,
            ));
      },
    );
  }
}
