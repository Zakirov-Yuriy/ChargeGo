import 'dart:async';
import '../models/station.dart';
import '../core/utils/logger.dart';

class DeepLinkService {
  static final StreamController<Station> _stationController = StreamController<Station>.broadcast();

  static Stream<Station> get stationStream => _stationController.stream;

  // Упрощенная инициализация без внешних зависимостей
  static void initDeepLinkListener() {
    // В будущем здесь будет обработка deep links
    // Пока оставляем заглушку для тестирования
    Logger.i('Deep link service initialized');
  }

  // Метод для тестирования deep link функциональности
  static void simulateDeepLink(String stationId) {
    final station = Station(
      id: stationId,
      name: 'Station $stationId',
      location: 'Location for $stationId',
    );
    _stationController.add(station);
  }



  static void dispose() {
    _stationController.close();
  }
}
