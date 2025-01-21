# JSON Schema

The main building blocks

## Overview

This article describes the types of objects you can use to construct a valid theme declaration JSON. 

We have split the object types into two main groups - foundation objects and high-level objects

#### Foundation Objects

- [Colors](<doc:Colors>)
- [Fonts](<doc:Fonts>)
- [Gradients](<doc:Gradients>)
  - [Angular](<doc:Angular-Gradient>) 
  - [Linear](<doc:Linear-Gradient>)
  - [Radial](<doc:Radial-Gradient>)
- [Images](<doc:Images>)
- [Lottie Animations](<doc:Lottie-Animations>)
- [Metrics](<doc:Metrics>)
- [Shapes](<doc:Shapes>)
  - [Rectangle](<doc:Rectangle>)
  - [Ellipse](<doc:Ellipse>)
  - [Circle](<doc:Circle>)
  - [Capsule](<doc:Capsule>)
  - [Rounded rectangle](<doc:Rounded-Rectangle>)
  - [Uneven rouded rectangle](<doc:Uneven-Rounded-Rectangle>)

#### High-level objects

- [Aliases](<doc:Aliases>)
- [Button Styles](doc:Button-Styles)
- [Typography](<doc:Typography>)

### Colors

Colors can be listed as a child properties of the root-level `colors` property as follows

```json
{
    "colors": {
        "appPrimary": "#FF0000"
    }
}
```

The framework supports HEX-ecoded RGB, RGBA and ARGB notations. All of the following are valid entries:

```json
{
    "colors": {
        "appPrimary": "#FF0000",
        "appSecondary": "#FF00000A",
        "appTertiary": "#0AFF0000",
        "appQuaternary": "#0F0"
    }
}
```

Some themes may need to support the system dark mode. In that case you can use the following annotation (again - HEX, RGBA and ARGB annotations are all supported here):

```json
{
    "colors": {
        "appPrimary": {
            "light": "#FF0000", 
            "dark": "#CC0000"
        }
    }
}
```

Mixing the color declaration style is also supported.  The following is a valid construct:

```json
{
    "colors": {
        "appPrimary": {
            "light": "#FF0000", 
            "dark": "#CC0000"
        },
        "appSecondary": "#FF00000A",
    }
}
```

> In the example above the `appSecondary` color will be initialized with a value of `#FF00000A` which will be used in both the system light and dark modes

### Providing hints on the color format to the parser

For the most part decoding the colors correctly should work out out of the box. The parser can deal with different HEX-driven color styles. Both `#FFF` and `#FFFFFF` annotations will be recognized and supported out of the box. The parser defaults to recognizing RGBA color annotations as well (e.g: `#FFFFFF0A`). In case you need to support ARGB, make sure to provide the correct value to the ``SnappThemingParserConfiguration/colorFormat`` property of ``SnappThemingParserConfiguration`` (see ``SnappThemingColorFormat`` for the list of supported values)

### Fonts

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

### Gradients

Gradients can be declared as described below. Supported are three gradient types - [angular](<doc:Angular-Gradient>), [linear](<doc:Linear-Gradient>), and [radial](<doc:Radial-Gradient>)

#### Angular Gradient

The values of the start and end angle should be provided in degrees, as shown below

````json
{
    "gradients": {
        "angularGradient": {
            "colors": [
                "#843912",
                "#242D2D"
            ],
            "center": [
                2.0,
                -0.2
            ],
            "startAngle": 0,
            "endAngle": 180
        }
    }
}
````

#### Linear Gradient

```json
{
    "gradients": {
        "horizontalLinearGradient": {
            "colors": [
                "$colors/appPrimary",
                "$colors/appSecondary"
            ],
            "startPoint": "leading",
            "endPoint": "trailing"
        },
        "verticallLinearGradient": {
            "colors": [
                "$colors/appPrimary",
                "$colors/appSecondary"
            ],
            "startPoint": "top",
            "endPoint": "bottom"
        },
        "diagonalLinearGradient": {
            "colors": [
                "$colors/appPrimary",
                "$colors/appSecondary"
            ],
            "startPoint": "topLeading",
            "endPoint": "bottomTrailing"
        }
    }
}
```

#### Radial Gradient

```json
{
    "gradients": {
        "radialGradient": {
            "colors": [
                "#843912",
                "#242D2D"
            ],
            "center": [
                2.0,
                -0.2
            ],
            "startRadius": 0,
            "endRadius": 1075
        }
    }
}
```


### Images

Images can be added as base64-encoded entities under the root-level `images` property. 

Below is an example of a valid image declaration (the base64-encoded string is shortened for readability):

```json
{
    "images": {
        "basket": "data:image/png;base64,iVBORw0KG...=="
    }
}
```

> The library provides support for JPEG, PNG and PDF assets out of the box. Additional support for SVG assets (using [`SGVKit`](https://github.com/SVGKit/SVGKit)) is available through the [`SnappThemingSVGSupport`](http://ios-theming.snappmobile.io/documentation/snappthemingsvgsupport/) package.

### Lottie Animations

Animations can be added as base64-encoded entities under the root-level `animations` property.

Below is an example of Lottie animation declaration (the base64-encoded string is shortened for readability):

```json
{
    "animations": {
        "lego": {
            "type": "lottie",
            "value": "eyJ2IjoiNC44LjAiLCJtZXRhIjp7ImciOiJMb3R0aWVGaWxlcyBBRSAiLCJhIjoiIiwiayI6IiIsImQiOiIiLCJ0YyI6IiJ9LC..."
        }
    }
}
```

### Metrics

Metrics are defined using decimal or floating point values added as child properties of the root-level `metrics` property. 

Below is an example of the supported annotations

```json
{
    "metrics": {
        "spacingNormal": 8,
        "spacingLarge": 12.0,
        "fontBody": 14.0
    }
}
```

### Shapes

Shape declarations can be used to provide the foundation for background layers or button styles. Because of that, we consider them foundation objects.

Supported are a number of objects, as follows:

- [Rectangle](<doc:Rectangle>)
- [Ellipse](<doc:Ellipse>)
- [Circle](<doc:Circle>)
- [Capsule](<doc:Capsule>)
- [Rounded rectangle](<doc:Rounded-Rectangle>)
- [Uneven rouded rectangle](<doc:Uneven-Rounded-Rectangle>)

#### Rectangle

```json
{
    "shapes": {
        "rect": {
            "type": "rectangle"
        }
    }
}
```

#### Ellipse

```json
{
    "shapes": {
        "ellipse": {
            "type": "ellipse"
        }
    }
}
```

#### Circle

```json
{
    "shapes": {
        "circle": {
            "type": "circle"
        }
    }
}
```

#### Capsule

```json
{
    "shapes": {
        "capsule": {
            "type": "capsule",
            "value": {
                "style": "circular"
            }
        }
    }
}
```

#### Rounded Rectangle

Rounded rectangles with uniform corner radius can be defined as follows

```json
{
    "shapes": {
        "roundedRectangle": {
            "type": "roundedRectangle",
            "value": {
                "cornerRadius": 12
            }
        }
    }
}
```

Rounded rectangles with variable corner radius can be defined as follows

```json
{
    "shapes": {
        "roundedRectangleAlt": {
            "type": "roundedRectangle",
            "value": {
                "cornerSize": {
                    "width": 15,
                    "height": 30
                },
                "style": "circular"
            }
        }
}
```

#### Uneven Rounded Rectangle

This allows you to define a rounded rectangle where corner radius varies for each corner, as below

```json
{
    "shapes": {
        "funkyRect": {
            "type": "unevenRoundedRectangle",
            "value": {
                "cornerRadii": {
                    "topLeading": 0,
                    "bottomLeading": 20,
                    "bottomTrailing": 0,
                    "topTrailing": 20
                },
                "style": "circular"
            }
        }
    }
}
```

### Aliases

Aliases can be used to link a value to another value. Providing an alias instead of a value means that the value of the objevt that you are aliasing will be used instead. Think of these as declaration hyperlinks. They are useful when building high-level configurations (typography, button styles, shapes).

Aliases should start with the dollar sign (`$`) and should include the full path to the declaration they are referring to.

Below is an example of a valid use of aliases as `surfaceWidgetPrimary` is declared so that it's an alias of `surfaceTertiary`. 

```json
{
    "colors": {
        "surfacePrimary": "#FF0000",
        "surfaceSecondary": "#FF00000A",
        "surfaceTertiary": "#0AFF0000",
        "surfaceWidgetPrimary": "$colors/surfaceTertiary",
    }
}
```

### Button Styles

Below is an example of two button styles. Button styles may contains aliases to [shapes](<doc:Shapes>), [colors](<doc:Colors>) and [typography](<doc:Typography>) declarations.

For more information, see ``SnappThemingButtonStyleRepresentation``

```json
{
    "buttonStyles": {
        "primary": {
            "surfaceColor": {
                "normal": "#1A1A1A",
                "pressed": "#3D3D3D",
                "disabled": "#FFFFFF0F"
            },
            "borderColor": {
                "normal": "#FFFFFF0F",
                "pressed": "#FFFFFF1F",
                "disabled": "#FFFFFF00"
            },
            "textColor": {
                "normal": "#FFFFFF",
                "pressed": "#FFFFFF",
                "disabled": "#888888"
            },
            "borderWidth": 1,
            "typography": "$typography/textSmall",
            "shape": "$shapes/roundedRectangle"
        },
        "primarySelected": {
            "surfaceColor": {
                "normal": "$colors/primary",
                "pressed": "#3D3D3D",
                "disabled": "#FFFFFF0F"
            },
            "borderColor": {
                "normal": "#FFFFFF0F",
                "pressed": "#FFFFFF1F",
                "disabled": "#FFFFFF00"
            },
            "textColor": {
                "normal": "#FFFFFF",
                "pressed": "#FFFFFF",
                "disabled": "#888888"
            },
            "borderWidth": 1,
            "typography": "$typography/textSmall",
            "shape": "$shapes/roundedRectangle"
        }
    }
}
```

### Typography

Typography declarations are considered high-level as they should point to primitives like metrics and fonts.

Below is an example of a valid font declaration:

```json
{
    "typography": {
        "body": {
            "font": "$fonts/Roboto-Regular",
            "fontSize": "$metrics/fontBody"
        }
    }
}
```

Also supported are local values for the font size:

```json
{
    "typography": {
        "body": {
            "font": "$fonts/Roboto-Regular",
            "fontSize": 16.0
        }
    }
}
```
