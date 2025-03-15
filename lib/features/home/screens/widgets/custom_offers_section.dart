import 'package:flutter/cupertino.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/core/widgets/network_image.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../../data/models/home_model.dart';


class CustomOffersContainer extends StatelessWidget {
   CustomOffersContainer({
    this.isLast = false,
    this.isHome = true,


    this.title = '',
    this.description = '',
    this.image = '',
    super.key,

  });
  final bool isLast;
  final bool isHome;
  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (BuildContext context, state) { return Padding(
      padding: EdgeInsetsDirectional.only(
          start: getHorizontalPadding(context),
          end: isLast ? getHorizontalPadding(context) : 0,
          bottom: getHeightSize(context) * 0.01),
      child: CustomContainerWithShadow(
          width: isHome ? getWidthSize(context) * 0.8 : null,
          height: isHome ? null : getHeightSize(context) * 0.34,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: CustomNetworkImage(
                  //"https://media.istockphoto.com/id/1859856017/fi/valokuva/nopea-internet-yhteys-nopeustestaa-verkon-kaistanleveystekniikka-mies-joka-k%C3%A4ytt%C3%A4%C3%A4-nopeaa.jpg?s=1024x1024&w=is&k=20&c=ffjK54jdpR-8egYRmNMGzFqWEh42B9HSAEO1_waKD0U=",
                  // "https://lotel.efaculty.tech/storage/cities/85531735112807.webp",
                 // fit: BoxFit.cover,
                  width: isHome
                      ? getWidthSize(context) * 0.8
                      : getWidthSize(context),
                  height: getHeightSize(context) * 0.2, image: image??""      ,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontalPadding(context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: AutoSizeText(
                              maxLines: 1,
                          title??"",
                              style: getMediumStyle(fontSize: 14.sp),
                            ),
                          ),
                          // Icon(
                          //   CupertinoIcons.heart,
                          //   color: AppColors.primary,
                          //   size: 25.sp,
                          // )
                        ],
                      ),
                      AutoSizeText(
                        // AppTranslations.newOffers +
                        //     " " +
                        // AppTranslations.newOffers +
                        // " " +
                        // AppTranslations.newOffers +
                     description??""  ,
                        maxLines: 2,
                        style: getRegularStyle(
                            color: AppColors.grey, fontSize: 14.sp),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    ); },);
  }
}
