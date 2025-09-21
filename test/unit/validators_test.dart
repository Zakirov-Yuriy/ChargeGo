import 'package:flutter_test/flutter_test.dart';
import 'package:ChargeGo/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('Email validation', () {
      test('should return null for valid email', () {
        final result = Validators.validateEmail('test@example.com');
        expect(result, isNull);
      });

      test('should return error for null email', () {
        final result = Validators.validateEmail(null);
        expect(result, 'Email не может быть пустым');
      });

      test('should return error for empty email', () {
        final result = Validators.validateEmail('');
        expect(result, 'Email не может быть пустым');
      });

      test('should return error for invalid email format', () {
        final result = Validators.validateEmail('invalid-email');
        expect(result, 'Введите корректный email');
      });

      test('should return error for email without domain', () {
        final result = Validators.validateEmail('test@');
        expect(result, 'Введите корректный email');
      });
    });

    group('Phone validation', () {
      test('should return null for valid phone number', () {
        final result = Validators.validatePhone('+7 (999) 123-45-67');
        expect(result, isNull);
      });

      test('should return error for null phone', () {
        final result = Validators.validatePhone(null);
        expect(result, 'Номер телефона не может быть пустым');
      });

      test('should return error for empty phone', () {
        final result = Validators.validatePhone('');
        expect(result, 'Номер телефона не может быть пустым');
      });

      test('should return error for too short phone', () {
        final result = Validators.validatePhone('123');
        expect(result, 'Номер телефона должен содержать от 10 до 15 цифр');
      });

      test('should return error for too long phone', () {
        final result = Validators.validatePhone('12345678901234567890');
        expect(result, 'Номер телефона должен содержать от 10 до 15 цифр');
      });
    });

    group('Station ID validation', () {
      test('should return null for valid station ID', () {
        final result = Validators.validateStationId('RECH123456789012');
        expect(result, isNull);
      });

      test('should return error for null station ID', () {
        final result = Validators.validateStationId(null);
        expect(result, 'ID станции не может быть пустым');
      });

      test('should return error for empty station ID', () {
        final result = Validators.validateStationId('');
        expect(result, 'ID станции не может быть пустым');
      });

      test('should return error for invalid format', () {
        final result = Validators.validateStationId('INVALID123');
        expect(result, 'ID станции должен быть в формате RECH123456789012');
      });

      test('should return error for too short station ID', () {
        final result = Validators.validateStationId('RECH123');
        expect(result, 'ID станции должен быть в формате RECH123456789012');
      });
    });

    group('Card number validation', () {
      test('should return null for valid card number', () {
        final result = Validators.validateCardNumber('4532015112830366');
        expect(result, isNull);
      });

      test('should return error for null card number', () {
        final result = Validators.validateCardNumber(null);
        expect(result, 'Номер карты не может быть пустым');
      });

      test('should return error for empty card number', () {
        final result = Validators.validateCardNumber('');
        expect(result, 'Номер карты не может быть пустым');
      });

      test('should return error for too short card number', () {
        final result = Validators.validateCardNumber('123');
        expect(result, 'Номер карты должен содержать от 13 до 19 цифр');
      });

      test('should return error for invalid Luhn check', () {
        final result = Validators.validateCardNumber('4532015112830367');
        expect(result, 'Неверный номер карты');
      });
    });

    group('Card expiry validation', () {
      test('should return null for valid expiry date', () {
        final result = Validators.validateCardExpiry('12/25');
        expect(result, isNull);
      });

      test('should return error for null expiry', () {
        final result = Validators.validateCardExpiry(null);
        expect(result, 'Срок действия карты не может быть пустым');
      });

      test('should return error for empty expiry', () {
        final result = Validators.validateCardExpiry('');
        expect(result, 'Срок действия карты не может быть пустым');
      });

      test('should return error for invalid format', () {
        final result = Validators.validateCardExpiry('invalid');
        expect(result, 'Срок действия должен быть в формате MM/YY');
      });

      test('should return error for expired card', () {
        final result = Validators.validateCardExpiry('01/20');
        expect(result, 'Карта просрочена');
      });
    });

    group('CVC validation', () {
      test('should return null for valid 3-digit CVC', () {
        final result = Validators.validateCVC('123');
        expect(result, isNull);
      });

      test('should return null for valid 4-digit CVC', () {
        final result = Validators.validateCVC('1234');
        expect(result, isNull);
      });

      test('should return error for null CVC', () {
        final result = Validators.validateCVC(null);
        expect(result, 'CVC не может быть пустым');
      });

      test('should return error for empty CVC', () {
        final result = Validators.validateCVC('');
        expect(result, 'CVC не может быть пустым');
      });

      test('should return error for too short CVC', () {
        final result = Validators.validateCVC('12');
        expect(result, 'CVC должен содержать 3 или 4 цифры');
      });

      test('should return error for too long CVC', () {
        final result = Validators.validateCVC('12345');
        expect(result, 'CVC должен содержать 3 или 4 цифры');
      });

      test('should return error for non-numeric CVC', () {
        final result = Validators.validateCVC('abc');
        expect(result, 'CVC должен содержать 3 или 4 цифры');
      });
    });

    group('Card holder validation', () {
      test('should return null for valid card holder name', () {
        final result = Validators.validateCardHolder('John Doe');
        expect(result, isNull);
      });

      test('should return error for null card holder', () {
        final result = Validators.validateCardHolder(null);
        expect(result, 'Имя владельца карты не может быть пустым');
      });

      test('should return error for empty card holder', () {
        final result = Validators.validateCardHolder('');
        expect(result, 'Имя владельца карты не может быть пустым');
      });

      test('should return error for too short name', () {
        final result = Validators.validateCardHolder('A');
        expect(result, 'Имя владельца слишком короткое');
      });

      test('should return error for too long name', () {
        final result = Validators.validateCardHolder('A' * 51);
        expect(result, 'Имя владельца слишком длинное');
      });

      test('should return error for invalid characters', () {
        final result = Validators.validateCardHolder('John123');
        expect(result, 'Имя владельца содержит недопустимые символы');
      });
    });

    group('Required field validation', () {
      test('should return null for non-empty value', () {
        final result = Validators.validateRequired('test', 'Field');
        expect(result, isNull);
      });

      test('should return error for null value', () {
        final result = Validators.validateRequired(null, 'Field');
        expect(result, 'Field не может быть пустым');
      });

      test('should return error for empty value', () {
        final result = Validators.validateRequired('', 'Field');
        expect(result, 'Field не может быть пустым');
      });

      test('should return error for whitespace-only value', () {
        final result = Validators.validateRequired('   ', 'Field');
        expect(result, 'Field не может быть пустым');
      });
    });

    group('Minimum length validation', () {
      test('should return null for sufficient length', () {
        final result = Validators.validateMinLength('test', 3, 'Field');
        expect(result, isNull);
      });

      test('should return error for insufficient length', () {
        final result = Validators.validateMinLength('te', 3, 'Field');
        expect(result, 'Field должен содержать минимум 3 символов');
      });

      test('should return error for null value', () {
        final result = Validators.validateMinLength(null, 3, 'Field');
        expect(result, 'Field должен содержать минимум 3 символов');
      });
    });

    group('Maximum length validation', () {
      test('should return null for within limit', () {
        final result = Validators.validateMaxLength('test', 5, 'Field');
        expect(result, isNull);
      });

      test('should return error for exceeding limit', () {
        final result = Validators.validateMaxLength('test string', 5, 'Field');
        expect(result, 'Field должен содержать максимум 5 символов');
      });

      test('should return null for null value', () {
        final result = Validators.validateMaxLength(null, 5, 'Field');
        expect(result, isNull);
      });
    });
  });
}
