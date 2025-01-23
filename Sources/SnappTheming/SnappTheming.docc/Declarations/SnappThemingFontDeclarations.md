# ``SnappThemingFontDeclarations``

Manages font tokens, such as font families and sizes. Enables consistent typography across the app by centralizing font definitions.

## Overview

The framework adds support for custom fonts. Fonts can be added as annotated object entities under the root-level `fonts` property.

The annotation should contain the PostScript font name and the actual base64-encoded font data.

Below is an example of a valid font declaration (the base64-encoded string is shortened for readability):

```json
{
    "fonts": {
        "Roboto-Regular": {
            "postScriptName": "Roboto-Regular",
            "source": "data:font/ttf;base64,AAEAAAAS...=="
        }
    }
}
```

Make sure that you deregister the old theme fonts and register thew new ones when loading the theme (or when starting the app). Here's an example on how to do that:

```swift
do {
    let deregisterFontManager = SnappThemingFontManagerDefault(
        themeCacheRootURL: oldConfiguration.themeCacheRootURL, 
        themeName: oldConfiguration.themeName
    )
    deregisterFontManager.unregisterFonts(oldDeclaration.fontInformation)

    // passing the themeName to the configuration is important
    // for caching the theme assets in a separate namespace
    let configuration = SnappThemingParserConfiguration(themeName: "newTheme")
    let declaration = try SnappThemingParser.parse(from: json, using: configuration)
    let fontManager = SnappThemingFontManagerDefault(
        themeCacheRootURL: configuration.themeCacheRootURL, 
        themeName: configuration.themeName
    )
    fontManager.registerFonts(declaration.fontInformation)
} catch let error {
    os_log(.error, "Error: %@", error.localizedDescription)
}

```
