import 'package:bus_pos/common/widgets/app_bottom_navbar.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  final Widget child;
  final bool resizeToAvoidBottomInset;
  final String? title;
  final bool showBackButton;
  final PreferredSizeWidget? bottom;
  final int? currentIndex;
  final Function(int)? onNavTap;

  const PageLayout({
    super.key,
    required this.child,
    this.title,
    this.resizeToAvoidBottomInset = false,
    this.showBackButton = true,
    this.bottom,
    this.currentIndex,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: title != null
          ? AppBar(
              title: Text(
                title!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              leading: showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.maybePop(context),
                    )
                  : null,
              elevation: 1,
              bottom: bottom,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: currentIndex != null && onNavTap != null
              ? const EdgeInsets.all(0)
              : const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: child,
        ),
      ),
      bottomNavigationBar: (currentIndex != null && onNavTap != null)
          ? AppBottomNavbar(currentIndex: currentIndex!, onTap: onNavTap!)
          : null,
    );
  }
}
