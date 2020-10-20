import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final Function onPressed;
  final String initialText, finalText;
  final Widget widgetData;
  final double iconSize;
  final Duration animationDuration;
  final ButtonStyles buttonStyles;

  AnimatedButton({
    this.onPressed,
    this.initialText,
    this.finalText,
    this.widgetData,
    this.iconSize,
    this.animationDuration,
    this.buttonStyles,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _scaleAnimation;
  CurrentState _currentState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentState = CurrentState.SHOW_ONLY_TEXT;
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _controller.addListener(
      () {
        // --------  Maintaining the states per condition
        if (_controller.value < 0.2) {
          setState(() {
            _currentState = CurrentState.SHOW_ONLY_ICON;
          });
        } else if (_controller.value > 0.9) {
          setState(() {
            _currentState = CurrentState.SHOW_TEXT_ICON;
          });
        }
      },
    );
    // --------  When button pressed is completed
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          return widget.onPressed();
        }
      },
    );
    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(widget.buttonStyles.borderRadius),
      elevation: widget.buttonStyles.elevation,
      child: InkWell(
        onTap: () {
          _controller.forward();
        },
        child: AnimatedContainer(
          duration: widget.animationDuration * 0.6,
          decoration: BoxDecoration(
            color: (_currentState == CurrentState.SHOW_ONLY_ICON ||
                    _currentState == CurrentState.SHOW_TEXT_ICON)
                ? widget.buttonStyles.secondaryColor
                : widget.buttonStyles.primaryColor,
            borderRadius:
                BorderRadius.circular(widget.buttonStyles.borderRadius),
            border: Border.all(
                color: _currentState == CurrentState.SHOW_ONLY_TEXT
                    ? widget.buttonStyles.secondaryColor
                    : widget.buttonStyles.primaryColor),
          ),
          height: widget.iconSize + 16.0,
          padding: EdgeInsets.symmetric(
              horizontal:
                  _currentState == CurrentState.SHOW_ONLY_ICON ? 15.0 : 40.0,
              vertical: 8.0),
          child: AnimatedSize(
            vsync: this,
            duration: widget.animationDuration * 0.4,
            curve: Curves.easeIn,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getWidget(),
                SizedBox(
                  width:
                      _currentState == CurrentState.SHOW_TEXT_ICON ? 20.0 : 0.0,
                ),
                getTextWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getWidget() {
    if (_currentState == CurrentState.SHOW_ONLY_TEXT) {
      return Container();
    } else if (_currentState == CurrentState.SHOW_ONLY_ICON) {
      return SizedBox(
        width: 20.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(
            (widget.buttonStyles.primaryColor),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 20.0,
        child: Icon(
          Icons.done,
          size: widget.iconSize,
          color: widget.buttonStyles.primaryColor,
        ),
      );
    }
  }

  Widget getTextWidget() {
    if (_currentState == CurrentState.SHOW_ONLY_TEXT) {
      return Text(
        widget.initialText,
        style: widget.buttonStyles.initialTextStyle,
      );
    } else if (_currentState == CurrentState.SHOW_ONLY_ICON) {
      return Container();
    } else {
      return ScaleTransition(
        scale: _scaleAnimation,
        child: Text(
          widget.finalText,
          style: widget.buttonStyles.finalTextStyle,
        ),
      );
    }
  }
}

class ButtonStyles {
  final TextStyle initialTextStyle, finalTextStyle;
  final Color primaryColor, secondaryColor;
  final double elevation;
  final double borderRadius;

  ButtonStyles({
    this.initialTextStyle,
    this.finalTextStyle,
    this.primaryColor,
    this.secondaryColor,
    this.elevation,
    this.borderRadius,
  });
}

enum CurrentState {
  SHOW_ONLY_TEXT,
  SHOW_ONLY_ICON,
  SHOW_TEXT_ICON,
}
