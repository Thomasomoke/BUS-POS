import 'package:bus_pos/core/config/size_config.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? bgColor;
  final bool hasBorder;
  final bool isLoading;
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.bgColor,
    this.hasBorder = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight! * 0.07,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          border: hasBorder
              ? Border.all(
                  width: 2.0,
                  color: const Color.fromARGB(255, 95, 99, 104),
                )
              : null,
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
                  text,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium!.copyWith(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
