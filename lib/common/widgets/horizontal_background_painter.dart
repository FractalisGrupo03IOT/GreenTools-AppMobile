import 'package:flutter/material.dart';

class HorizontalBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF3A785D) // Color verde
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0) // Inicia en la parte superior izquierda
      ..lineTo(size.width, 0) // Línea horizontal en la parte superior
      ..lineTo(size.width, size.height * 0.5) // Baja hasta la mitad de la altura
      ..lineTo(0, size.height * 0.5) // Baja a la parte inferior izquierda
      ..close(); // Cierra el camino

    canvas.drawPath(path, paint);

    // Opcional: si deseas rellenar el resto del fondo con otro color, puedes agregarlo aquí
    final backgroundPaint = Paint()
      ..color = Color(0xFFA8D5BA) // Color de fondo (blanco en este caso)
      ..style = PaintingStyle.fill;

    final backgroundPath = Path()
      ..moveTo(0, size.height * 0.5) // Mueve al inicio de la parte inferior
      ..lineTo(size.width, size.height * 0.5) // Línea horizontal en la mitad
      ..lineTo(size.width, size.height) // Baja a la parte inferior derecha
      ..lineTo(0, size.height) // Baja a la parte inferior izquierda
      ..close(); // Cierra el camino

    canvas.drawPath(backgroundPath, backgroundPaint); // Dibuja el fondo
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
