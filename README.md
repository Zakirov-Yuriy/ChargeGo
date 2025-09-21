# 🔋 Recharge City - Flutter Application

Современное Flutter приложение для аренды павербанков с использованием Clean Architecture и best practices.

## 📋 Описание

Recharge City - это мобильное приложение для аренды павербанков через сеть станций. Приложение поддерживает:
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
   git clone https://gitlab.com/zakcoyote/chargego.git
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

---

**Recharge City** - Заряжайся где угодно! 🔌
=======
# ChargeGo



## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/topics/git/add_files/#add-files-to-a-git-repository) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/zakcoyote/chargego.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.com/zakcoyote/chargego/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Set auto-merge](https://docs.gitlab.com/user/project/merge_requests/auto_merge/)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!). Thanks to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README

Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
>>>>>>> 8c88260267e94d952463c9f3a74b59a1181a30a7
