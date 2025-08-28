import 'package:battery/app_library.dart';


class LoginBgWidget extends StatelessWidget {
  final String bgPath;
  final Widget? child;
  final List<Widget>? children;
  const LoginBgWidget({super.key, this.child,  this.children, required this.bgPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned.fill(child: ImageWidget(imageUrl: bgPath,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,)),
                if(child!=null)Positioned.fill(child: child!),
                 if(children!=null)...children!,
              ],
            ),
          );
  }
}