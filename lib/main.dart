import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return ItemTransition(
              index: index,
              child: const Item(),
            );
          },
        ),
      ),

      // ListView.builder(
      //   itemCount: 10,
      //   itemBuilder: (BuildContext context, int index) {
      //     return ItemTransition(
      //       index: index,
      //       child: const Item(),
      //     );
      //   },
      // ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

class ItemTransition extends StatefulWidget {
  const ItemTransition({super.key, required this.child, required this.index});
  final Widget child;
  final int index;
  @override
  State<ItemTransition> createState() => _ItemTransitionState();
}

class _ItemTransitionState extends State<ItemTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> animation;
  late Animation<double> fadeandScaleAnimation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200 * widget.index),
    );

    //SlideTransition must be type of Tween<offest> animation

    animation = Tween<Offset>(
            begin: const Offset(0.0, -2.0), end: const Offset(0.0, 0.0))
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // FadeTransition and ScaleTransition must be type of Tween<double> animation

    fadeandScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  // ensure your animationcontroller disposed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: fadeandScaleAnimation,
      child: widget.child,
    );
  }
}
