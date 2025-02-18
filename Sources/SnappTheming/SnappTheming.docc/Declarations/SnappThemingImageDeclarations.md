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

### Image format support matrix

Below is a matrix of supported image formats per platform:

format|iOS|iPadOs|tvOS|watchOS|visionOS|
---|:-:|:-:|:-:|:-:|:-:|
JPEG|✅|✅|✅|✅|✅|
PNG|✅|✅|✅|✅|✅|
PDF|✅|✅|✅|❌|✅|
SVG|✅|✅|✅|❌|❌|

### SFSymbols

Starting from version 0.1.1 `SnappTheming` supports the use of [SFSymbols](https://developer.apple.com/sf-symbols/). To declare a symbol, copy the symbol name from the `SFSymbols` application and prefix is with `system:` as shown below:

```json
{
    "images": {
        "warning": "system:exclamationmark.triangle"
    }
}
```

### Images from in-app Asset catalogs

In some cases you may need to use an asset that is present in the application's asset catalogs. Starting from version 0.1.1, `SnappTheming` facilitates support for that. Simply copy the asset name and prefix it with `asset:` as shown below:

```json
{
    "images": {
        "warning": "asset:snapptheming_logo"
    }
}
```
