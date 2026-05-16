import 'package:injectable/injectable.dart';

const Environment staging = Environment(StagingEnvironment.staging);

class StagingEnvironment extends Environment {
  static const String staging = 'staging';

  const StagingEnvironment(super.name);
}
