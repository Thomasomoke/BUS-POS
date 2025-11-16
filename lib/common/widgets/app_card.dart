import 'package:flutter/material.dart';
    
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final BorderRadiusGeometry borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.elevation = 4,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}
