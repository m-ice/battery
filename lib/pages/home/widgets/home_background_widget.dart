import 'package:battery/app_library.dart';

class HomeBackgroundWidget extends StatelessWidget {
  final Widget child;
  final String? backGroundPath;

  const HomeBackgroundWidget(
      {super.key, required this.child, this.backGroundPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ImageWidget(
            imageUrl: backGroundPath ?? AssetsImages.vircBgPng,
            width: MediaQuery.of(context).size.width,
            height: 398.hi,
          ),
          child,
        ],
      ),
    );
  }
}
