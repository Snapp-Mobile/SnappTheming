# How to produce a theme file

## Create a `base.json` file

A `base.json` file is needed for creating the theme. This file may contain declarations for `metrics`, `colors`, `typography`, `buttonStyles`, etc.

> Important: The file may also contain base64-encoded data but it's recommended to use the generator to avoid dealing with large theme files

Below is an example `base.json`:

```(json)
{
    "colors": {
        "primary": "#ff0000",
        "secondary": {
            "light": "#00ff00",
            "dark": "#0000ff"
        }
    },
    "metrics": {
        "default": 8,
        "small": 4,
        "large": 12
    }
}
```

You can use references to `colors`, `metrics`, `images` and `fonts`, as such:

```(json)
{
    "colors": {
        "appPrimary": "#ff0000",
        "appTintColor": {
            "light": "#ff0000",
            "dark": "#00ffff"
        },
        "textPrimary": "$colors/appPrimary",
        "buttonPrimary": "$colors/appTintColor"
    },
    "metrics": {
        "small": 4,
        "regular": 8,
        "large": 12,
        "default": "$metrics/regular"
    }
}
```

## Drop your assets in the `images` and the `fonts` folders

The file name will be used as key in the output JSON and the folder name will be used for grouping the assets together.

So, if you have a file named `Lato.ttf` in the `fonts` folder you will get the following in the aggregated JSON:

```(json)
...
"fonts": {
    fonts": {
        "Lato": {
            "postScriptName": "Lato-Regular",
            "source": "data:font/ttf;base64,AAEAAAASAQAABAAgRkZUTW5UR..."
        }
    }
}
...
```

You can use `$fonts/Lato` to refer to the font where needed (e.g. for typography declarations)

## Aggregate the content of `images` and `fonts` folders with the `base.json` for delivery

There's an aggregation script that will embed the base64 encoding for the images and the fonts in the corresponding directories.

### Steps to Run the Aggregation Script

1. From the root of your project, change your working directory to `theme_generator`

    ```(zsh)
    cd utils/theme_generator
    ```

2. Execute the following command to process the sub-folders:

    ```(zsh)
    python3 aggregate.py
    ```

### Output Details

The script will produce a file named `theme.json`. 

The output file will add the base64-encoded data for all the entries in the `fonts` and `images` directories. The key for each asset will match its filename. 

This means that if you have a file named `logo.png` in the `images` folder it will add the following to the output:

```(json)
...
"images": {
    "logo": "data:image/png;base64,iVBORw0K..."
}
...
```

On top of that it will try to preserve and merge the `images` and `fonts` contents on top of any existing images or font declarations in `base.json`. 

Please ensure that you are not using the same string for a key declaration in `base.json` and for naming an asset in `images` or `fonts` folder to avoid overwriting when producing the output.
