### enableOnBackInvokedCallback

> To edit: 'project_name/android/app/src/main/AndroidManifest.xml'

```xml
<manifest ...>
    <application . . .

        android:enableOnBackInvokedCallback="false">

        <activity
            android:name=".MainActivity"
            android:enableOnBackInvokedCallback="true"
            ...
        </activity>
        <activity
            android:name=".SecondActivity"
            android:enableOnBackInvokedCallback="false"
            ...
        </activity>
    </application>
</manifest>
```

import 'package:flutter/material.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
home: InputPage(),
);
}
}

class InputPage extends StatefulWidget {
@override
\_InputPageState createState() => \_InputPageState();
}

class \_InputPageState extends State<InputPage> {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('BMI CALCULATOR'),
),
body: Center(
child: Text('Body Text'),
),
floatingActionButton: FloatingActionButton(
child: Icon(Icons.add),
),
);
}
}
