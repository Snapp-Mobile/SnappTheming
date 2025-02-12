import SnappTheming

private let json = """
    {
        "colors": {
            "primary": "#FF0000",
            "textPrimary": "#000",
            "textSecondary": "#CCC",
            "surfacePrimary": "#FFF",
            "surfaceSecondary": "#EEE"
        },
        "fonts": {
            "Doto-Regular": {
                "postScriptName": "Doto-Regular",
                "source": "data:font/ttf;base64,AAEAAA*******EBMgEA"
            },
            "Doto-SemiBold": {
                "postScriptName": "Doto-SemiBold",
                "source": "data:font/ttf;base64,AAEAAA*******IBAAAA"
            },
            "Doto-Bold": {
                "postScriptName": "Doto-Bold",
                "source": "data:font/ttf;base64,AAEAAA*******kBAAAA"
            }
        },
        "typography": {
            "title": {
                "font": "$fonts/Doto-Bold",
                "fontSize": 16
            },
            "largeTitle": {
                "font": "$fonts/Doto-Bold",
                "fontSize": 18
            },
            "headline": {
                "font": "$fonts/Doto-Bold",
                "fontSize": 14
            },
            "subheadline": {
                "font": "$fonts/Doto-SemiBold",
                "fontSize": 12
            },
            "body": {
                "font": "$fonts/Doto-Regular",
                "fontSize": 14
            }
        }
    }
    """

extension SnappThemingDeclaration {
    static let light: Self = {
        let configuration = SnappThemingParserConfiguration(themeName: "Light")
        let declaration = try! SnappThemingParser.parse(from: json, using: configuration)
        let fontManager = SnappThemingFontManagerDefault(
            themeCacheRootURL: configuration.themeCacheRootURL,
            themeName: configuration.themeName
        )
        fontManager.registerFonts(declaration.fontInformation)
        return declaration
    }()
}
