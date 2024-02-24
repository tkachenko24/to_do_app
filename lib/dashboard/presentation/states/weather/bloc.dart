import 'package:equatable/equatable.dart';
import 'package:to_do_app/common/export.dart';
import 'package:to_do_app/dashboard/export.dart';

part 'event.dart';
part 'state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repo;

  WeatherBloc({required this.repo}) : super(WeatherState.empty()) {
    on<FetchWeather>(_onWeatherFetch);
  }

  void _onWeatherFetch(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(
      status: Status.loading(),
    ));
    final Try<WeatherFailure, Weather> response = await repo.fetch();

    response.fold(
      (failed) => emit(
        state.copyWith(
          status: failed.error == 'internet'
              ? Status.noInternet()
              : failed.error == 'permission'
                  ? Status.noPermission()
                  : Status.failed(failed),
        ),
      ),
      (success) => emit(
        state.copyWith(
          status: Status.success(success),
          weather: success,
        ),
      ),
    );
  }
}
