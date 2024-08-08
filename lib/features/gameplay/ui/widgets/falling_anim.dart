import 'package:flutter/material.dart';

class FallingCloudSection extends StatefulWidget {
  const FallingCloudSection({super.key, required this.fallingCloudContainer});
  final Widget fallingCloudContainer;

  @override
  State<FallingCloudSection> createState() => _FallingCloudSectionState();
}

class _FallingCloudSectionState extends State<FallingCloudSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> _animation;

  final Tween<Offset> tween = Tween<Offset>(
    begin: const Offset(0.0, -1.0), // Starts off-screen at the top
    end: const Offset(1.0, 1.0), // Ends on-screen at the bottom
  );

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = tween.animate(controller);
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    print("Animvalue");
    print(_animation.value);
    return Container(
      height: 200,
      width: 200,
      color: Colors.red,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.translate(
            offset: _animation.value,
            child: child,
          );
        },
        child: widget.fallingCloudContainer,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
