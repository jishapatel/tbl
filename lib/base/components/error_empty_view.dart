import 'package:flutter/material.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

import '../src_constants.dart';
import '../widgets/button_view.dart';

enum _QuickViewType { error, empty }

/// A [QuickView] widget that provides out-of-the-box implementation
/// for quick and simple use cases.
class QuickView extends StatelessWidget {
  final _QuickViewType? type;
  final String? title;
  final Function()? onRetry;
  final Color? textColor;
  final double? textSize;

  QuickView._(
      {this.type, this.title, this.onRetry, this.textColor, this.textSize});

  factory QuickView.error({String? title,
    Function()? onRetry,
    String? retryText,
    Color? textColor,
    double? textSize}) {
    return QuickView._(
      type: _QuickViewType.error,
      title: title,
      onRetry: onRetry,
      textColor: textColor,
      textSize: textSize,
    );
  }

  factory QuickView.empty({String? title, Color? textColor, double? textSize}) {
    return QuickView._(
      type: _QuickViewType.empty,
      title: title,
      textColor: textColor,
      textSize: textSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = title == null
        ? Container()
        : Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(title!,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: textSize ?? 21.sp,
              fontWeight: FontWeight.bold,
              color: textColor),
          textAlign: TextAlign.center),
    );
    final r = onRetry == null
        ? Container()
        : ButtonView(
      "Retry",
      onRetry,
      color: ACCENT_COLOR,
    );

    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    t,
                    SizedBox(height: 8),
                    r,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PlaceHolderView {
  final String? title;
  final Function()? onRetry;

  PlaceHolderView({this.title = "", this.onRetry});
}
