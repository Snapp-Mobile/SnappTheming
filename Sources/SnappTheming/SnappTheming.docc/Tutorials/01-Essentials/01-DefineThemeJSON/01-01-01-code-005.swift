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
        }
    }
    """

extension SnappThemingDeclaration {
    static let light = try! SnappThemingParser.parse(from: json)
}
