# ``SnappThemingMetricDeclarations``

Manages numerical tokens, including spacing, corner radius, and border widths. This functionality facilitates the creation of a consistent design language with reusable measurements.

## Overview

Metrics are defined using decimal or floating-point values that are added as child properties of the root-level `metrics` property.

Below is an example of the supported annotations:

```json
{
    "metrics": {
        "spacingNormal": 8,
        "spacingLarge": 12.0,
        "fontBody": 14.0
    }
}
```
