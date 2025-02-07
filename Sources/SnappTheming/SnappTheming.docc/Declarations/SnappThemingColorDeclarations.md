# ``SnappThemingColorDeclarations``

Responsible for managing and resolving color tokens, including static colors and dynamic system colors, with support for light/dark mode.

## Overview

Colors can be declared as child properties of the root-level `colors` property, as follows:

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

Certain themes may require support for the system dark mode. In such cases, you can utilize the following annotation (again, HEX, RGBA, and ARGB colors are all supported here):

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

The mixing of color declaration styles is also supported. The following is a valid construct:

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

In general, decoding colors correctly should be automatic. The parser can handle various HEX-driven color declarations. Both `#FFF` and `#FFFFFF` annotations will be recognized and supported by default. The parser also defaults to recognizing RGBA color annotations (e.g., `#FFFFFF0A`). If you need to support ARGB, please provide the correct value to the ``SnappThemingParserConfiguration/colorFormat`` property of ``SnappThemingParserConfiguration`` (see ``SnappThemingColorFormat`` for the list of supported values).
