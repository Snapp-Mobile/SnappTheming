# ``SnappThemingShapeDeclarations``

Handles numeric tokens, such as spacing, corner radius, border widths. Useful for creating a consistent design language with reusable measurements.

## Overview

Shape declarations can be used to provide the foundation for background layers or button styles. Because of that, we consider them foundation objects.

Supported are a number of objects, as follows:

- [Rectangle](<doc:Rectangle>)
- [Ellipse](<doc:Ellipse>)
- [Circle](<doc:Circle>)
- [Capsule](<doc:Capsule>)
- [Rounded rectangle](<doc:Rounded-Rectangle>)
- [Uneven rouded rectangle](<doc:Uneven-Rounded-Rectangle>)

### Rectangle

```json
{
    "shapes": {
        "rect": {
            "type": "rectangle"
        }
    }
}
```

### Ellipse

```json
{
    "shapes": {
        "ellipse": {
            "type": "ellipse"
        }
    }
}
```

### Circle

```json
{
    "shapes": {
        "circle": {
            "type": "circle"
        }
    }
}
```

### Capsule

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

### Rounded Rectangle

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

### Uneven Rounded Rectangle

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
