import 'package:client_control/components/hamburger_menu.dart';
import 'package:client_control/components/icon_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _createWidget(WidgetTester tester) async{
  await tester.pumpWidget(const MaterialApp(
    home: HamburgerMenu(),
  ));
}

// Função que retorna um Widget com o showIconPicker
Widget createIconPickerWidget() {
  return Builder(
    builder: (BuildContext context) {
      return Scaffold(
        body: ElevatedButton(
          onPressed: () async {
            await showIconPicker(context: context);
          },
          child: const Text('Show Icon Picker'),
        ),
      );
    },
  );
}

// Função para criar o IconPicker no teste
Future<void> _createIconPicker(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    home: createIconPickerWidget(),
  ));
}
void main(){
  group('Testing Menu', () {
    testWidgets('Should display the "Menu"', (tester) async {
      await _createWidget(tester);
      expect(find.text('Menu'), findsOneWidget);
    });

    testWidgets('Hamburguer Menu should have "Gerenciar clientes"', (tester) async {
      await _createWidget(tester);
      expect(find.text('Gerenciar clientes'), findsOneWidget);

    });
    testWidgets('Hamburguer Menu should have "Sair"', (tester) async {
      await _createWidget(tester);
      expect(find.text('Sair'), findsOneWidget);
    });

    testWidgets('Hamburguer Menu should have "Tipos de clientes"', (tester) async {
      await _createWidget(tester);
      expect(find.text('Tipos de clientes'), findsOneWidget);
    });
  });
  
  group('Testing Icon Pickers', () {
    testWidgets('Should display the "Escolha um ícone"', (tester) async {
      await _createIconPicker(tester);
      await tester.tap(find.text('Show Icon Picker'));
      await tester.pumpAndSettle();
      expect(find.text('Escolha um ícone'), findsOneWidget);
    });
  });
}