# Setup

1. Install Xcode from the App Store.
2. Open the project in Xcode by opening `Throne.xcodeproj` found in the root directory.
3. Select your desired build scheme on the top left.

    Scheme | Description
    ------------ | -------------
    Throne - Develop | A debug build that uses the development API endpoint.
    Throne - Local | A debug build that uses a localhost API endpoint. Use this for testing in conjunction with a local build of the Throne backend.
    Throne - Production | A release build that uses the production API endpoint. **Use this when on the master branch.**
    Throne - Stubbed | A debug build that uses a stubbed API endpoint.

4. Select your desired device or simulator on the top left.

5. Navigate to the root of Throne then to `Signing & Capabilities` and set `TARGETS` to `Throne`.

6. Change `Team` to your desired account or create a new one if you don’t have one.

7. Change the `Bundle Identifier` to anything other than `com.findmythrone.Throne`.

    - e.g. `com.findmythrone2.Throne`.

8. If using a simulator:

    - Select `Product > Run` or `Command + R` to build and run the app.

9. If using a physical device:

    - Plug in your desired physical device.
    - Select `Product > Run` or `Command + R` to build and run the app.
    - You will probably get a `Could not launch “Throne”` error.
    - Navigate to `Settings > General > Device Management` and select your account and select `Trust` for your account.
    - Launch the app on your device from the homepage icon.
