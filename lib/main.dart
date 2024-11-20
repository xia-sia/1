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

  bool _isSmiling = false; // 웃는 상태를 나타냄

  @override
  void initState() {
    super.initState();

    // 애니메이션 컨트롤러 초기화
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // x축과 y축 애니메이션 범위 설정
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
      _isSmiling = true; // 웃는 상태로 변경
    });

    // 3초 후 기본 상태로 복원
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
                          'assets/smiling_character.gif', // 웃는 GIF
                          width: 50,
                          height: 50,
                        )
                      : Image.asset(
                          'assets/character.png', // 기본 이미지
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