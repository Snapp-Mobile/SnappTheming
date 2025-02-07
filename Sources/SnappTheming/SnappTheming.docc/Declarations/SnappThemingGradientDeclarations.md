# ``SnappThemingGradientDeclarations``

Manages gradient tokens, supporting linear, radial, and angular gradients. This enables the creation of dynamic and visually appealing shape backgrounds.

## Overview

Gradients can be declared as follows. Three gradient types are supported: [angular](<doc:Angular-Gradient>), [linear](<doc:Linear-Gradient>), and [radial](<doc:Radial-Gradient>).

### Angular Gradient

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

### Linear Gradient

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

### Radial Gradient

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
