import 'package:flutter/cupertino.dart';
import '../utils/custom_colors.dart';

class CustomSlidableWidget extends StatefulWidget {
  const CustomSlidableWidget({
    super.key,
    required this.options,
    required this.onTap,
    required this.initialValue,
    this.choseColor = CustomColor.gray_darker,
    this.backgroundColor = CustomColor.white,
  });
  final List<String> options;
  final Function(int slide) onTap;
  final int initialValue;
  final Color? backgroundColor;
  final Color? choseColor;
  @override
  State<CustomSlidableWidget> createState() => _CustomSlidableWidgetState();
}

class _CustomSlidableWidgetState extends State<CustomSlidableWidget>
    with AutomaticKeepAliveClientMixin {
  Map<int, Widget> map = {};
  var _status = 0;

  @override
  void initState() {
    super.initState();
    _status = widget.initialValue;
    for (var i = 0; i < widget.options.length; i++) {
      map.addAll(
        {
          i: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  widget.options[i].trim(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: i == _status
                          ? CustomColor.yellow
                          : CustomColor.gray_dark,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = MediaQuery.of(context).size.width;

    return Container(
        width: width,
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: CustomColor.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CupertinoSlidingSegmentedControl(
            padding: const EdgeInsets.all(0),
            backgroundColor: widget.backgroundColor!,
            thumbColor: widget.choseColor!,
            children: map,
            groupValue: _status,
            onValueChanged: (newValue) {
              setState(() {
                _status = newValue!;
                widget.onTap(newValue);
                for (var i = 0; i < widget.options.length; i++) {
                  map.addAll(
                    {
                      i: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              widget.options[i].trim(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: i == _status
                                    ? CustomColor.yellow
                                    : CustomColor.gray_dark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    },
                  );
                }
              });
            }));
  }

  @override
  //
  bool get wantKeepAlive => true;
}
