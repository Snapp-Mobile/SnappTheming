//
//  SampleJSON.swift
//  Example
//
//  Created by Ilian Konchev on 21.11.24.
//


// json as string for simplicity
var sampleJSON = """
{
    "images": {
        "image1": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=",
        "icon": "$images/image1"
    },
    "shapeStyle": {
        "linearGradient": {
            "colors": ["#006400", "#228B22", "#32CD32", "#FFD700", "#FF0000"],
            "startPoint": "top",
            "endPoint": "bottom"
        },
        "radialGradient": {
            "colors": ["#FF0000", "#FFD700", "#32CD32", "#006400"],
            "center": "center",
            "startRadius": 0,
            "endRadius": 200
        },
        "angularGradient": {
            "colors": ["#006400", "#228B22", "#32CD32", "#FFD700", "#FF0000"],
            "center": "center",
            "startAngle": -90,
            "endAngle": 270
        },
    },
    "colors": {
        "appPrimary": {
            "light": "#027FFC", 
            "dark": "#20B0FF"
        },
        "textPrimary": {
            "light": "#000000",
            "dark": "#E7E7E7"
        },
        "textPrimaryPressed": {
            "light": "#333333",
            "dark": "#CCCCCC"
        },
        "textSecondary": {
            "light": "#888888",
            "dark": "#FFFFFF80"
        },
        "textPrimaryDisabled": {
            "light": "#AAAAAA",
            "dark": "#555555"
        },
        "surfacePrimary": {
            "light": "#f1f1f1",
            "dark": "#1a1a1a"
        },
        "tertiary": "#F7D818",
        "tertiary": "#F7D818",
        "brightRed": "#FF0000",
        "darkRed": "#E60000",
        "softRed": "#FF6666",
        "deepRed": "#B30000",
        "primary": "$colors/appPrimary",
        "primaryOverload": "$colors/primary",
    },
    "metrics": {
        "xSmall": 2,
        "small": 4,
        "regular": 8,
        "medium": 12,
        "large": 16,
        "extraLarge": 20,
        "default": "$metrics/regular",
    },
    "fonts": {
        "regular": \(regularFontString),
        "medium": \(mediumFontString),
        "bold": \(boldFontString),
        "default": "$fonts/regular"
    },
    "typography": {
        "body": { 
            "font": "$fonts/default", 
            "fontSize": "$metrics/medium" 
        },
        "title": {
            "font": "$fonts/regular",
            "fontSize": 28
        },
        "exotic": {
            "font": \(boldBlockFontString),
            "fontSize": 45
        }
    },
    "interactiveColors": {
        "primary": {
            "normal": "$colors/brightRed",
            "selected": "$colors/deepRed",
            "pressed": "$colors/softRed",
            "disabled": "#CBB8E8"
        },
    },
    "shapes": {
        "circle": {
            "width": 64,
            "height": 64,
            "cornerRadius": 1000,
            "padding": [0]
        },
        "roundedRectangle": {
            "width": 80,
            "height": 44,
            "cornerRadius": "$metrics/large",
            "padding": [12, 16]
        }
    },
    "buttonConfigurations": {
        "primary": {
            "surfaceColor": "$interactiveColors/primary",
            "textColor": "$colors/textPrimary",
            "borderColor": "$colors/textPrimary",
            "borderWidth": "$metrics/xSmall",
            "shape": "$shapes/circle",
            "typography": "$typography/title"
        },
        "secondary": {
            "surfaceColor": {
                "normal": "#CBB8E8",
                "selected": "#B6A2D9",
                "pressed": "#A68CC7",
                "disabled": "#E2D3F4"
            },
            "textColor": {
                "normal": "$colors/textSecondary",
                "selected": "#5A3A99",
                "pressed": "$colors/textSecondary",
                "disabled": "#A68CC7"
            },
            "borderColor": {
                "normal": "#8A6CC0",
                "selected": "#7A5CA8",
                "pressed": "#6C4C91",
                "disabled": "#B89ECF"
            },
            "borderWidth": "$metrics/xSmall",
            "shape": "$shapes/roundedRectangle",
            "typography": "$typography/body"
        }
    }
}
"""
