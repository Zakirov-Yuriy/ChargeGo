import 'package:dartz/dartz.dart';
import '../repositories/payment_repository.dart';
import '../../core/errors/failures.dart';

class RentPowerBank {
  final PaymentRepository repository;

  const RentPowerBank(this.repository);

  Future<Either<Failure, bool>> call(String stationId) async {
    return await repository.rentPowerBank(stationId);
  }
}
