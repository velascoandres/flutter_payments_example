# flutter_payments_example


## Tomar encuenta
Tener una version minima del sdk mayor a 16 y habilitar el multiDex

`./android/app/build.graddle`

```graddle
defaultConfig {
        minSdkVersion 19
        multiDexEnabled true
    }

dependencies {
    implementation "com.android.support:multidex:2.0.1"
}
```

Dar permisos de acceder a internet en el `AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.INTERNET" />

```
