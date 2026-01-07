import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/pages/home_page.dart';
import 'package:note_sphere/pages/notes_page.dart';
import 'package:note_sphere/pages/todo_page.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: "/",
    routes: [
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return HomePage();
        },
      ),
      //routes for notePage
      GoRoute(
        path: "/notes",
        name: "notes",
        builder: (context, state) {
          return NotesPage();
        },
      ),
      //routes for todoPage
      GoRoute(
        path: "/todos",
        name: "todos",
        builder: (context, state) {
          return TodoPage();
        },
      ),
    ],
  );
}
