import 'dart:async';
import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  final List<String> texts;
  final TextStyle style;
  final Duration typeSpeed;
  final Duration deleteSpeed;
  final Duration pauseDuration;

  const TypingText({
    super.key,
    required this.texts,
    required this.style,
    this.typeSpeed = const Duration(milliseconds: 100),
    this.deleteSpeed = const Duration(milliseconds: 50),
    this.pauseDuration = const Duration(milliseconds: 1500),
  });

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  String _currentText = "";
  int _textIndex = 0;
  int _charIndex = 0;
  bool _isDeleting = false;
  Timer? _timer;
  bool _showCursor = true;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _startCursorBlink();
    _scheduleTick();
  }

  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _showCursor = !_showCursor;
        });
      }
    });
  }

  void _scheduleTick() {
    final delay = _isDeleting
        ? widget.deleteSpeed
        : (_charIndex == 0 ? const Duration(milliseconds: 200) : widget.typeSpeed);
    
    _timer = Timer(delay, _handleTick);
  }

  void _handleTick() {
    if (!mounted) return;

    final targetText = widget.texts[_textIndex];

    setState(() {
      if (!_isDeleting) {
        if (_charIndex < targetText.length) {
          _charIndex++;
          _currentText = targetText.substring(0, _charIndex);
          _scheduleTick();
        } else {
          // Pause before deleting
          _timer = Timer(widget.pauseDuration, () {
            if (mounted) {
              setState(() {
                _isDeleting = true;
                _scheduleTick();
              });
            }
          });
        }
      } else {
        if (_charIndex > 0) {
          _charIndex--;
          _currentText = targetText.substring(0, _charIndex);
          _scheduleTick();
        } else {
          _isDeleting = false;
          _textIndex = (_textIndex + 1) % widget.texts.length;
          _scheduleTick();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_currentText, style: widget.style),
        AnimatedOpacity(
          opacity: _showCursor ? 1.0 : 0.0,
          duration: Duration.zero,
          child: Text(
            '|',
            style: widget.style.copyWith(
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
      ],
    );
  }
}
