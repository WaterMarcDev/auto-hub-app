import 'package:auto_hub_app/core/shell/main_shell.dart';
import 'package:auto_hub_app/features/account_details/presentation/pages/account_details_page.dart';
import 'package:auto_hub_app/features/account_details/presentation/pages/edit_account_details_page.dart';
import 'package:auto_hub_app/features/auth/presentation/pages/auth_screen.dart';
import 'package:auto_hub_app/features/contact_support/presentation/pages/contact_support_page.dart';
import 'package:auto_hub_app/features/messages/presentation/pages/chat_page.dart';
import 'package:auto_hub_app/features/messages/presentation/pages/live_chats_page.dart' ;
import 'package:auto_hub_app/features/my_order/presentation/pages/my_orders.dart';
import 'package:auto_hub_app/features/my_order/presentation/pages/order_details_page.dart';
import 'package:auto_hub_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:auto_hub_app/features/payment_methods/presentation/pages/payment_method_page.dart';
import 'package:auto_hub_app/features/product/presentation/pages/part_details_page.dart';
import 'package:auto_hub_app/features/request_junk/presentation/pages/junk_detail_page.dart';
import 'package:auto_hub_app/features/request_junk/presentation/pages/my_request_junk.dart';
import 'package:auto_hub_app/features/request_junk/presentation/pages/new_junk_request.dart';
import 'package:auto_hub_app/features/settings/presentation/pages/settings_page.dart';
import 'package:auto_hub_app/features/splash/presentation/pages/splash_page.dart';
import 'package:auto_hub_app/features/vin/domain/entities/vin_decode_result.dart';
import 'package:auto_hub_app/features/vin/presentation/pages/vin_result_page.dart';
import 'package:auto_hub_app/features/your_addresses/presentation/pages/your_addresses_page.dart';
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
    // my_order feature
    GoRoute(
      path: '/my-orders',
      name: 'my-orders',
      builder: (context, state) => const MyOrdersPage(),
    ),
    GoRoute(
      path: '/order-details',
      name: 'order-details',
      builder: (context, state) {
        final orderId = state.extra! as String;
        return OrderDetailsPage(orderId: orderId);
      },
    ),
    // messages feature
    GoRoute(
      path: '/live-chats',
      name: 'live-chats',
      builder: (context, state) => const LiveChatPage(),
    ),
    GoRoute(
      path: '/chat',
      name: 'chat',
      builder: (context, state) {
        final chatRoomId = state.uri.queryParameters['chatRoomId'] ?? '';
        return ChatPage(chatRoomId: chatRoomId);
      },
    ),
    
    // contact_support feature
    GoRoute(
      path: '/contact-support',
      name: 'contact-support',
      builder: (context, state) => const ContactSupportPage(),
    ),
    GoRoute(
      path: '/chat/:chatRoomId',
      name: 'chat-room',
      builder: (context, state) {
        final chatRoomId = state.pathParameters['chatRoomId'] ?? '1';
        return ChatPage(chatRoomId: chatRoomId);
      },),
      GoRoute(
      path: '/contact-support-chat',
      name: 'contact-support-chat',
      builder: (context, state) => const LiveChatPage(),
    ),
    // account
    GoRoute(
      path: '/account-details',
      name: 'account-details',
      builder: (context, state) => const AccountDetailsPage(),
    ),
    GoRoute(
      path: '/edit-account-details',
      name: 'edit-account-details',
      builder: (context, state) => const EditAccountDetailsPage(),
    ),
    GoRoute(
      path: '/your-addresses',
      name: 'your-addresses',
      builder: (context, state) => const YourAddressesPage(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),),

     GoRoute(
      path: '/payment-methods',
      name: 'payment-methods',
      builder: (context, state) => const PaymentMethodPage(),),
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
