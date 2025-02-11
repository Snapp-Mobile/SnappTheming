# ``SnappThemingTypographyDeclarations``

Manages typography tokens, combining font and size. Offers complete control over how text styles are applied within the application.

## Overview

Typography declarations are considered high-level because they should refer to fundamental elements such as metrics and fonts.

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
