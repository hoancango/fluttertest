
import 'dart:math';
import 'package:flutter/material.dart';

class PendulumSimulation extends StatefulWidget {
  const PendulumSimulation({super.key});

  @override
  State<PendulumSimulation> createState() => _PendulumSimulationState();
}

class _PendulumSimulationState extends State<PendulumSimulation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final double pendulumLength = 200.0; // Chiều dài dây
  final double maxAngle = pi / 4; // Góc lệch tối đa (45 độ)
  final double gravity = 9.8; // Gia tốc trọng trường

  @override
  void initState() {
    super.initState();

    // Tạo AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Chu kỳ dao động
      vsync: this,
    )..repeat(reverse: true);

    // Animation dao động
    _animation = Tween<double>(begin: -maxAngle, end: maxAngle).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pendulum Simulation")),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: PendulumPainter(
                angle: _animation.value,
                length: pendulumLength,
              ),
              child: const SizedBox.expand(),
            );
          },
        ),
      ),
    );
  }
}

class PendulumPainter extends CustomPainter {
  final double angle; // Góc hiện tại của con lắc
  final double length; // Chiều dài dây

  PendulumPainter({required this.angle, required this.length});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 4); // Điểm treo
    final pendulumEnd = Offset(
      center.dx + length * sin(angle),
      center.dy + length * cos(angle),
    );

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // Vẽ dây
    canvas.drawLine(center, pendulumEnd, paint);

    // Vẽ vật nặng
    canvas.drawCircle(pendulumEnd, 15, paint..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
