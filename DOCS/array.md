### Array methods

```dart
// Filter method
 state = state.where((m) => m.id != meal.id).toList(); //returns element

// Check method
final isExisting = _favoriteMeals.contains(meal); // returns true or false.

// Add method
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

// Remove method
setState(() {
    _favoriteMeals.remove(meal);
    });

// Create a List method
final filteredMeals = dummyMeals
      .where((meal) => meal.categories.contains(category.id))
      .toList();

```
