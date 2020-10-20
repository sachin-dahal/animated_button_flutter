import 'package:button_animation_flutter/logger/logger.dart';
import 'package:flutter/material.dart';

import 'button-widget/animated_widget_button.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedButton(
          onPressed: () {
            Log.debug("Confirm Button", "BUtton got Pressed");
          },
          initialText: "Confirm",
          finalText: "Done",
          widgetData: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.green),
          ),
          iconSize: 25.0,
          animationDuration: Duration(seconds: 2),
          buttonStyles: ButtonStyles(
            initialTextStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            finalTextStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.green,
              fontWeight: FontWeight.w300,
            ),
            primaryColor: Colors.green,
            secondaryColor: Colors.white,
            elevation: 20.0,
            borderRadius: 10.0,
          ),
        ),
      ),
    );
  }
}

// child: AnimatedButton(
//   onPressed: () {
//     Log.debug("Button", "Button Pressed");
//   },
//   initialText: "Confirm",
//   finalText: "Submitted",
//   iconData: Icons.done,
//   iconSize: 26.0,
//   animationDuration: Duration(seconds: 2),
//   buttonStyle: ButtonStyle(
//     initialTextStyle: TextStyle(
//       fontSize: 20.0,
//       fontWeight: FontWeight.w300,
//       color: Colors.white,
//     ),
//     finalTextStyle: TextStyle(
//       fontSize: 20.0,
//       fontWeight: FontWeight.w300,
//       color: Colors.green,
//     ),
//     primaryColor: Colors.green,
//     secondaryColor: Colors.white,
//     elevation: 20.0,
//     borderRadius: 10.0,
//   ),
// ),
