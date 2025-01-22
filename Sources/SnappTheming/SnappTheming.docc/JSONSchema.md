# JSON Schema

The main building blocks

## Overview

This article describes the types of objects you can use to construct a valid theme declaration JSON. 

We have split the object types into two main groups - foundation objects and high-level objects

#### Foundation Objects

- [Colors](<doc:SnappThemingColorDeclarations>)
- [Fonts](<doc:SnappThemingFontDeclarations>)
- [Gradients](<doc:SnappThemingGradientDeclarations>)
  - [Angular](<doc:SnappThemingGradientDeclarations#Angular-Gradient>) 
  - [Linear](<doc:SnappThemingGradientDeclarations#Linear-Gradient>)
  - [Radial](<doc:SnappThemingGradientDeclarations#Radial-Gradient>)
- [Images](<doc:SnappThemingImageDeclarations>)
- [Lottie Animations](<doc:SnappThemingAnimationDeclarations>)
- [Metrics](<doc:SnappThemingMetricDeclarations>)
- [Shapes](<doc:SnappThemingShapeDeclarations>)
  - [Rectangle](<doc:SnappThemingShapeDeclarations#Rectangle>)
  - [Ellipse](<doc:SnappThemingShapeDeclarations#Ellipse>)
  - [Circle](<doc:SnappThemingShapeDeclarations#Circle>)
  - [Capsule](<doc:SnappThemingShapeDeclarations#Capsule>)
  - [Rounded rectangle](<doc:SnappThemingShapeDeclarations#Rounded-Rectangle>)
  - [Uneven rouded rectangle](<doc:SnappThemingShapeDeclarations#Uneven-Rounded-Rectangle>)

#### High-level objects

- [Aliases](<doc:Aliases>)
- [Button Styles](doc:SnappThemingButtonStyleDeclarations)
- [Typography](<doc:SnappThemingTypographyDeclarations>)


### Aliases

Aliases can be used to link a value to another value. Providing an alias instead of a value means that the value of the objevt that you are aliasing will be used instead. Think of these as declaration hyperlinks. They are useful when building high-level configurations (typography, button styles, shapes).

Aliases should start with the dollar sign (`$`) and should include the full path to the declaration they are referring to.

Below is an example of a valid use of aliases as `surfaceWidgetPrimary` is declared so that it's an alias of `surfaceTertiary`. 

```json
{
    "colors": {
        "surfacePrimary": "#FF0000",
        "surfaceSecondary": "#FF00000A",
        "surfaceTertiary": "#0AFF0000",
        "surfaceWidgetPrimary": "$colors/surfaceTertiary",
    }
}
```

