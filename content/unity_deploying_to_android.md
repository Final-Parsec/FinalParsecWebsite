title: Deploying Unity Games to Android
Date: 2014-09-21
Category: Tower Defense
Tags: tower-defense, unity, tutorial, android
Slug: unity-deploying-to-android
Author: Baer
Summary: Learn how to deploy an existing Unity game to your android device.

<p>
    In this tutorial, learn how to deploy your Unity game to an Android device.    
</p>


<h3>Install the Java Development Kit</h3>

<p>
    <a href="http://www.oracle.com/technetwork/java/javase/downloads/" target="_blank">Download the JDK from Oracle</a>
    <br>
    Install the JDK. Grab the <span style="font-weight: bold;">32-bit version</span>; I wasn't able to get Unity to work with the 64-bit alternative.        
</p>

<p>    
    Include java's <code>bin</code> directory in your PATH variable. 
    On my 64-bit Win8 install, the path was <code>"C:\Program Files (x86)\Java\jdk1.8.0_20\bin"</code>.
    Yours will likely be something similar.     
</p>

<p>
    <span class="caption">You should now be able to run "java" at the command line.</span>
    <img src="/theme/images/unity_deploying_with_android_java_command_prompt.png">
</p>

<h3>Install the Android SDK</h3>

<p>
    <a href="http://developer.android.com/sdk" target="_blank">Download the Android SDK</a>
    <br>
    Unpack the SDK. 
    Some of the names in this bundle can be quite long. 
    So if you're on Windows, be careful about limitations on total path lengths.
    I got around this by unpacking to <code>"C:\A\"</code>, a shorter than usual path.
</p>

<p>
    Navigate to that directory, run the <span style="font-weight: bold;">SDK Manager</span> and make sure you've got the following installed:
    
    <ul>
        <li>An Android platform (2.3 or newer)</li>
        <li>Platform tools</li>
        <li>USB drivers</li>
    </ul>
</p>


<p>
    <img src="/theme/images/unity_deploying_with_android_android_sdk_manager.png">
    <span class="caption">Here's what I've got installed.</span>
</p>

<h3>Setup the Device</h3>

<p>
    To allow unsigned Android application packages (APKs) on your device, you'll need to modify some settings. 
    Go to <code>Settings -> Developer options</code>.
    On Android 4.2 (Jelly Bean) and higher, these options have been hidden and adding them to the menu requires extra steps:
     
     <ol>
        <li>Go to <code>Settings -> About Phone</code>.</li>
        <li>Find <code>Build Number</code> and tap it 7 times.</li>
        <li>You should see a message confirming you as a developer.</li>
     </ol>
</p>

<p>
     Once you get into the developer options, enable <code>USB Debugging</code> and <code>Allow Mock Locations</code>.
     <img src="/theme/images/unity_deploying_with_android_developer_options.png">
</p>

<p>
    Plug in your device over USB, and you should see a message like "USB debugging connected".
</p>

<p style="font-size: smaller;">
    <span style="font:smaller;"><span style="font-weight: bold;">Heads up:</span>
    some devices will need additional manufacturer specific drivers. 
    As an example, I needed <a href="http://developer.android.com/sdk/win-usb.html" target="_blank">these</a> for my Nexus 5. 
</p>

<h3>Build and Run from Unity</h3>

<p>
    Start Unity. Go to <code>Edit -> Preferences -> External Tools</code>.
    Point the <code>Android SDK Location</code> to the appropriate location (<code>"C:\A\adt-bundle-windows-x86_64-20140702\sdk"</code> in my case). 
</p>

<p>
    Go to <code>File -> Build Settings</code>.
    Select <code>Android</code> and click the <code>Player Settings</code> button.
    Set everything up the way you'd like. The <span style="font-weight: bold;">Bundle Identifer</span> setting is required and should follow <a href="http://en.wikipedia.org/wiki/Java_package#Package_naming_conventions" target="_blank">conventions</a> (<code>com.finalparsec.towerdefense</code> for example).
</p>

<p>
    Select <code>Build And Run</code>, select a location for your .apk, and the game should start up on your device.
</p>

<p>
    Continue the discussion with us: <a href="https://twitter.com/Final_Parsec" target="_blank">@Final_Parsec</a>
</p>