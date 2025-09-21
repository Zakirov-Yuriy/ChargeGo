import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/payment_provider.dart';
import 'services/deep_link_service.dart';
import 'models/station.dart';
import 'screens/payment_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DeepLinkService.initDeepLinkListener();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentProvider(),
      child: MaterialApp(
        title: 'Recharge City',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Station? _currentStation;

  @override
  void initState() {
    super.initState();

    // Слушаем deep links
    DeepLinkService.stationStream.listen((station) {
      if (!mounted) return;

      setState(() {
        _currentStation = station;
      });

      // Переходим к экрану оплаты
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(station: station),
        ),
      );
    });

    // Инициализируем deep link listener
    DeepLinkService.initDeepLinkListener();
  }

  @override
  Widget build(BuildContext context) {
    // Если есть станция из deep link, показываем экран загрузки
    if (_currentStation != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text('Подключение к станции ${_currentStation!.id}...'),
            ],
          ),
        ),
      );
    }

    // Стандартный экран для тестирования
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'recharge.city',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
     
      ),
      body: Column(
        children: [
        

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Тестовое приложение Recharge City',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Тестовый deep link
                      final testStation = Station(
                        id: 'RECH082203000350',
                        name: 'Test Station',
                        location: 'Test Location',
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(station: testStation),
                        ),
                      );
                    },
                    child: const Text('Тестировать оплату'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
