# ``SnappThemingColorDeclarations``

Responsible for managing and resolving color tokens. This includes static colors and dynamic system colors, supporting light/dark mode.

## Overview

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
