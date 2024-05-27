import 'package:bocekilaclama/export.dart';

class HomeCarousel extends StatelessWidget {
  HomeCarousel({
    super.key,
  });

  final List<Widget> carouselSliderItems = [
    const PlaceCard(
      placePhotoUrl: 'assets/images/tombs_kings.jpg',
      placeName: 'Tombs of the Kings',
    ),
    const PlaceCard(
      placePhotoUrl: 'assets/images/kolos_custle.JPG',
      placeName: 'Kolos Castle',
    ),
    const PlaceCard(
      placePhotoUrl: 'assets/images/ayios_Lazarus.jpg',
      placeName: 'Ayios Lazarus',
    ),
  ];
  final RxInt carouselIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: carouselSliderItems.length,
          itemBuilder: (context, index, realIndex) {
            return carouselSliderItems[index];
          },
          options: CarouselOptions(
            clipBehavior: Clip.none,
            onPageChanged: (index, reason) {
              carouselIndex.value = index;
            },
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            height: 120.h,
            viewportFraction: 0.7,
            autoPlay: true,
            enableInfiniteScroll: true,
          ),
        ),
        // 8.h.verticalSpace,
        // Container(
        //   color: Colors.transparent,
        //   child: Obx(
        //     () {
        //       return AnimatedSmoothIndicator(
        //         activeIndex: carouselIndex.value,
        //         count: carouselSliderItems.length,
        //         effect: SwapEffect(
        //           type: SwapType.yRotation,
        //           dotWidth: 8.w,
        //           dotHeight: 8.w,
        //           activeDotColor: ColorConstants.blueColor,
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.placeName,
    required this.placePhotoUrl,
  });

  final String placeName;
  final String placePhotoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 327.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0BA7FF).withOpacity(0.14),
            blurRadius: 12,
            offset: const Offset(
              0,
              12,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 120.h,
              width: 327.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: ColorConstants.blueColor,
                  width: 2.w,
                ),
                image: DecorationImage(
                  image: AssetImage(
                    placePhotoUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60.h,
              width: 327.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 40,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 12.h,
            left: 24.w,
            child: Text(
              placeName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: FontConstants.montserratBold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
