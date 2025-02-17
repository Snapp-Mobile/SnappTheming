# ``SnappThemingFontDeclarations``

Manages font tokens, including font families and sizes. Enables consistent typography across the application by centralizing font definitions.

## Overview

The framework provides support for custom fonts. Fonts can be added as annotated object entities under the root-level `fonts` property.

The annotation should contain the PostScript font name and, optionally, the actual base64-encoded font data. If you want to use a font that is either bundled with the app or provided by the system, you can omit the font data and simply use the PostScript name.

The following is an example of a valid font declaration (the base64-encoded string has been shortened for brevity):

```json
{
    "fonts": {
        "Helvetica": {
            "postScriptName": "Helvetica"
        },
        "Roboto-Regular": {
            "postScriptName": "Roboto-Regular",
            "source": "data:font/ttf;base64,AAEAAAAS...=="
        }
    }
}
```

Ensure that you deregister the old theme fonts and register the new ones when switching the themes (or when starting the application). Here is an example of how to do that:

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
