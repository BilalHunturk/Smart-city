import 'package:bocekilaclama/core/init/helper/ui_helper.dart';
import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/views/home_view/widgets/events_widget.dart';
import 'package:bocekilaclama/views/home_view/widgets/carousel_widget.dart';
import 'package:bocekilaclama/views/home_view/widgets/weather_widget.dart';
import 'package:bocekilaclama/views/widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Discover"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const WeatherWidget(),
              UiHelper.defaultSpaceHeight,
              UiHelper.appText("City Attractions", index: 1),
              UiHelper.defaultSpaceHeight,
              HomeCarousel(),
              UiHelper.defaultSpaceHeight,
              UiHelper.appText("City Events", index: 1),
              UiHelper.defaultSpaceHeight,
              const Events()
            ],
          ),
        ),
      ),
    );
  }
}
