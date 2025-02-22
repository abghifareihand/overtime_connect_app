import 'package:overtime_connect_app/features/base_view_model.dart';

class MenuViewModel extends BaseViewModel {
  int selectedIndex = 0;

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  void onTabSelected(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      notifyListeners();
    }
  }
}
