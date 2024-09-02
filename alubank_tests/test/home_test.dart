import 'package:estilizacao_componentes/components/box_card.dart';
import 'package:estilizacao_componentes/data/bank_http.mocks.dart';
import 'package:estilizacao_componentes/data/bank_inherited.dart';
import 'package:estilizacao_componentes/models/bank.dart';
import 'package:estilizacao_componentes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


void main() {
  final httpMock = MockBankHttp();

  Future<void> _createWidget(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal(),),
      ),
    ));
  }

  testWidgets('My widget das a text "Spent"', (tester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    final spentFinder = find.text('Spent');
    expect(spentFinder, findsOneWidget);
  });

  testWidgets('My widget das a text "Transfer"', (tester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    final spentFinder = find.text('Transfer');
    expect(spentFinder, findsOneWidget);
  });

  testWidgets('finds a LinearProgressIndicator', (tester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('finds a AccountStatus', (tester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    expect(find.byKey(const Key('testKey')), findsOneWidget);
  });

  testWidgets('finds a Available section', (tester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    final bank = BankModel();
    expect(find.text('Available balance'), findsOneWidget);
    expect(bank.available, 0);
  });

  testWidgets('finds a Spent section', (tester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    final bank = BankModel();
    expect(find.text('Spent'), findsOneWidget);
    expect(bank.spent, 0);
  });

  testWidgets('finds 5 BoxCards', (tester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    expect(find.byWidgetPredicate((widget){
      if(widget is BoxCard){
        return true;
      }
      return false;
    }), findsNWidgets(5) );
  });

  testWidgets('When tap Deposit should upload earned in 10', (tester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    await tester.tap(find.text('Deposit'));
    await tester.tap(find.text('Earned'));
    await tester.pumpAndSettle(); //necessario quando a tela muda

    expect(find.text('\$10.0'), findsOneWidget);
  });

  testWidgets('When tap Transfer should upload Spent in 10', (tester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    await tester.tap(find.text('Transfer'));
    await tester.tap(find.text('Spent'));
    await tester.pumpAndSettle(); //necessario quando a tela muda

    expect(find.text('\$10.0'), findsOneWidget);
  });
  

  testWidgets('When tap Deposit should upload total points in 10', (tester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    await tester.tap(find.text('Deposit'));
    await tester.ensureVisible(find.byKey(const Key('testAccountKey')));
    await tester.tap(find.byKey(const Key('testAccountKey')));
    await tester.pump(); //necessario quando a tela muda

    expect(find.text('10.0'), findsOneWidget);
  });

  testWidgets('When tap Deposit should upload total points in 10', (tester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));

    await _createWidget(tester);
    await tester.tap(find.text('Transfer'));
    await tester.ensureVisible(find.byKey(const Key('testAccountKey')));
    await tester.tap(find.byKey(const Key('testAccountKey')));
    await tester.pump(); //necessario quando a tela muda

    expect(find.text('10.0'), findsOneWidget);
  });

  testWidgets('Testing MockHttp dolarToReal', (tester) async{
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5.0'));//stub necessario
    await _createWidget(tester);
    verify(httpMock.dolarToReal()).called(12);
  });

}

