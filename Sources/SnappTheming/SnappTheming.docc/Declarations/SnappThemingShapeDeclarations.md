# ``SnappThemingShapeDeclarations``

Manages shape declaration tokens, including spacing, corner radius, and border widths. This functionality facilitates the creation of a consistent design language with reusable measurements.

## Overview

Shape declarations serve as the foundation for background layers or button styles, making them considered fundamental objects.

Supported objects include:

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
            "style": "circular"
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
            "cornerRadius": 12
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
            "cornerSize": {
                "width": 15,
                "height": 30
            },
            "style": "circular"
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
```
