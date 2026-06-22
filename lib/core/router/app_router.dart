import 'package:auto_hub_app/core/shell/main_shell.dart';
import 'package:auto_hub_app/features/auth/presentation/pages/auth_screen.dart';
import 'package:auto_hub_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:auto_hub_app/features/product/presentation/pages/part_details_page.dart';
import 'package:auto_hub_app/features/settings/presentation/pages/settings_page.dart';
import 'package:auto_hub_app/features/request_junk/presentation/pages/junk_detail_page.dart';
import 'package:auto_hub_app/features/request_junk/presentation/pages/my_request_junk.dart';
import 'package:auto_hub_app/features/request_junk/presentation/pages/new_junk_request.dart';
import 'package:auto_hub_app/features/splash/presentation/pages/splash_page.dart';
import 'package:auto_hub_app/features/vin/domain/entities/vin_decode_result.dart';
import 'package:auto_hub_app/features/vin/presentation/pages/vin_result_page.dart';
import 'package:go_router/go_router.dart';

/// Application router configuration using GoRouter.
///
/// All routes are centrally defined here. Features register their
/// routes via this configuration. Auth guards and redirects will
/// be added here as features are built.
final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const MainShell(),
    ),
    GoRoute(
      path: '/part-details',
      name: 'part-details',
      builder: (context, state) => const PartDetailsPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const AuthScreen(initialTabIndex: 1),
    ),
    GoRoute(
      path: '/vin-result',
      name: 'vin-result',
      builder: (context, state) => VinResultPage(
        result: state.extra! as VinDecodeResult,
      ),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
     GoRoute(
      path: '/my-request-junk',
      name: 'my-request-junk',
      builder: (context, state) => const MyRequestJunk(),
      routes: [
        GoRoute(
          path: 'junk',
          name: 'junk-detail',
          builder: (context, state) {
            final junkId = state.uri.queryParameters['junk'] ?? '';
            return JunkDetailPage(junkId: junkId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/new-junk-request',
      name: 'new-junk-request',
      builder: (context, state) => const NewJunkRequest(),
    ),
  ],
);
