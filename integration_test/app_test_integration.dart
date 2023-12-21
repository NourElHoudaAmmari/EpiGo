import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:epigo_project/main.dart'as app;


  void main(){
    group('app test', () { 
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      testWidgets("login test",(tester)async{
            app.main();
     await tester.pumpAndSettle();
final emailFormField = find.byType(TextFormField);
final passwordFormFiled = find.byType(TextFormField);
final loginButton = find.byType(ElevatedButton);

await tester.enterText(emailFormField, "nourammari15@gmail.com");
await Future.delayed(const Duration(seconds: 2));
await tester.enterText(passwordFormFiled, "1234567890");
await Future.delayed(const Duration(seconds: 2));
await tester.pumpAndSettle();
await tester.tap(loginButton);
  await tester.pumpAndSettle();
 // expect(find.byType(HomeScreen), findsOneWidget);
     }
     );

  });
}