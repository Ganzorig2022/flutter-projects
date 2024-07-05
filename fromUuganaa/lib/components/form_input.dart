import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../constants/values.dart';

class FormInput extends StatefulWidget {
  final TextEditingController? controller;
  final GlobalKey<FormBuilderState> formKey;
  final String attribute;
  final String? label;
  final String? hintText;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final String? initialValue;
  final bool obscureText;
  final bool hasObscureControl;
  final bool autoFocus;
  final bool readOnly;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final Function? onComplete;
  final String? Function(String?)? validators;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final int? maxLenght;
  final bool showCounter;
  final Function(dynamic)? onChanged;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Widget? prefixIcon;
  final Widget? prefix;
  final List<String> autofillHints;
  final bool ensureVisible;

  FormInput({
    Key? key,
    this.controller,
    required this.attribute,
    required this.formKey,
    this.label,
    this.hintText,
    this.inputType = TextInputType.visiblePassword,
    this.inputAction = TextInputAction.next,
    this.initialValue,
    this.obscureText = false,
    this.hasObscureControl = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.focusNode,
    this.nextFocusNode,
    this.onComplete,
    this.validators,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.maxLenght,
    this.showCounter = true,
    this.onChanged,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.prefixIcon,
    this.prefix,
    this.autofillHints = const [],
    this.ensureVisible = false,
  }) : super(key: key);

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  bool isPasswordVisible = false;
  bool hasValue = false;

  @override
  void initState() {
    isPasswordVisible = widget.hasObscureControl;
    hasValue = widget.formKey.currentState?.initialValue[widget.attribute] != null;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ValueListenableBuilder(
          valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
          builder: (context, mode, child) {
            return FormBuilderTextField(
              buildCounter: widget.showCounter ? null : (context, {required currentLength, required isFocused, maxLength}) => const SizedBox.shrink(),
              name: widget.attribute,
              autofillHints: widget.autofillHints,
              controller: widget.controller,
              autofocus: widget.autoFocus,
              focusNode: widget.focusNode,
              maxLines: 1,
              cursorColor: mode == AdaptiveThemeMode.dark ? Color(0xFFE2E2E2) : Color(0xFF141414),
              cursorHeight: 20,
              cursorWidth: 2,
              cursorRadius: Radius.circular(2),
              keyboardType: widget.inputType,
              textInputAction: widget.inputAction,
              initialValue: null,
              obscureText: widget.hasObscureControl ? isPasswordVisible : widget.obscureText,
              readOnly: widget.readOnly,
              autocorrect: false,
              validator: widget.validators,
              textCapitalization: widget.textCapitalization,
              inputFormatters: widget.inputFormatters,
              maxLength: widget.maxLenght,
              onChanged: (value) {
                if (hasValue != value?.isNotEmpty) {
                  setState(() => hasValue = (value?.isNotEmpty ?? false));
                }
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
              enableSuggestions: true,
              onEditingComplete: () {
                if (widget.nextFocusNode != null) {
                  widget.nextFocusNode?.requestFocus();
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
              onSubmitted: (value) {
                if (widget.onComplete != null && widget.onComplete is Function) {
                  widget.onComplete!();
                }
              },
              onTap: widget.ensureVisible
                  ? () {
                      Future.delayed(const Duration(milliseconds: 600)).then(
                        (_) {
                          Scrollable.ensureVisible(
                            FocusManager.instance.primaryFocus!.context!,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                        },
                      );
                    }
                  : null,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                labelStyle: labelStyle(mode),
                labelText: widget.label?.capitalizeFirst,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                hintText: widget.hintText?.capitalizeFirst,
                focusedBorder: outLinedFocusedBorder(mode),
                border: outLinedBorder(mode),
                enabledBorder: outLinedBorder(mode),
                focusedErrorBorder: outLinedErrorBorder,
                errorBorder: outLinedErrorBorder,
                isDense: false,
                prefixIcon: widget.prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16.0, right: 8.0),
                        child: widget.prefixIcon,
                      )
                    : null,
                prefixIconConstraints: widget.prefixIcon != null
                    ? const BoxConstraints(
                        minHeight: 32,
                        minWidth: 32,
                      )
                    : null,
                prefix: widget.prefix,
                floatingLabelBehavior: widget.floatingLabelBehavior,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (hasValue)
                      InkWell(
                        onTap: () => widget.formKey.currentState!.fields[widget.attribute]?.didChange(null),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.cancel_rounded,
                            color: mode == AdaptiveThemeMode.dark ? const Color(0xFFE2E2E2) : const Color(0xFF141414),
                            size: 19,
                          ),
                        ),
                      ),
                    // if (hasValue && widget.hasObscureControl) const SizedBox(width: 12),
                    if (widget.hasObscureControl)
                      InkWell(
                        onTap: () => setState(() => isPasswordVisible = !isPasswordVisible),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            isPasswordVisible ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                            color: mode == AdaptiveThemeMode.dark ? const Color(0xFFE2E2E2) : const Color(0xFF141414),
                            size: 19,
                          ),
                        ),
                      ),
                    const SizedBox(width: 15)
                  ],
                ),
              ),
            );
          }),
    );
  }
}
