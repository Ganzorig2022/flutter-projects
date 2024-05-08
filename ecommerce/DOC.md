## Flutter App Architecture

- MVP, MVVM, CLEAN
- Bloc architecture
- Control Service Repository = "Riverpod Architecture"

![Riverpod Architecture](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/images/flutter-app-architecture.webp)

`1.` Presentation Layer - '/ecommerce/lib/src/features'. Screens, custom widgets

- Widgets ⬇️
- States ⬇️
- Controllers ⬇️ . see example details: [Controllers](/ecommerce//lib/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart)

`2.` Application Layer - 'Services

`3`. Domain Layer - '/ecommerce/lib/src/models'. Models

`4`. Data Layer - '/ecommerce/lib/src/features/products/data/fake_products_repository.dart. Repositories, DTOs, Data sources

### Project Architecture

> Feature-first

================================================================================================================================

## Navigation - Go Router

`1.` Route-vvdee 1 file-d bvgdiig ni tohiruulj ogno.

> See details: [App router](/ecommerce//lib/src/routing/app_router.dart)

```dart
  // app.dart file dotor
  routerConfig: goRouter,

  // OPTION #1. huudas ruu vsrehdee...
  onPressed: () => context.go('/orders'),

  // OPTION #2.1. NAMED ROUTING. routing by name. More typesafe approach is this. "go" will modify the underlying navigation stack if the new route is not a sub-route of the old one.
  onPressed: () => context.goNamed(AppRoute.orders.name),

  // OPTION #2.2. NAMED ROUTING. "push" method wwill always preserve the current stack and add a new route on top.
  onPressed: () => context.pushNamed(AppRoute.orders.name),
```

`2.` Router parameters = pathParameters

```dart
// #1. Parameters-ee zaaj ogno.
 GoRoute(
    path: 'product/:id',
    name: AppRoute.product.name,
    builder: (context, state) {
      final productId = state.pathParameters['id']!;
      return ProductScreen(productId: productId);
    },
  ),
// #2. Params-aa damjuulna.
onPressed: () => context.goNamed(AppRoute.product.name,
      pathParameters: {'id': product.id}),
```

#### How to quickly get familiar with a new codebase?

`1.` Go through all the files
`2.` or using Widget Instpector DevTools

### Folder or File structure

```bash

```

===============================================================================

### Global State Management - Riverpod as Dependency Injection System

`1.` ConsumerWidget => StatelessWidget
`2.` ConsumerStatefulWidget => StatefulWidget

```bash
# FLutter_riverpod snippets
#1. Create a new provider
provider  + tab
```

How to create providers?

- Declare as a global variable
- Specify a type annotation
- Implement the body

How to convert Stateless/StatefulWidget?

 - Stateless --> ConsumerWidget
 - StatefulWidget --> ConsumerStatefulWidget
            State --> ConsumerState


> See details: [ConsumerWidget](/ecommerce/lib/src/features/products/presentation/products_list/products_grid.dart)

`1.` Tuhain provider dotorh function-iig ajilluulahdaa (trigger) hiihdee **ref.read()**-eer ajilluulna.'

`2.` Tuhain provider-aas oorchlogdson utga awah bol **ref.watch()**-aar utga variable-d hadgalj awch bolno.

`3.` **.autoDispose** modifier-aar tuhan provider ashiglagdahgv bolson ved "tsewerleh" uuregtei yum.

`4` **.family** modifier-aar tuhain provider luu parameter damjuulahad hereglene.

> See details: [autoDispose, family modifier](/ecommerce/lib/src/features/products/data/fake_products_repository.dart)

`5.` **ref.listen()** - is good for running shome code in response to state changes

> See details: [ref.listen()](/ecommerce/lib/src/features/authentication/presentation/account/account_screen.dart)

`6.` **AsyncValue.guard** - asyncValue-iig safely handle hiihed, try catch-iin orond hereglej bolno.

> See details: [AsyncValue.guard](/ecommerce/lib/src/features/authentication/presentation/account/account_screen_controller.dart)

> AsyncValueWidget-eer async data tatah ved loading, error state-vvdiig handle hiiw: [AsyncValueWidget](/ecommerce/lib/src/common_widgets/async_value_widget.dart)

> ConsumerWidget -> everything in the build method will rebuild if the provider value changes
> Consumer -> only code inside the builder will rebuild (more fine grained control)
> If your widgets are small, use ConsumerWidget by default. Only use Consumer when needed.
> FutureProvider, StreamProvider, AsyncValue, .autoDispose, .family

===============================================================================

### How to generate immutable state classes in Dart

===============================================================================

### Reactive In-Memory Store with RxDart

===============================================================================

### Widgets vs Helper Methods

> Use separate widgets instead of helper methods

- Calling setState within a widget reruns its entire build method
- Rendering an icon in a helper method requires rebuilding the entire wrapping widget

### Responsive Custom Widgets

- ResponsiveCenter
- ResponsiveSliverCenter
- ResponsiveTwoCloumnLayout
- ResponsiveScrollableCard

### Localization

> https://codewithandrea.com/articles/flutter-localization-build-context-extension/

#### Future, Streams, Async, Async*, Yield, yield*

> https://medium.com/@siddharthmakadiya/unlocking-the-power-of-yield-yield-async-and-async-in-flutter-588a82f9c445

> https://pro.codewithandrea.com/flutter-foundations/03-app-architecture/04-project-structure
