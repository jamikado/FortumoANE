FortumoANE
==========

Adobe Native Extension (ANE) for Fortumo (Android)

Software installation (Windows):
--------------------------------

- Download and install Java 6 (Java 7 will cause signing issues!)
- Download and install Android SDK from http://developer.android.com/sdk/index.html
- Open the SDK manager and install 'Tools' and 'Android 4.0.3 (API 15)' or later
- Download and install FlashDevelop from http://flashdevelop.org/
- Download and unzip ant from http://ant.apache.org/bindownload.cgi and add ant to your search path
- (optional) Download and install Eclipse from http://www.eclipse.org/
- (optional) Download Eclipse Android integration as specified here http://developer.android.com/sdk/eclipse-adt.html

To compile ANE:
---------------

- Edit ane\build.properties and update paths
- In the ane folder run 'ant'

To compile the Demo:
--------------------

- Open demo\demo.as3proj in FlashDevelop
- Press F5 to run the application

The demo was created by:
------------------------

- Project / New Project ... / AIR Mobile AS3 App

- Follow instructions in AIR_Android/iOS_readme.txt

- In application.xml change / add the contents of <manifestAdditions> to:

	<manifest android:installLocation="auto">
		<uses-permission android:name="android.permission.INTERNET"/>
		<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
		<uses-permission android:name="android.permission.READ_PHONE_STATE" />
		<uses-permission android:name="android.permission.RECEIVE_SMS" />
		<uses-permission android:name="android.permission.SEND_SMS" />				
		
		<application>
			<!-- Activities -->
			<activity android:name="com.fortumo.android.extension.CustomPaymentActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar"/>
			<activity android:name="com.fortumo.android.FortumoActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar"/>
			<!-- Service -->
			<service android:name="com.fortumo.android.FortumoService" />
		</application>
	</manifest>

- In application.xml add before </application>:

	<extensions>
        <extensionID>com.fortumo.extension</extensionID>
    </extensions>

- In Packager.bat change:

	call adt -package -target %TYPE%%TARGET% %OPTIONS% %SIGNING_OPTIONS% "%OUTPUT%" "%APP_XML%" %FILE_OR_DIR%

	to:
	
	call adt -package -target %TYPE%%TARGET% %OPTIONS% %SIGNING_OPTIONS% "%OUTPUT%" "%APP_XML%" %FILE_OR_DIR% -extdir ext
	
- In Run.bat replace:

	adl -screensize %SCREEN_SIZE% "%APP_XML%" "%APP_DIR%"

	with:

	rmdir /q /s ext_unpacked
	mkdir ext_unpacked\FortumoExtension.ane
	unzip -q ext\FortumoExtension.ane -d ext_unpacked\FortumoExtension.ane
	adl -screensize %SCREEN_SIZE% "%APP_XML%" "%APP_DIR%" -extdir ext_unpacked

- In SetupSDK.bat add the variable JAVA_SDK
		
- Add to Packager.bat:

	if "%PLATFORM%" NEQ "android" goto skip-fortumo-res
	call AddFortumoRes.bat
	if errorlevel 1 goto failed
	:skip-fortumo-res
	
- Make sure the path to FortumoInApp-android-7.3.461.jar is correct in AddFortumoRes.bat

- Add folder 'ext' and copy FortunoExtension.ane to it
	
	Right click FortunoExtension.ane and select 'Add To Library'
	Right click FortunoExtension.ane and select 'Options...' and select 'External Library (not included)'

- Edited demo\src\com\fortumo\demo\Main.as, main payment code is:

	var f: Fortumo = new Fortumo();
	f.setService("<service id>", "<in-app secret>");
	f.setConsumable(false);
	f.setDisplayString("This is a test purchase");
	f.setProductName("TestProduct");
	f.addEventListener(StatusEvent.STATUS, onStatusUpdate);
	f.makePayment();			

- Make sure you don't call NativeApplication.nativeApplication.exit() in your deactivation handler (activating the Fortumo screen calls this handler)

- Make sure you're running Java 6 and not Java 7 (this will cause signing errors!)
