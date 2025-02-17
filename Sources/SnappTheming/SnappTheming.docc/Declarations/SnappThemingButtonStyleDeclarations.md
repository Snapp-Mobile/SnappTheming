# ``SnappThemingButtonStyleDeclarations``

Manages button styles, including properties such as surface and text colors, border widths and colors, shapes, and typography for various button states.

## Overview

Below is an example of two button styles. Button styles may contains aliases to [shapes](<doc:SnappThemingShapeDeclarations>), [colors](<doc:SnappThemingColorDeclarations>) and [typography](<doc:SnappThemingTypographyDeclarations>) declarations.

For more information, see ``SnappThemingButtonStyleRepresentation``

```json
{
    "buttonStyles": {
        "primary": {
            "surfaceColor": {
                "normal": "#1A1A1A",
                "pressed": "#3D3D3D",
                "disabled": "#FFFFFF0F"
            },
            "borderColor": {
                "normal": "#FFFFFF0F",
                "pressed": "#FFFFFF1F",
                "disabled": "#FFFFFF00"
            },
            "textColor": {
                "normal": "#FFFFFF",
                "pressed": "#FFFFFF",
                "disabled": "#888888"
            },
            "borderWidth": 1,
            "typography": "$typography/textSmall",
            "shape": "$shapes/roundedRectangle"
        },
        "primarySelected": {
            "surfaceColor": {
                "normal": "$colors/primary",
                "pressed": "#3D3D3D",
                "disabled": "#FFFFFF0F"
            },
            "borderColor": {
                "normal": "#FFFFFF0F",
                "pressed": "#FFFFFF1F",
                "disabled": "#FFFFFF00"
            },
            "textColor": {
                "normal": "#FFFFFF",
                "pressed": "#FFFFFF",
                "disabled": "#888888"
            },
            "borderWidth": 1,
            "typography": "$typography/textSmall",
            "shape": "$shapes/roundedRectangle"
        }
    }
}
```

### Toggle Buttons

The “toggle button” is a widely recognized user experience (UX) design concept. It is a button that exhibits two distinct states: a “normal” state and a “selected” state.
`SnappTheming` supports toggle buttons out of the box with `SwiftUI`, thanks to a helper library called `SnappThemingSwiftUIHelpers`.

Let's assume that we need to incorporate a toggle button within our application. The initial step involves defining distinct button styles for its normal and selected states. Let us denote the style for the normal state as `toggleButton` and the style for the selected state as `toggleButtonSelected`. Below is the code snippet that can be incorporated into our `SwiftUI` view to support the toggling functionality:

```(swift)
import SnappTheming
import SnappThemingSwiftUIHelpers

struct ToggleButtonsView: View {
    @Environment(SnappThemingDeclaration.self) var declaration
    @State var isFirstSelected: Bool = false
    @State var isSecondSelected: Bool = false

    var body: some View {
        VStack {
            Button("Toggle 1") {
                isFirstSelected.toggle()
            }
            .buttonStyle(declaration.buttonStyles.action, selected: declaration.buttonStyles.actionSelected)
            .selected(isFirstSelected)

            Button("Toggle 2") {
                isSecondSelected.toggle()
            }
            .buttonStyle(declaration.buttonStyles.action, selected: declaration.buttonStyles.actionSelected)
            .selected(isSecondSelected)
        }
    }
}
```

