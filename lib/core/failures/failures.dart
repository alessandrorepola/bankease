import 'package:bankease/features/auth/domain/failures.dart';

class Failure {}

class NetworkFailure extends Failure {}

class DocumentNotFoundFailure extends Failure {}

class UnexpectedFailure extends Failure implements AuthFailure {}
