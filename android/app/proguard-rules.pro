# Your existing rules...
-dontwarn com.google.errorprone.annotations.CanIgnoreReturnValue
-dontwarn com.google.errorprone.annotations.CheckReturnValue
-dontwarn com.google.errorprone.annotations.Immutable
-dontwarn com.google.errorprone.annotations.RestrictedApi
-dontwarn javax.annotation.Nullable
-dontwarn javax.annotation.concurrent.GuardedBy
-dontwarn org.bouncycastle.jce.provider.BouncyCastleProvider
-dontwarn org.bouncycastle.pqc.jcajce.provider.BouncyCastlePQCProvider
-dontwarn java.beans.**
-dontwarn org.slf4j.impl.**

# Additional R8 optimization settings to reduce memory usage
-dontoptimize
-dontobfuscate
-dontshrink

# Keep all Flutter classes to avoid complex analysis
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Reduce R8 processing load
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile