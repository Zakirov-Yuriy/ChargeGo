import 'package:dartz/dartz.dart';
import '../repositories/payment_repository.dart';
import '../../core/errors/failures.dart';

class CreateSubscription {
  final PaymentRepository repository;

  const CreateSubscription(this.repository);

  Future<Either<Failure, bool>> call(String paymentToken) async {
    return await repository.createSubscription(paymentToken);
  }
}
