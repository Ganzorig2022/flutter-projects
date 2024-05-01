### Start development

`1.` Connect phone via usb into computer
`2.` Ctrl+Shift+P for opening "Flutter: Select device"
`3`. Run and Debug (Ctr+Shift+D)

### Folder or File structure

```bash
── lib
│ ├── data (constants data)
│ │ └── dummy_data.dart
│ ├── main.dart
│ ├── models (blueprints or constructor object for creating data)
│ │ ├── category.dart
│ │ └── meal.dart
│ ├── screens (screens or routes)
│ │ ├── categories.dart
│ │ └── meals.dart
│ └── widgets (custom widgets)
│ └── category_grid_item.dart
```

### Importing package/component

```dart
import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart'; // custom widget
```

### Installing Google Font

```sh
flutter pub add google_fonts
```

### ASSETS folder

`1.` pubspec.yaml file dotor image-uudee import zaaj ogno.

```yaml
assets:
  - assets/images/dice-1.png
  - assets/images/dice-2.png
  - assets/images/dice-3.png
  - assets/images/dice-4.png
  - assets/images/dice-5.png
  - assets/images/dice-6.png
```

### Creating custom Stateless Widget (custom component)

```dart
import 'package:flutter/material.dart'; // must import

class StyledText extends StatelessWidget {
  const StyledText({super.key}); // must add

  @override
  Widget build(context) {
    return const Text(
      'Hello Ganzo',
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}

```

### Creating Stateful Widget (custom component)

> [Link](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html?gclid=Cj0KCQiAhc-sBhCEARIsAOVwHuRcjhtSUFqDleKMnTRk1lrXOSUrqxuCIPC0PxzgTztW2R5lFsXGORoaAqBkEALw_wcB&gclsrc=aw.ds)

```dart
import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  List<String> selectedAnswers = []; // declaring string typed array[]

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'start-screen';
        selectedAnswers = [];
      });
    }
  }

  @override
  Widget build(context) {
    Widget screenWidget =
        StartScreen(switchScreen); // sending function as props

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
          onSelectAnswer:
              chooseAnswer); // sending function as props, but receives data from it (LIFTING UP)...
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Color.fromARGB(255, 65, 12, 126)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: screenWidget),
      ),
    );
  }
}

```

### Variables

> Parent component

```dart
import 'package:first_app/styled_text.dart';
import 'package:flutter/material.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 26, 2, 80),
          Color.fromARGB(255, 45, 7, 98),
        ], begin: startAlignment, end: endAlignment),
      ),
      child: const Center(
        child: StyledText('Hello Ganzorig'), // sending text props
      ),
    );
  }
}

```

> Child component

```dart
import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.outputText, {super.key}); // 1. dynamic text props

  final String outputText; // 2. assigning to variable

  @override
  Widget build(context) {
    return Text(
      outputText, // 3. then use it
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}
```

### Passing Function as Props, Lifting State Up

`1.` **_Parent element_**. 'quiz.dart' file-aas 'questions-screen.dart' file ruu

```dart
// Parent element.
 if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
          onSelectAnswer:
              chooseAnswer); // sending function as props, but receives data from it (LIFTING UP)...
    }
```

`2.` **_Child element_**.

```dart

// Child element.
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(
      {super.key, required this.onSelectAnswer}); // receiving props from parent

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}
```

### Maps in dart (=Objects in JavaScript)

`1.` It is like Object in javascript.

```dart
import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key,
      required this.chosenAnswers}); // 1. receiving array[] props from parent

  final List<String> chosenAnswers; // 2. defining props type

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    return SizedBox(
        width: double.infinity, // use enough width as much as possible
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!'),
              const SizedBox(
                height: 30,
              ),
              QuestionsSummary(summaryData),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Restart Quiz'),
              )
            ],
          ),
        ));
  }

```

================================================================ FLUTTER ================================================================

### TextField (Input element)

```dart
  final _titleController = TextEditingController();

// creating Widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController, // method2. onChangeHandler
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
```

### Showing Modal

```dart
void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true, // make a modal fullscreen
        context: context,
        builder: (ctx) {
          return NewExpense(
              onAddExpense: _addExpense); // sending function as props
        });
  }
```

### Showing Notification Bar at the Bottom

```dart
 // Show notification bar on the bottom of the screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex,
                    expense); // add item again to the list by using the index
              });
            }),
      ),
    );
```

### Showing Dialog (small notification window)

````dart
 showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            title: const Text('Invalid input'),
            content: const Text(
                'Please make sure a valid title, date, amount and category was entered.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx); //Return to the first route
                },
                child: const Text('Okay'),
              )
            ]),
      );
      ```
````

### Theming (Theme)

> Creating default theme for each element such as AppBar

```dart
import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer),
        cardTheme: CardTheme(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 16),
        ),
      ),
      home: const Expenses(),
    ),
  );
}

```

### Installing 3rd Package

```sh
# Installing uuid generator
flutter pub add uuid

# Installing date time formatter. https://pub.dev/packages/intl
flutter pub add intl
```

### Using theme into the Widgets

```dart
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
```

### Rendering children of List using Looping through list

`1`. Method 1. Using for in loop

```dart
child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
```

`2.` Method 2. Using map() method.

```dart
 const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
```

`3`. Method 3. Using ListView.builder() constructor.

```dart
@override
  Widget build(BuildContext context) {
    // List elements
    return ListView.builder(
      itemCount: expenses.length,
      //Dismissible make the list item 'Swipable'!!!
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.3),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        // remove the item
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
```

### Use Safe Area

> Add some space from top for preventing camera, phone notification area.

```dart
 void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true, // use safe area
        isScrollControlled: true, // make a modal fullscreen
        context: context,
        builder: (ctx) {
          return NewExpense(
              onAddExpense: _addExpense); // sending function as props
        });
  }
```

### LayoutBuilder widget

> LayoutBuilder to build a different widget depending on the available width

```dart
  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    // LayoutBuilder builds a widget tree that can depend on the parent widget's size.
    return LayoutBuilder(builder: (ctx, constraints) {
      final maxWidth = constraints.maxWidth;

      return Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
        child: Column(
          children: [
            if (maxWidth >= 600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _titleController, // method2. onChangeHandler
                      maxLength: 50,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _amountController, // onChangeHandler
                      maxLength: 20,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ', // $25
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                ],
              )
            else
              TextField(
```

### Adaptive Widgets for different Platforms (IOS or Android)

```dart
import 'dart:io';

if(Platform.isIOS) {
  // for iOS
} else {
  // for Android
}
```

### Make items tappable or touchable. InkWell

```dart
 @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.55),
            category.color.withOpacity(0.9)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
```

### Navigation or Route

```dart
Navigator.pop(ctx); //Return to the first route
Navigator.of(context).pop(); // closes the navigation such as drawer...
// go to the another page
void _selectCategory(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(title: 'Some title', meals: [])));
}

```

### Tabs based navigation (such as bottom tabs)

> See details: [Tab screen](meals_app/lib/screens/tabs.dart)

`1`. /meals_app/lib/main.dart
`2`. /meals_app/lib/screens/tabs.dart

### Adding Side Drawer

> See details: [Drawer](meals_app/lib/widgets/main_drawer.dart)

### PopScope - Returning Data when leaving a screen

> See details: [PopScope](meals_app/lib/screens/filters.dart)

```dart
<!-- Parent element -->

 void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // always closes the drawer
    if (identifier == 'filters') {
      // receives Map (object) data with type of boolean from FilterScreen
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
      print(result);
    }
  }


<!-- Child element -->
 body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          // sending data to previous screen which is TabScreen
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.veganFree: _veganFreeFilterSet,
            Filter.vegetarianFree: _vegetarianFreeFilterSet,
          });
        },)
```

### Global State Management - Riverpod

##### Engiin data haruulah bol **Provider** class ashiglana.

> Links: [Riverpod Install](https://riverpod.dev/docs/introduction/getting_started)

> See details: [Provider](meals_app/lib/providers/meals_provider.dart)

`1`. Provider file-aa vvsgene.
`2`. Main.dart file-d Provider-aa App-iin gaduur bvrhene.
`3.` **StatefulWidget**-iig **ConsumerStatefulWidget**-eer replace hiiw. meals_app/lib/screens/tabs.dart

```dart
 class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

```

##### Complex data haruulah bol. **StateNotfier** class ashiglana.

> See details: [ConsumerWidget](meals_app/lib/screens/filters.dart)

- Provider + Local State + Widget = ConsumerStatefulWidget
- Provider + Widget = ConsumerWidget

> See details: [ConsumerStatefulWidget](meals_app/lib/screens/tabs.dart)

`1.` Tuhain provider dotorh function-iig ajilluulahdaa **trigger** hiihdee '.read()-eer ajilluulna.'

```dart
 final wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);
```

`2.` Tuhain provider-aas oorchlogdson utga awah bol '.watch()'-aar utga variable-d hadgalj awch bolno.

```dart
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
```

08 - Building Multi-Screen Apps & Navigating Between Screens [MEALS APP] - 025 Applying filters 04:49

09 - Managing App-wide State [MEALS APP] - 011 Combining Local & Provider-managed State
