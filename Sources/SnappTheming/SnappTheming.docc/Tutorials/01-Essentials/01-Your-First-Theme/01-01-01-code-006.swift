import SnappTheming

private let json = """
    {
        "colors": {
            "primary": "#452BE9",
            "textPrimary": "#000",
            "textSecondary": "#8E8E93",
            "surfacePrimary": "#FFF",
            "surfaceSecondary": "#D1D1D6"
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
    static let light = try! SnappThemingParser.parse(from: json)
}
