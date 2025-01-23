# ``SnappThemingTypographyDeclarations``

Manages typography tokens, combining font and size. Provides full control over how text styles are applied in the app.

## Overview

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
