import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qrmenu/core/extension/context_extension.dart';
import 'package:qrmenu/core/init/provider/create_product_provider.dart';
import 'package:qrmenu/product/widget/text_field.dart';

import '../../../../product/utility/page_padding.dart';
import '../../../../product/widget/elevation_button.dart';
import 'nutrition_facts_check_box_builder.dart';

late final TextEditingController _fibreController;
Future<dynamic> addNutritionFactsDialog(
  BuildContext context,
  TextEditingController proteinController,
  TextEditingController carbohydrateController,
  TextEditingController fatController,
  TextEditingController fibreController,
) {
  return showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Padding(
              padding: PagePadding.allMedium(),
              child: Wrap(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nutrition Facts",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: context.text.headlineSmall?.fontSize),
                    ),
                    IconButton(
                        onPressed: () => context.pop(), icon: Icon(Icons.close))
                  ],
                ),
                Text(
                    "Check only if you want to show dietary info with your item"),
                Consumer<CreateProductProvider>(
                  builder: (context, provider, child) => Column(children: [
                    NutritionFactsCheckBoxBuilder(
                      textController: proteinController,
                      title: "Protein",
                      onChangedField: (value) =>
                          provider.changeNutritions(0, int.parse(value)),
                    ),
                    NutritionFactsCheckBoxBuilder(
                        textController: carbohydrateController,
                        title: "Carbs",
                        onChangedField: (value) =>
                            provider.changeNutritions(1, int.parse(value))),
                    NutritionFactsCheckBoxBuilder(
                        textController: fatController,
                        title: "Fats",
                        onChangedField: (value) =>
                            provider.changeNutritions(2, int.parse(value))),
                    NutritionFactsCheckBoxBuilder(
                        textController: fibreController,
                        title: "Fibre",
                        onChangedField: (value) =>
                            provider.changeNutritions(3, int.parse(value))),
                    Padding(
                      padding: PagePadding.allMedium(),
                      child: Consumer<CreateProductProvider>(
                        builder: (context, provider, child) => Text(
                          "Calories(KCal): ${provider.calculateCalories()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.text.titleLarge?.fontSize),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonElevationButton(
                            child: Padding(
                              padding: PagePadding.allMedium(),
                              child: Text("Save"),
                            ),
                            onPressed: () => context.pop(),
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ]),
            ),
          ));
}
