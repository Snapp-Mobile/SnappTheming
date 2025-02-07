# ``SnappThemingButtonStyleDeclarations``

Manages button styles, including properties such as surface and text colors, border widths and colors, shapes, and typography for various button states.

## Overview

Below is an example of two button styles. Button styles may contains aliases to [shapes](<doc:SnappThemingShapeDeclarations>), [colors](<doc:SnappThemingColorDeclarations>) and [typography](<doc:SnappThemingTypographyDeclarations>) declarations.

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

