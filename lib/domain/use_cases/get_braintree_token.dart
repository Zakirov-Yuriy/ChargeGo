import 'package:dartz/dartz.dart';
import '../repositories/payment_repository.dart';
import '../../core/errors/failures.dart';

class GetBraintreeToken {
  final PaymentRepository repository;

  const GetBraintreeToken(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getBraintreeToken();
  }
}
