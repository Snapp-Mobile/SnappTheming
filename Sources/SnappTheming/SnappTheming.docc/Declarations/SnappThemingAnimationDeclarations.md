# ``SnappThemingAnimationDeclarations``

A type alias for theming animation declarations, mapping animations to their representations and configurations.

## Overview

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
