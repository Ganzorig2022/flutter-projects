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
