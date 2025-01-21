# ``SnappThemingSVGSupport``

A library to provide support for SVG asset handling in [`SnappTheming`](https://ios-theming.snappmobile.io/documentation/snapptheming)

## Overview

The SVG support is driven by [SVGKit](https://github.com/svgkit/svgkit)

To enable the SVG support all you need to do is to register the SVG image parser as follows:

```swift
import SnappTheming
import SnappThemingSVGSupport

// in the app delegate or SwiftUI Application init
SnappThemingImageProcessorsRegistry.shared.register(.svg)
```

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
