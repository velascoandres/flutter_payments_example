# flutter_payments_example
Un sencilla aplicacion que ejemplifica como realizar pagos con Stripe, GooglePay y ApplePay.

> Nota: Esta aplicación fue realizada en el [curso avanzado de Flutter](https://www.udemy.com/course/flutter-avanzado-fernando-herrera/) de [Fernando Herrera](https://gist.github.com/Klerith)


## Tomar encuenta para usarlo en otro proyecto
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

En el servicio `StripeService` que encuentra en el archivo: `./lib/services/stripe_service.dart`
poner los `API KEYS` respectivos de la cuenta de Stripe que se este utilizando.

```dart
class StripeService {
  // API KEYS
  String publishableKey = '<TODO: Poner el respectivo key>';
  static String _secretKey = '<TODO: Poner el respectivo key>';

}
```


## Capturas


Algunas capturas de la aplicación

<image src="https://raw.githubusercontent.com/velascoandres/flutter_payments_example/main/screenshots/sc1.png" width="250"  ></image> 


<image src="https://raw.githubusercontent.com/velascoandres/flutter_payments_example/main/screenshots/sc2.png" width="250"  ></image> 



<image src="https://raw.githubusercontent.com/velascoandres/flutter_payments_example/main/screenshots/sc3.png" width="250"  ></image> 



<image src="https://raw.githubusercontent.com/velascoandres/flutter_payments_example/main/screenshots/sc5.png" width="250"  ></image> 