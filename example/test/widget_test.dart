// This is a basic Flutter widget test for the CoreDio example app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:core_dio/core_dio.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoreDio Example Widget Tests', () {
    testWidgets('App loads with correct title and HTTP buttons', (
      WidgetTester tester,
    ) async {
      // Initialize CoreDio for testing
      await CoreDio.initialize(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeoutInSeconds: 15,
        receiveTimeoutInSeconds: 15,
        headers: {'Content-Type': 'application/json'},
      );

      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that our app title is displayed
      expect(find.text('CoreDio Example'), findsOneWidget);

      // Verify that the main heading is displayed
      expect(find.text('CoreDio HTTP Operations Example'), findsOneWidget);

      // Verify that all HTTP method buttons are present
      expect(find.text('GET'), findsOneWidget);
      expect(find.text('POST'), findsOneWidget);
      expect(find.text('PUT'), findsOneWidget);
      expect(find.text('DELETE'), findsOneWidget);

      // Verify initial response text is displayed
      expect(
        find.text('Press a button to make an HTTP request'),
        findsOneWidget,
      );

      // Verify CoreDio status information is displayed
      expect(find.text('CoreDio Status'), findsOneWidget);
      expect(find.textContaining('Initialized: true'), findsOneWidget);
    });

    testWidgets('GET button tap shows loading state', (
      WidgetTester tester,
    ) async {
      // Initialize CoreDio for testing
      await CoreDio.initialize(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeoutInSeconds: 15,
        receiveTimeoutInSeconds: 15,
        headers: {'Content-Type': 'application/json'},
      );

      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Find and tap the GET button
      await tester.tap(find.text('GET'));
      await tester.pump();

      // Verify that loading state is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Processing request...'), findsOneWidget);

      // Wait for the request to complete (or timeout)
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });

    testWidgets('All HTTP buttons are present and enabled initially', (
      WidgetTester tester,
    ) async {
      // Initialize CoreDio for testing
      await CoreDio.initialize(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeoutInSeconds: 15,
        receiveTimeoutInSeconds: 15,
        headers: {'Content-Type': 'application/json'},
      );

      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Find all ElevatedButton widgets
      final getButton = find.widgetWithText(ElevatedButton, 'GET');
      final postButton = find.widgetWithText(ElevatedButton, 'POST');
      final putButton = find.widgetWithText(ElevatedButton, 'PUT');
      final deleteButton = find.widgetWithText(ElevatedButton, 'DELETE');

      // Verify all buttons exist
      expect(getButton, findsOneWidget);
      expect(postButton, findsOneWidget);
      expect(putButton, findsOneWidget);
      expect(deleteButton, findsOneWidget);

      // Verify buttons are enabled (not null onPressed)
      final getButtonWidget = tester.widget<ElevatedButton>(getButton);
      final postButtonWidget = tester.widget<ElevatedButton>(postButton);
      final putButtonWidget = tester.widget<ElevatedButton>(putButton);
      final deleteButtonWidget = tester.widget<ElevatedButton>(deleteButton);

      expect(getButtonWidget.onPressed, isNotNull);
      expect(postButtonWidget.onPressed, isNotNull);
      expect(putButtonWidget.onPressed, isNotNull);
      expect(deleteButtonWidget.onPressed, isNotNull);
    });

    testWidgets('Response container is present and displays initial text', (
      WidgetTester tester,
    ) async {
      // Initialize CoreDio for testing
      await CoreDio.initialize(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeoutInSeconds: 15,
        receiveTimeoutInSeconds: 15,
        headers: {'Content-Type': 'application/json'},
      );

      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify the response container exists
      expect(find.byType(Container), findsWidgets);

      // Verify initial response text
      expect(
        find.text('Press a button to make an HTTP request'),
        findsOneWidget,
      );

      // Verify status information container
      expect(
        find.text('Base URL: https://jsonplaceholder.typicode.com'),
        findsOneWidget,
      );
      expect(find.text('Timeout: 15 seconds'), findsOneWidget);
    });
  });
}
