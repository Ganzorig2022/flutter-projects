import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashapp/components/dropdown_list.dart';
import 'package:cashapp/components/loading_widget.dart';
import 'package:cashapp/constants/values.dart';
import 'package:cashapp/model/reference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FormDropDown extends StatelessWidget {
  const FormDropDown({
    Key? key,
    required this.attribute,
    required this.formKey,
    this.label,
    required this.items,
    this.validators,
  }) : super(key: key);

  final String attribute;
  final String? label;
  final List<Reference?> items;
  final String? Function(String?)? validators;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ValueListenableBuilder(
          valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
          builder: (context, mode, child) {
            return FormBuilderField(
              name: attribute,
              validator: validators,
              onChanged: (v) {},
              builder: (field) {
                final Reference? value = items.firstWhere((element) => element?.id == field.value, orElse: () => Reference.fromJson({}));
                bool isSelected = field.value != null;
                return InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final String? selectedValue = await showCupertinoModalBottomSheet<String?>(
                      expand: false,
                      context: context,
                      isDismissible: false,
                      enableDrag: true,
                      topRadius: Radius.circular(12),
                      builder: (context) => DropDownList(
                        items: items,
                        label: label,
                        selectedValue: field.value?.toString(),
                      ),
                    );

                    if (selectedValue?.isNotEmpty ?? false) {
                      field.didChange(selectedValue);
                    }
                  },
                  child: InputDecorator(
                    isFocused: false,
                    decoration: InputDecoration(
                      labelStyle: labelStyle(mode),
                      labelText: label?.capitalizeFirst,
                      hintText: label?.capitalizeFirst,
                      hintStyle: TextStyle(color: Theme.of(context).hintColor),
                      border: outLinedBorder(mode),
                      enabledBorder: outLinedBorder(mode),
                      focusedBorder: outLinedFocusedBorder(mode),
                      disabledBorder: outLinedBorder(mode),
                      errorBorder: outLinedErrorBorder,
                      floatingLabelBehavior: isSelected ? FloatingLabelBehavior.always : FloatingLabelBehavior.never,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      errorText: field.errorText,
                      isDense: true,
                    ),
                    child: Row(
                      children: [
                        if (value?.img?.isNotEmpty ?? false)
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0, left: 4),
                            child: CachedNetworkImage(
                              imageUrl: value!.img!,
                              height: 26,
                              width: 26,
                              placeholder: (c, v) => LoadingWidget(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            isSelected ? value?.name?.capitalizeFirst ?? '' : label?.capitalizeFirst ?? '',
                            style: isSelected ? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500) : TextStyle(color: Theme.of(context).hintColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: ImageIcon(
                            AssetImage(mode == AdaptiveThemeMode.dark ? 'assets/icons/dropdown_light.png' : 'assets/icons/dropdown_dark.png'),
                            size: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
