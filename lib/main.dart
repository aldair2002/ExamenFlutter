import 'package:examen/create_ticket.dart';
import 'package:examen/menu.dart';
import 'package:examen/view_ticket.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return Menu();
        },
      ),
            GoRoute(
        path: '/create_ticket',
        builder: (BuildContext context, GoRouterState state) {
          return CreateTicketPage();
        },
      ),
            GoRoute(
        path: '/view_tickets',
        builder: (BuildContext context, GoRouterState state) {
          return ViewTicketPage();
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
