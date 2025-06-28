plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.practice"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"  // Updated NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17  // Updated from 11
        targetCompatibility = JavaVersion.VERSION_17  // Updated from 11
    }

    kotlinOptions {
        jvmTarget = "17"  // Updated from 11
    }

    defaultConfig {
        applicationId = "com.example.practice"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}