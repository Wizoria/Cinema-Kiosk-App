import 'package:flutter/material.dart';
import '../../../service/app_manager.dart';
import '../../../service/common_functions.dart';
import '../../styles/styles.dart';
import '../../themes/themes.dart';

class PromoModalDialog extends StatelessWidget {
  const PromoModalDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: adaptWidgetHeight(500)),
        width: adaptWidgetWidth(620),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(adaptWidgetHeight(25))),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(adaptWidgetWidth(15)),
              child: MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: adaptWidgetWidth(32),
                height: adaptWidgetWidth(32),
                shape:
                CircleBorder(side: BorderSide(width: adaptWidgetWidth(1), color: gray)),
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  color: gray,
                  size: adaptWidgetWidth(12),
                ),
                // ),
              ),
            ),
            Positioned(
              top: adaptWidgetHeight(70),
              child: Text(
                'Застосуйте промокод',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Positioned(
              bottom: adaptWidgetHeight(30),
              child: GradientButton(
                width: adaptWidgetHeight(175),
                height: adaptWidgetHeight(50),
                borderWidth: adaptWidgetWidth(2),
                borderRadius: BorderRadius.circular(25),
                borderGradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.onPrimary,
                  ],
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                ),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.onPrimaryContainer,
                  ],
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Підтвердити',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.apply(color: white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: adaptWidgetHeight(130), bottom: adaptWidgetHeight(100)),
              child: RawScrollbar(
                thumbColor:
                    AppManager().isDarkThemeOn ? Colors.grey : Colors.black54,
                thumbVisibility: true,
                thickness: adaptWidgetWidth(5),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      11,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: adaptWidgetWidth(85),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Квиток ряд 6, місце 11',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Row(
                                    children: [
                                      Text('190 ₴',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .apply(color: gray)),
                                      SizedBox(
                                        width: adaptWidgetWidth(10),
                                      ),
                                      Text('85 ₴',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: adaptWidgetHeight(6),
                              ),
                              Container(
                                width: double.maxFinite,
                                height: adaptWidgetHeight(50),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: adaptWidgetWidth(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('українапереможе',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall),
                                      ButtonPromo(
                                        isActive: false,
                                        onPressed: () => print('ok'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: adaptWidgetHeight(28)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
