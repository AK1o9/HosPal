import 'package:flutter/cupertino.dart';
import 'package:hospal/api/screen_responsiveness/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;
  const ResponsiveLayout(
      {Key? key, required this.mobileBody, required this.desktopBody})
      : super(key: key);

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileWidth;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidth) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
