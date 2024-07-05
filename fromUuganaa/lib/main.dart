import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cashapp/components/form_dropdown.dart';
import 'package:cashapp/components/form_input.dart';
import 'package:cashapp/components/loader.dart';
import 'package:cashapp/components/button/primary_button.dart';
import 'package:cashapp/constants/store_keys.dart';
import 'package:cashapp/layouts/auth/login.dart';
import 'package:cashapp/layouts/auth/register/create_pincode.dart';
import 'package:cashapp/layouts/auth/reset_password/success.dart';
import 'package:cashapp/layouts/walkthrough.dart';
import 'package:cashapp/model/reference.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'components/button/secondary_button.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  Future<bool> initialization() async {
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialization(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !(snapshot.data ?? false)) {
          return SizedBox.shrink();
        }
        return AdaptiveTheme(
          initial: savedThemeMode ?? AdaptiveThemeMode.light,
          light: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0),
            colorScheme: Theme.of(context).copyWith(brightness: Brightness.light).colorScheme.copyWith(
                  primary: const Color(0xFFFFFFFF),
                  secondary: const Color(0xFFF6F6F6),
                ),
          ),
          dark: ThemeData(
            primaryColor: const Color(0xFF141414),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF141414),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF141414), foregroundColor: Colors.white, elevation: 0),
            colorScheme: Theme.of(context).copyWith(brightness: Brightness.dark).colorScheme.copyWith(
                  primary: const Color(0xFF141414),
                  secondary: const Color(0xFF1F1F1F),
                ),
          ),
          builder: (theme, darkTheme) => GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: GetMaterialApp(
              showSemanticsDebugger: false,
              debugShowCheckedModeBanner: false,
              theme: theme,
              darkTheme: darkTheme,
              routes: {
                Login.route: (c) => Login(),
                CreatePinCode.route: (c) => CreatePinCode(),
                ResetSuccessPage.route: (c) => ResetSuccessPage(),
              },
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case '/':
                    return MaterialWithModalsPageRoute(
                      builder: (context) => !CommonUtils.hasData(StoreKey.FIRST_LAUNCH.name)
                          ? WalkThrough()
                          : CommonUtils.hasData(StoreKey.ACCESS_TOKEN.name)
                              ? Login()
                              : Login(),
                      settings: settings,
                    );
                }
                return null;
              },
            ),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool loading = false;
  bool formValidated = false;

  void validateForm() async {
    final form = formKey.currentState;
    if (form != null && form.saveAndValidate()) {
      setState(() => loading = true);
      await Future.delayed(const Duration(seconds: 1));
      print(form.value);
      setState(() => loading = false);
      MyRouter.toNamed(WalkThrough.route);
    }
  }

  quetlyValidateForm() {
    final bool formStatus = (formKey.currentState?.isValid ?? false);
    if (formValidated != formStatus) {
      print('changing state');
      setState(() => formValidated = formStatus);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), quetlyValidateForm);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text('Cupertino App'),
              actions: [
                ValueListenableBuilder(
                  valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
                  builder: (_, mode, child) {
                    return IconButton(
                      icon: mode == AdaptiveThemeMode.dark ? const Icon(CupertinoIcons.brightness_solid) : const Icon(CupertinoIcons.moon_fill),
                      onPressed: () {
                        if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
                          AdaptiveTheme.of(context).setLight();
                        } else {
                          AdaptiveTheme.of(context).setDark();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: FormBuilder(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    initialValue: {'who': '3', 'pin': '1234', 'mail': 'badaruugan8@gmail.com'},
                    onChanged: quetlyValidateForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Lottie.asset('assets/success.json'),
                        FormDropDown(
                          attribute: 'who',
                          formKey: formKey,
                          label: 'таны хэн болох?',
                          items: List.generate(
                            dummy.length,
                            (index) => Reference(id: '$index', name: dummy.elementAt(index)),
                          ),
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                          ]),
                        ),
                        FormInput(
                          attribute: 'mail',
                          formKey: formKey,
                          label: 'емайл',
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                            FormBuilderValidators.email(errorText: 'Зөв утга оруулна уу!'),
                          ]),
                          autofillHints: [
                            AutofillHints.email,
                          ],
                        ),
                        FormInput(
                          attribute: 'pin',
                          formKey: formKey,
                          label: 'Нууц код',
                          inputType: TextInputType.number,
                          hasObscureControl: true,
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Заавал бөглөнө үү!'),
                            FormBuilderValidators.numeric(errorText: 'Зөв утга оруулна уу!'),
                          ]),
                          autofillHints: [
                            AutofillHints.oneTimeCode,
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: PrimaryButton(
                            label: 'Нэвтрэх',
                            onPressed: formValidated ? validateForm : null,
                          ),
                        ),
                        SecondaryButton(
                          label: 'Face ID- аар нэвтрэх',
                          icon: Image.asset('assets/icons/faceid.png', height: 15, width: 15),
                          onPressed: () => null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (loading) const Loader(),
        ],
      ),
    );
  }
}

const dummy = ['аав', 'ээж', 'ах', 'дүү', 'эхнэр'];
