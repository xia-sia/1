import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovingCharacterScreen(),
    );
  }
}

class MovingCharacterScreen extends StatefulWidget {
  @override
  _MovingCharacterScreenState createState() => _MovingCharacterScreenState();
}

class _MovingCharacterScreenState extends State<MovingCharacterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;

  bool _isSmiling = false; // ���� ���¸� ��Ÿ��

  @override
  void initState() {
    super.initState();

    // �ִϸ��̼� ��Ʈ�ѷ� �ʱ�ȭ
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // x��� y�� �ִϸ��̼� ���� ����
    _xAnimation = Tween<double>(begin: 50.0, end: 300.0).animate(_controller);
    _yAnimation = Tween<double>(begin: 50.0, end: 600.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCharacterTap() {
    setState(() {
      _isSmiling = true; // ���� ���·� ����
    });

    // 3�� �� �⺻ ���·� ����
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isSmiling = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interactive Character with GIF'),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                left: _xAnimation.value,
                top: _yAnimation.value,
                child: GestureDetector(
                  onTap: _onCharacterTap,
                  child: _isSmiling
                      ? Image.asset(
                          'assets/smiling_character.gif', // ���� GIF
                          width: 50,
                          height: 50,
                        )
                      : Image.asset(
                          'assets/character.png', // �⺻ �̹���
                          width: 50,
                          height: 50,
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}