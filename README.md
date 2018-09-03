# Discoucher

DisCoucher Andoid application

## Framework

Flutter

[Flutter documentation](https://flutter.io/).

## Colors

Primary color <span style="color:#1B5E20"> Green[900:Material Pallete] 1B5E20 blue </span>

Accent Color <span style="color:#d32f2f"> Red [700: Material Palette] d32f2f </span>

I like this onne too <span style="color:#C2185B"> Pink[700: Material Palette] C2185B </span>

Using Hex code colors in flutter:
e.g final xlighterTextColor = Color(0xFF27AE60);

## App Keys

### Debug Keys:


Certificate fingerprint(dennis.riungu):

```sh
Base64:
v7sJ0hNq5AqNhHCPIaXcFXuHL5Q=

SHA1:
BF:BB:09:D2:13:6A:E4:0A:8D:84:70:8F:21:A5:DC:15:7B:87:2F:94

SHA256:
9E:AB:82:75:5C:0D:3A:BF:5D:00:79:53:31:A1:81:84:96:B9:D1:D5:E2:D2:5C:B9:A4:AF:F1:7F:76:ED:88:59
```

Certificate fingerprints(admin):
```sh
Base64:
1JcFq1txQ4EFM6TIW9a6rCnKIWI=

SHA1:
D4:97:05:AB:5B:71:43:81:05:33:A4:C8:5B:D6:BA:AC:29:CA:21:62

SHA256: 
C4:1C:9D:98:69:9C:21:5B:0F:B2:5B:82:EB:79:AD:3C:53:DF:2C:B0:AD:23:B0:3B:C1:B3:CC:28:39:81:15:09
```

Signature algorithm name: SHA1withRSA
Subject Public Key Algorithm: 1024-bit RSA key
Version: 1


## Firebase Debugging Analytics

To enable Analytics Debug mode on an emulated Android device, execute the following command line:

```sh
adb shell setprop debug.firebase.analytics.app com.discoucher
```

This behavior persists until you explicitly disable Debug mode by executing the following command line:

```sh
adb shell setprop debug.firebase.analytics.app .none.
```
