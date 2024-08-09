import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.showAppBar = true,
    this.showDrawer = false,
    required this.child,
    this.padding,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.bottomSheet,
    this.appBar,
  });

  final bool showAppBar;
  final bool showDrawer;

  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget child;
  final EdgeInsets? padding;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: child,
        ),
      ),
      bottomSheet: bottomSheet,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
