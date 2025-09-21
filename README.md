# 🔋 ChargeGo - Flutter Application

Современное Flutter приложение для аренды павербанков с использованием Clean Architecture и best practices.

## 📋 Описание

ChargeGo - это мобильное приложение для аренды павербанков через сеть станций. Приложение поддерживает:
- 🔍 Поиск ближайших станций
- 💳 Оплату через Apple Pay и банковские карты
- 📱 Deep linking для быстрого доступа
- 🔄 Автоматические повторные попытки при сбоях сети
- 📊 Структурированное логирование

## 🏗️ Архитектура

Проект построен с использованием **Clean Architecture** и принципов **SOLID**:

```
lib/
├── core/                    # Core слой
│   ├── constants/          # Константы и конфигурация
│   ├── di/                 # Dependency injection
│   ├── errors/             # Error handling
│   ├── theme/              # Theme система
│   └── utils/              # Вспомогательные классы
├── data/                   # Data слой
│   ├── datasources/        # Источники данных
│   └── repositories/       # Реализации репозиториев
├── domain/                 # Domain слой
│   ├── entities/           # Бизнес-сущности
│   ├── repositories/       # Интерфейсы репозиториев
│   └── use_cases/          # Use cases
└── presentation/           # Presentation слой
    ├── providers/          # State management
    └── widgets/            # UI компоненты
```

### 🧩 Ключевые компоненты

- **Dependency Injection**: `get_it` для управления зависимостями
- **State Management**: Provider с разделением состояний
- **Error Handling**: Централизованная обработка ошибок
- **Validation**: Полная валидация всех входных данных
- **Retry Logic**: Автоматические повторные попытки с exponential backoff
- **Logging**: Структурированное логирование для отладки

## 🚀 Установка

### Требования

- Flutter SDK >= 3.9.2
- Dart SDK >= 3.0.0

### Шаги установки

1. **Клонируйте репозиторий**
   ```bash
   git clone https://github.com/Zakirov-Yuriy/ChargeGo.git
   cd flutter_application_2
   ```

2. **Установите зависимости**
   ```bash
   flutter pub get
   ```

3. **Запустите приложение**
   ```bash
   flutter run
   ```

## 📱 Использование

### Основные экраны

1. **Главный экран** - Отображение доступных станций
2. **Экран оплаты** - Обработка платежей через Apple Pay/карты
3. **Экран успеха** - Подтверждение успешной аренды

### Deep Linking

Приложение поддерживает deep linking для быстрого доступа к станциям:

```
rechargecity://station?stationId=RECH123456789012
```

## 🧪 Тестирование

### Запуск unit тестов

```bash
flutter test
```

### Доступные тесты

- **Validators Test** - Тестирование валидации данных
- **Error Handler Test** - Тестирование обработки ошибок

### Покрытие тестами

```bash
flutter test --coverage
```

## 🔧 Конфигурация

### API Configuration

Все API endpoints настраиваются в `lib/core/constants/app_constants.dart`:

```dart
class ApiConstants {
  static const String baseUrl = 'https://goldfish-app-3lf7u.ondigitalocean.app';
  static const String apiVersion = 'v1';
  // ... другие константы
}
```

### Theme Configuration

Тема приложения настраивается в `lib/core/theme/app_theme.dart`:

```dart
class AppTheme {
  static ThemeData get lightTheme {
    // Настройки темы
  }
}
```

## 📚 Зависимости

### Core Dependencies

- **get_it**: ^7.6.4 - Dependency injection
- **provider**: ^6.1.2 - State management
- **equatable**: ^2.0.5 - Value equality
- **dartz**: ^0.10.1 - Functional programming

### UI Dependencies

- **cached_network_image**: ^3.3.1 - Image caching
- **url_launcher**: ^6.2.6 - URL launching

### Utility Dependencies

- **intl**: ^0.19.0 - Internationalization
- **http**: ^1.2.1 - HTTP client

## 🎨 UI Компоненты

### Доступные виджеты

- **CustomButton** - Кастомная кнопка с различными стилями
- **LoadingWidget** - Индикаторы загрузки
- **ErrorWidget** - Отображение ошибок
- **StationCard** - Карточки станций

### Пример использования

```dart
CustomButton(
  text: 'Оплатить',
  onPressed: () => processPayment(),
  variant: ButtonVariant.primary,
  isLoading: isProcessing,
)
```

## 🚨 Обработка ошибок

Приложение имеет централизованную систему обработки ошибок:

```dart
final result = await _createSubscription(paymentToken);

result.fold(
  (failure) => handleError(failure),
  (success) => handleSuccess(success),
);
```

## 📊 Логирование

Структурированное логирование для отладки:

```dart
Logger.i('Payment initialized');
Logger.e('Payment failed', error: error);
Logger.api('POST /api/v1/payments', method: 'POST', statusCode: 200);
```

## 🔄 Retry Logic

Автоматические повторные попытки для сетевых операций:

```dart
return RetryHelper.retryApiOperation(
  () => apiClient.post(endpoint, body: body),
  operationName: 'POST $endpoint',
);
```

## 📝 Скрипты

### Полезные команды

```bash
# Запуск приложения
flutter run

# Анализ кода
flutter analyze

# Форматирование кода
flutter format .

# Запуск тестов
flutter test

# Генерация coverage отчета
flutter test --coverage
```



## 🔗 Ссылки

- [Документация Flutter](https://docs.flutter.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)


