## Flutter App Architecture

- MVP, MVVM, CLEAN
- Bloc architecture
- Control Service Repository = "Riverpod Architecture"

![Riverpod Architecture](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/images/flutter-app-architecture.webp)

`1.` Presentation Layer - '/ecommerce/lib/src/features'. Screens, custom widgets
`2`. Domain Layer - '/ecommerce/lib/src/models'. Types (entities, interfaces)
`3`. Domain Layer - '/ecommerce/lib/src

### Project Architecture

> Feature-first

================================================================================================================================

### Custom Widgets

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
