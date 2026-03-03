import 'package:auto_hub_app/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Global service locator instance.
final GetIt getIt = GetIt.instance;

/// Initialises all injectable dependencies.
///
/// Call this once in `main()` before `runApp()`.
@InjectableInit()
void configureDependencies() => getIt.init();
