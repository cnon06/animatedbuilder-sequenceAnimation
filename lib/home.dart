import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: Duration.zero,
            to: const Duration(seconds: 1),
            tag: 'opacity1')
        .addAnimatable(
            animatable: Tween<double>(begin: 50, end: 150),
            from: const Duration(seconds: 1),
            to: const Duration(seconds: 2),
            tag: 'width1')
        .addAnimatable(
            animatable: Tween<double>(begin: 50, end: 150),
            from: const Duration(seconds: 2),
            to: const Duration(seconds: 3),
            tag: 'height1')
        .addAnimatable(
            animatable: BorderRadiusTween(
                begin: BorderRadius.circular(0),
                end: BorderRadius.circular(100)),
            from: const Duration(seconds: 3),
            to: const Duration(seconds: 4),
            curve: Curves.bounceInOut,
            tag: 'radius1')
        .addAnimatable(
            animatable: ColorTween(begin: Colors.amber, end: Colors.blue),
            from: const Duration(seconds: 4),
            to: const Duration(seconds: 5),
            curve: Curves.easeIn,
            tag: 'color1')
        .animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: sequenceAnimation['opacity1'].value,
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(width: 1, color: Colors.pink),
                      color: sequenceAnimation['color1'].value,
                      borderRadius: sequenceAnimation['radius1']
                          .value, //BorderRadius.circular(0),
                    ),

                    height: sequenceAnimation['height1'].value,
                    width: sequenceAnimation['width1'].value,
                    // child: Center(child: Text('Hello World')),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  animationController.forward(from: 0);
                },
                child: const Text('Start'))
          ],
        ),
      ),
    );
  }
}
