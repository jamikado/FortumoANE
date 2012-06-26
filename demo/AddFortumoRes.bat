@echo off

echo Unzipping fortumo_res...
unzip ..\ane\android\native\lib\FortumoInApp-android-7.3.461.jar fortumo_res\*
if errorlevel 1 goto error

echo Making copy of apk...
move %OUTPUT% dist\tmp.zip
if errorlevel 1 goto error

echo Removing META-INF folder...
zip -d dist\tmp.zip META-INF\*
if errorlevel 1 goto error

echo Adding fortumo_res folder...
zip -r dist\tmp.zip fortumo_res
if errorlevel 1 goto error

echo Signing...
"%JAVA_SDK%\bin\jarsigner" -storetype pkcs12 -storepass fd -keystore cert\demo.p12 -sigfile CERT dist\tmp.zip 1
if errorlevel 1 goto error

echo Aligning zip file...
"%ANDROID_SDK%\tools\zipalign" -v 4 dist\tmp.zip %OUTPUT%
if errorlevel 1 goto error

echo Removing temporary zip...
del dist\tmp.zip
if errorlevel 1 goto error

echo Removing fortumo_res...
rmdir /s /q fortumo_res
if errorlevel 1 goto error

goto end

:error
pause
exit 1

:end