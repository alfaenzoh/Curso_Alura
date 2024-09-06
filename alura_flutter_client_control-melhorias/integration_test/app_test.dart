

import 'package:client_control/models/clients.dart';
import 'package:client_control/models/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:client_control/main.dart' as app;
import 'package:provider/provider.dart';
void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration test', (tester) async {
    final providerKey = GlobalKey();
    app.main(list: [], providerKey: providerKey);
    await tester.pumpAndSettle();
    //testado tela inicial
    expect(find.text('Clientes'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // Testando o drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Gerenciar clientes'), findsOneWidget);
    expect(find.text('Tipos de clientes'), findsOneWidget);
    expect(find.text('Sair'), findsOneWidget);

    //Testar a Navegaçao e a Tela de Tipos de Clientes
    await tester.tap(find.text('Tipos de clientes'));
    await tester.pumpAndSettle();

    expect(find.text('Tipos de cliente'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.text('Platinum'), findsOneWidget);
    expect(find.text('Golden'), findsOneWidget);
    expect(find.text('Titanium'), findsOneWidget);
    expect(find.text('Diamond'), findsOneWidget);

    //Testar a criacao de um tipo de cliente
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'Silver');

    await tester.tap(find.text('Selecionar icone'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.card_giftcard));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Silver'), findsOneWidget);
    expect(find.byIcon(Icons.card_giftcard), findsOneWidget);

    expect(Provider.of<Types>(providerKey.currentContext!, listen: false).types.last.name, 'Silver');
    expect(Provider.of<Types>(providerKey.currentContext!, listen: false).types.last.icon, Icons.card_giftcard);


    // Testando novo cliente

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Gerenciar clientes'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).first, 'Joao');
    await tester.enterText(find.byType(TextFormField).last, 'joao@gmail.com');

    await tester.tap(find.byIcon(Icons.arrow_downward));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Silver').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    //Verificar se o cliente foi criado
    expect(find.text('Joao (Silver)'), findsOneWidget);
    expect(find.byIcon(Icons.card_giftcard), findsOneWidget);

    expect(Provider.of<Clients>(providerKey.currentContext!, listen: false).clients.last.name, 'Joao');
    expect(Provider.of<Clients>(providerKey.currentContext!, listen: false).clients.last.email, 'joao@gmail.com');

    //O teste deve clicar no ListTitle do Cliente e aparecer o email dele
    await tester.tap(find.text('Joao (Silver)'));
    await tester.pumpAndSettle();

    expect(find.text('Email: joao@gmail.com'), findsOneWidget);

    // Deletar cliente
    await tester.drag(find.byType(Dismissible).first, const Offset(500,0));
    await tester.pumpAndSettle();

    expect(find.text('Joao'), findsNothing);

    //Sair do app
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sair'));
    await tester.pumpAndSettle();

  });

  //Desafio de criar teste de integracao para o Icon Picker
  testWidgets('Integration test for Icon Picker', (tester) async {
    app.main(list: [], providerKey: GlobalKey());
    await tester.pumpAndSettle();

    // Open the menu
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify the menu is displayed
    expect(find.text('Menu'), findsOneWidget);

    // Navigate to the screen Tipos de clientes
    await tester.tap(find.text('Tipos de clientes'));
    await tester.pumpAndSettle();

    // Tap the button add
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify the Cadastrar tipo dialog is displayed
    expect(find.text('Cadastrar tipo'), findsOneWidget);

    // Tap the Icon Picker
    await tester.tap(find.text('Selecionar icone'));
    await tester.pumpAndSettle();

    // Verify the Icon Picker is displayed
    expect(find.text('Escolha um ícone'), findsOneWidget);

    // Select an icon
    await tester.tap(find.byIcon(Icons.card_giftcard));
    await tester.pumpAndSettle();

    // Verify the Icon Picker is closed
    expect(find.text('Escolha um ícone'), findsNothing);
  });
}