// import 'package:button_animation_flutter/logger/logger.dart';
// import 'package:flutter/material.dart';

//   //------------------------------------------------
//   //------------------------------------------------
//   //------------------------------------------------
//   // ----------- ICON IN PLACE OF WIDGET -----------
//   //------------------------------------------------
//   //------------------------------------------------
//   //------------------------------------------------

// class AnimatedButton extends StatefulWidget {
//   final Function onPressed;
//   final String initialText, finalText;
//   final ButtonStyle buttonStyle;
//   final IconData iconData;
//   final double iconSize;
//   final Duration animationDuration;

//   AnimatedButton({
//     this.onPressed,
//     this.initialText,
//     this.finalText,
//     this.buttonStyle,
//     this.iconData,
//     this.iconSize,
//     this.animationDuration,
//   });

//   @override
//   _AnimatedButtonState createState() => _AnimatedButtonState();
// }

// class _AnimatedButtonState extends State<AnimatedButton>
//     with TickerProviderStateMixin {
//   AnimationController _controller;
//   Animation _scaleFinalTextAnimation;
//   Duration _smallDuration;

//   ButtonState _buttonState;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _buttonState = ButtonState.SHOW_ONLY_TEXT;
//     _smallDuration = Duration(
//         seconds: (widget.animationDuration.inMilliseconds * 0.2).round());

//     _controller = AnimationController(
//       vsync: this,
//       duration: widget.animationDuration,
//     );
//     _controller.addListener(
//       () {
//         //Log.debug("Animation", _controller.value.toString());
//         if (_controller.value < 0.2) {
//           setState(() {
//             _buttonState = ButtonState.SHOW_ONLY_ICON;
//           });
//         } else if (_controller.value > 0.8) {
//           setState(() {
//             _buttonState = ButtonState.SHOW_TEXT_ICON;
//           });
//         }
//       },
//     );
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         return widget.onPressed();
//       }
//     });
//     _scaleFinalTextAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: widget.buttonStyle.elevation,
//       borderRadius: BorderRadius.circular(widget.buttonStyle.borderRadius),
//       child: InkWell(
//         onTap: () {
//           _controller.forward();
//           // setState(() {
//           //   _buttonState = ButtonState.SHOW_ONLY_ICON;
//           // });
//         },
//         child: AnimatedContainer(
//           duration: widget.animationDuration * 0.4,
//           height: widget.iconSize + 16,
//           padding: EdgeInsets.symmetric(
//             horizontal:
//                 (_buttonState == ButtonState.SHOW_ONLY_ICON) ? 12.0 : 48.0,
//             vertical: 8.0,
//           ),
//           decoration: BoxDecoration(
//             color: (_buttonState == ButtonState.SHOW_ONLY_ICON ||
//                     _buttonState == ButtonState.SHOW_TEXT_ICON)
//                 ? widget.buttonStyle.secondaryColor
//                 : widget.buttonStyle.primaryColor,
//             borderRadius:
//                 BorderRadius.circular(widget.buttonStyle.borderRadius),
//             border: Border.all(
//                 color: (_buttonState == ButtonState.SHOW_ONLY_ICON ||
//                         _buttonState == ButtonState.SHOW_TEXT_ICON)
//                     ? widget.buttonStyle.primaryColor
//                     : Colors.transparent),
//           ),
//           child: AnimatedSize(
//             vsync: this,
//             duration: widget.animationDuration * 0.4,
//             curve: Curves.easeIn,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 (_buttonState == ButtonState.SHOW_ONLY_ICON ||
//                         _buttonState == ButtonState.SHOW_TEXT_ICON)
//                     ? Icon(
//                         widget.iconData,
//                         size: widget.iconSize,
//                         color: widget.buttonStyle.primaryColor,
//                       )
//                     : Container(),
//                 SizedBox(
//                   width:
//                       _buttonState == ButtonState.SHOW_TEXT_ICON ? 30.0 : 0.0,
//                 ),
//                 getTextWidget(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget getTextWidget() {
//     if (_buttonState == ButtonState.SHOW_ONLY_TEXT) {
//       return Text(
//         widget.initialText,
//         style: widget.buttonStyle.initialTextStyle,
//       );
//     } else if (_buttonState == ButtonState.SHOW_ONLY_ICON) {
//       return Container();
//     } else {
//       return ScaleTransition(
//         scale: _scaleFinalTextAnimation,
//         child: Text(
//           widget.finalText,
//           style: widget.buttonStyle.finalTextStyle,
//         ),
//       );
//     }
//   }
// }

// class ButtonStyle {
//   final TextStyle initialTextStyle, finalTextStyle;
//   final Color primaryColor, secondaryColor;
//   final double elevation;
//   final double borderRadius;

//   ButtonStyle({
//     this.initialTextStyle,
//     this.finalTextStyle,
//     this.primaryColor,
//     this.secondaryColor,
//     this.elevation,
//     this.borderRadius,
//   });
// }

// enum ButtonState {
//   SHOW_ONLY_TEXT,
//   SHOW_ONLY_ICON,
//   SHOW_TEXT_ICON,
// }
