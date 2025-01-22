# ``SnappThemingImageDeclarations``

Manages image tokens. Supports bitmap assets for different scenarios.

## Overview

Images can be added as base64-encoded entities under the root-level `images` property. 

Below is an example of a valid image declaration (the base64-encoded string is shortened for readability):

```json
{
    "images": {
        "basket": "data:image/png;base64,iVBORw0KG...=="
    }
}
```

> The library provides support for JPEG, PNG and PDF assets out of the box. Additional support for SVG assets (using [`SGVKit`](https://github.com/SVGKit/SVGKit)) is available through the [`SnappThemingSVGSupport`](http://ios-theming.snappmobile.io/documentation/snappthemingsvgsupport/) package.
