import 'package:auto_hub_app/core/shell/main_shell.dart';
import 'package:auto_hub_app/features/account_details/presentation/pages/account_details_page.dart';
import 'package:auto_hub_app/features/account_details/presentation/pages/edit_account_details_page.dart';
import 'package:auto_hub_app/features/auth/presentation/pages/auth_screen.dart';
import 'package:auto_hub_app/features/contact_support/presentation/pages/contact_support_page.dart';
import 'package:auto_hub_app/features/help_center/presentation/pages/help_center_page.dart';
import 'package:auto_hub_app/features/messages/presentation/pages/chat_page.dart';
import 'package:auto_hub_app/features/messages/presentation/pages/live_chats_page.dart';
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
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Application router configuration using GoRouter.
///
/// All routes are centrally defined here. Features register their
/// routes via this configuration. Auth guards and redirects will
/// be added here as features are built.

/// Shared slide-from-right transition used for all pushed routes.
///
/// Using [CustomTransitionPage] + [pageBuilder] instead of [builder]
/// prevents GoRouter's internal pop/restore cycle from exposing a
/// blank canvas between frames (the source of the brief blank-screen
/// flash that appears when navigating with [context.push]).
Page<void> _slidePage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        child: child,
      );
    },
  );
}

/// Shared fade transition used for top-level [go] routes such as
/// splash → home. These replace the stack, so there is no need for
/// a directional slide.
Page<void> _fadePage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: [
    // ── Stack-replacing routes (fade) ────────────────────────────────────────
    GoRoute(
      path: '/splash',
      name: 'splash',
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const SplashPage()),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const MainShell()),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const OnboardingPage()),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const AuthScreen()),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const AuthScreen(initialTabIndex: 1),
      ),
    ),

    // ── Pushed routes (slide from right) ────────────────────────────────────

    // product
    GoRoute(
      path: '/part-details',
      name: 'part-details',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const PartDetailsPage()),
    ),

    // vin
    GoRoute(
      path: '/vin-result',
      name: 'vin-result',
      pageBuilder: (context, state) => _slidePage(
        key: state.pageKey,
        child: VinResultPage(result: state.extra! as VinDecodeResult),
      ),
    ),

    // my_order
    GoRoute(
      path: '/my-orders',
      name: 'my-orders',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const MyOrdersPage()),
    ),
    GoRoute(
      path: '/order-details',
      name: 'order-details',
      pageBuilder: (context, state) => _slidePage(
        key: state.pageKey,
        child: OrderDetailsPage(orderId: state.extra! as String),
      ),
    ),

    // messages
    GoRoute(
      path: '/live-chats',
      name: 'live-chats',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const LiveChatPage()),
    ),
    GoRoute(
      path: '/chat',
      name: 'chat',
      pageBuilder: (context, state) => _slidePage(
        key: state.pageKey,
        child: ChatPage(
          chatRoomId: state.uri.queryParameters['chatRoomId'] ?? '',
        ),
      ),
    ),
    GoRoute(
      path: '/chat/:chatRoomId',
      name: 'chat-room',
      pageBuilder: (context, state) => _slidePage(
        key: state.pageKey,
        child: ChatPage(
          chatRoomId: state.pathParameters['chatRoomId'] ?? '1',
        ),
      ),
    ),

    // contact_support
    GoRoute(
      path: '/contact-support',
      name: 'contact-support',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const ContactSupportPage()),
    ),
    GoRoute(
      path: '/contact-support-chat',
      name: 'contact-support-chat',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const LiveChatPage()),
    ),

    // account
    GoRoute(
      path: '/account-details',
      name: 'account-details',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const AccountDetailsPage()),
    ),
    GoRoute(
      path: '/edit-account-details',
      name: 'edit-account-details',
      pageBuilder: (context, state) => _slidePage(
        key: state.pageKey,
        child: const EditAccountDetailsPage(),
      ),
    ),
    GoRoute(
      path: '/your-addresses',
      name: 'your-addresses',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const YourAddressesPage()),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const SettingsPage()),
    ),

    // payment
    GoRoute(
      path: '/payment-methods',
      name: 'payment-methods',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const PaymentMethodPage()),
    ),

    // request_junk
    GoRoute(
      path: '/my-request-junk',
      name: 'my-request-junk',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const MyRequestJunk()),
      routes: [
        GoRoute(
          path: 'junk',
          name: 'junk-detail',
          pageBuilder: (context, state) => _slidePage(
            key: state.pageKey,
            child: JunkDetailPage(
              junkId: state.uri.queryParameters['junk'] ?? '',
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/new-junk-request',
      name: 'new-junk-request',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const NewJunkRequest()),
    ),

    // help
    GoRoute(
      path: '/help-center',
      name: 'help-center',
      pageBuilder: (context, state) =>
          _slidePage(key: state.pageKey, child: const HelpCenterPage()),
    ),
  ],
);