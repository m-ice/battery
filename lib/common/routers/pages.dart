import 'index.dart';

class RoutePages {
  // 列表
  static List<GetPage> list = [
    GetPage(
        name: RouteNames.home,
        page: () => const HomePage(),
        binding: HomeBinding(),
        children: [
          GetPage(name: RouteNames.login, page: () => const LoginPage()),
          GetPage(
              name: RouteNames.otherEmailLogin,
              page: () => const OtherEmailLoginView()),
          GetPage(
              name: RouteNames.scanQRCode, page: () => const ScanQrCodePage()),
          GetPage(
              name: RouteNames.bindBattery,
              page: () => const BindBatteryPage()),
          GetPage(
              name: RouteNames.addDevice, page: () => const AddDevicePage()),
          GetPage(
              name: RouteNames.personalInformation,
              page: () => const PersonalInformationPage()),
          GetPage(
              name: RouteNames.languageSettings,
              page: () => const LanguageSettingsPage()),
          GetPage(name: RouteNames.aboutUs, page: () => const AboutusPage()),
          GetPage(
              name: RouteNames.cuttingImage,
              page: () => const CuttingImagePage()),
          GetPage(
              name: RouteNames.emergencyContactPerson,
              page: () => const EmergencyContactPersonPage()),
          GetPage(
              name: RouteNames.travelTrajectory,
              page: () => const TravelTrajectoryPage()),
          GetPage(
              name: RouteNames.travelTrajectoryDetails,
              page: () => const TravelTrajectoryDetailsPage()),
        ]),
  ];
}
