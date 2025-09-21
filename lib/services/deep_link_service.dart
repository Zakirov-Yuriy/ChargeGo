import 'dart:async';
import '../models/station.dart';

class DeepLinkService {
  static StreamController<Station> _stationController = StreamController<Station>.broadcast();

  static Stream<Station> get stationStream => _stationController.stream;

  // Упрощенная инициализация без внешних зависимостей
  static void initDeepLinkListener() {
    // В будущем здесь будет обработка deep links
    // Пока оставляем заглушку для тестирования
    print('Deep link service initialized');
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

  static void _handleDeepLink(String link) {
    try {
      final uri = Uri.parse(link);
      final stationId = uri.queryParameters['stationId'];

      if (stationId != null && stationId.isNotEmpty) {
        final station = Station(
          id: stationId,
          name: 'Station $stationId',
          location: 'Location for $stationId',
        );
        _stationController.add(station);
      }
    } catch (e) {
      print('Error parsing deep link: $e');
    }
  }

  static void dispose() {
    _stationController.close();
  }
}
