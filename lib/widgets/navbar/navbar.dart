import 'package:flutter/material.dart';
import 'onhover.dart';
import '../../app_config.dart';

class DesktopNavbar extends StatelessWidget {
  final GlobalKey<NavigatorState> nagivator = GlobalKey();
  // const DesktopNavbar({Key? key,required this.isloggedin,}) : super(key: key);
  static late AppConfig config;
  DesktopNavbar(AppConfig config) {
    DesktopNavbar.config = config;
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 200,
      leading: OverflowBox(
        maxWidth: 300,
        child: OnHoverButton(builder: (isHovered) {
          final colorOfButton = isHovered ? Colors.orange : Colors.black;
          return TextButton(
            onPressed: () => nagivator.currentState!.pushReplacementNamed("/"),
            child: Text(
              "الرئيسي",
              style: TextStyle(color: colorOfButton),
            ),
          );
        }),
      ),
      actions: [
        const Spacer(flex: 36),
        OnHoverButton(builder: (isHovered) {
          final colorOfButton = isHovered ? Colors.orange : Colors.black;
          return TextButton(
              onPressed: () {},
              child: Text(
                "Button1",
                style: TextStyle(color: colorOfButton),
              ));
        }),
        const Spacer(flex: 1),
        TextButton(onPressed: () {}, child: const Text("Button2")),
        const Spacer(flex: 1),
        TextButton(onPressed: () {}, child: const Text("Button3")),
        const Spacer(flex: 2),
      ],
    );
  }
}
