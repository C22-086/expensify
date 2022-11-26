import 'package:core/core.dart';

class LogOut {
  final AuthRepository repository;

  LogOut(this.repository);

  Future<void> execute() {
    return repository.logOut();
  }
}
