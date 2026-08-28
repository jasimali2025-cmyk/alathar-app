@echo off
chcp 65001 >nul
echo ============================================
echo إعداد وبناء تطبيق الأثر
echo ============================================

where flutter >nul 2>nul
if %errorlevel% neq 0 (
  echo Flutter غير مثبت أو غير مضاف إلى PATH.
  echo ثبّت Flutter ثم أعد تشغيل هذا الملف.
  pause
  exit /b 1
)

echo.
echo إنشاء ملفات Android...
flutter create --platforms=android .

echo.
echo جلب الحزم...
flutter pub get

echo.
echo فحص البيئة...
flutter doctor

echo.
echo بناء APK...
flutter build apk --release

echo.
echo تم بناء التطبيق.
echo الملف موجود هنا:
echo build\app\outputs\flutter-apk\app-release.apk
pause
