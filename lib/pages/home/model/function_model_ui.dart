class FunctionModelUI {
  bool showSingleArrow;
  bool showSwitch;
  String iconPath;
  String title;
  bool switchValue;
  FunctionEnum functionEnum;
  FunctionModelUI({
    required this.iconPath,
    required this.title,
    this.showSingleArrow = true,
    this.showSwitch = true,
    this.switchValue = false,
    required this.functionEnum,
  });
}

enum FunctionEnum {
  oneKey,
  fallAndCallForHelp,
  shakeToUnlock,
  bikingAuthorization,
  automaticUnlocking,
  afterSalesService,
}
