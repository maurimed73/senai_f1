import 'package:flutter/material.dart';

class BarraComValores extends StatefulWidget {
  const BarraComValores({super.key});

  @override
  _BarraComValoresState createState() => _BarraComValoresState();
}

class _BarraComValoresState extends State<BarraComValores> {
  double valorDaBarra = 0; // Valor que será atualizado e refletido na barra 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barras Dinâmicas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Primeira barra (de valores de 0 a 20 na lateral)
            Container(
              width: 50,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(21, (index) {
                  return Text(
                    '$index',
                    style: const TextStyle(fontSize: 10),
                  );
                }),
              ),
            ),
            const SizedBox(width: 10),
            // Segunda barra (que irá aumentar conforme os dados)
            CustomPaint(
              size: const Size(50, 200),
              painter: BarraPainter(valorDaBarra),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Simula a atualização da variável (exemplo de dados recebidos)
          setState(() {
            valorDaBarra = (valorDaBarra + 5) % 21; // Valores de 0 a 20
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BarraPainter extends CustomPainter {
  final double valor;

  BarraPainter(this.valor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Desenha a segunda barra, com altura variável
    double alturaBarra = (valor / 20) * size.height;
    canvas.drawRect(
        Rect.fromLTWH(0, size.height - alturaBarra, size.width, alturaBarra),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
