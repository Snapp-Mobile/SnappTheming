# ``SnappThemingAnimationDeclarations``

Manages the animation declarations, ensuring that animations are mapped to their corresponding representations and configurations.

## Overview

Animations can be added as base64-encoded entities at the root-level `animations` property.

Below is an example of Lottie animation declaration (the base64-encoded string has been shortened for readability):

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

### Animations support martix

format|iOS|iPadOs|tvOS|watchOS|visionOS|
---|:-:|:-:|:-:|:-:|:-:|
Lottie|✅|✅|✅|❌|✅|

