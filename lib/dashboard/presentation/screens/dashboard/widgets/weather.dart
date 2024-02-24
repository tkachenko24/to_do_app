import 'package:to_do_app/common/presentation/export.dart';
import 'package:to_do_app/dashboard/presentation/states/export.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key, required this.theme, required this.state});

  final ThemeData theme;
  final WeatherState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: theme.dividerColor,
        ),
        width: double.infinity,
        child: state.status.isSuccess()
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'City: ${state.weather.city}',
                      style: Fonts.labelLarge,
                    ),
                    Text(
                      'Condition: ${state.weather.condition}',
                      style: Fonts.labelMedium,
                    ),
                    Text(
                      'Temperature: ${state.weather.temp} °C',
                      style: Fonts.labelMedium,
                    ),
                    Text(
                      'Feels like: ${state.weather.feelsLike} °C',
                      style: Fonts.labelMedium,
                    ),
                    Text(
                      'Max temperature ${state.weather.tempMax} °C',
                      style: Fonts.labelMedium,
                    ),
                    Text(
                      'Min temperature ${state.weather.tempMin} °C',
                      style: Fonts.labelMedium,
                    ),
                    Text(
                      'Humidity ${state.weather.humidity} %',
                      style: Fonts.labelMedium,
                    ),
                  ],
                ),
              )
            : state.status.isFailed()
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'There was an error with fetching weather data please, try again',
                        ),
                        PlatformElevatedButton(
                          child: const Text(
                            'Try again',
                          ),
                          onPressed: () => context.read<WeatherBloc>().add(
                                const FetchWeather(),
                              ),
                        )
                      ],
                    ),
                  )
                : state.status.isLoading()
                    ? Center(
                        child: PlatformCircularProgressIndicator(),
                      )
                    : state.status.isNoInternet()
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Check your internet connection, and try again',
                                ),
                                PlatformElevatedButton(
                                  child: const Text('Try again'),
                                  onPressed: () =>
                                      context.read<WeatherBloc>().add(
                                            const FetchWeather(),
                                          ),
                                )
                              ],
                            ),
                          )
                        : state.status.isNoPermission()
                            ? Column(
                                children: [
                                  const Text(
                                      'To get your current weather, app needs with your permission, give us permission is settings menu, and try again'),
                                  PlatformElevatedButton(
                                    child: const Text('Try again'),
                                    onPressed: () =>
                                        context.read<WeatherBloc>().add(
                                              const FetchWeather(),
                                            ),
                                  )
                                ],
                              )
                            : const Center(
                                child: Text('Nothing to show'),
                              ),
      ),
    );
  }
}
