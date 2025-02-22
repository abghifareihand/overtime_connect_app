import 'package:flutter/material.dart';
import 'package:overtime_connect_app/features/base_view.dart';
import 'package:overtime_connect_app/features/widget-showcase/widget_showcase_view_model.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';

class WidgetShowcaseView extends StatelessWidget {
  const WidgetShowcaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<WidgetShowcaseViewModel>(
      model: WidgetShowcaseViewModel(),
      onModelReady: (WidgetShowcaseViewModel model) => model.initModel(),
      onModelDispose: (WidgetShowcaseViewModel model) => model.disposeModel(),
      builder: (BuildContext context, WidgetShowcaseViewModel model, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Title'),
          ),
          backgroundColor: AppColor.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, WidgetShowcaseViewModel model) {
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.primary,
      ),
    );
  }
  return ListView(
    children: [],
  );
}
