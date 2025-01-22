# ``SnappThemingSegmentControlStyleDeclarations``

Manages segment control style tokens, enabling the customization of segment control appearance, including selected/unselected states, borders, shapes, and paddings.

## Overview

Below is an example of segment control style declaration:

```json
{
    "segmentControlStyle": {
        "primary": {
            "surfaceColor": {
                "normal": "#FFFFFF0F",
                "pressed": "#3D3D3D",
                "disabled": "#FFFFFF0F"
            },
            "borderColor": {
                "normal": "#FFFFFF0F",
                "pressed": "#FFFFFF1F",
                "disabled": "#FFFFFF00"
            },
            "selectedButtonStyle": {
                "surfaceColor": "$colors/textBrandPrimary",
                "borderColor": "#FFFFFF0F",
                "textColor": "#FFFFFF",
                "iconColor": "#FFFFFF",
                "borderWidth": 0,
                "typography": "$typography/textLargeSemiBold",
                "shape": "$shapes/roundedRectangle"
            },
            "normalButtonStyle": {
                "surfaceColor": "#1A1A1A",
                "borderColor": "#FFFFFF0F",
                "textColor": "$colors/textSecondary",
                "iconColor": "#FFFFFF",
                "borderWidth": 0,
                "typography": "$typography/textLargeSemiBold",
                "shape": "$shapes/roundedRectangle"
            },
            "borderWidth": 0,
            "padding": 8,
            "shape": "$shapes/roundedRectangle"
        }
    }
}
```
