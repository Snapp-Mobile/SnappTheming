import SnappTheming

private let json = """
    {
        "colors": {
            "primary": "#FF0000",
            "textPrimary": "#000",
            "textSecondary": "#CCC",
            "surfacePrimary": "#FFF",
            "surfaceSecondary": "#EEE"
        }
    }
    """

extension SnappThemingDeclaration {
    static let light = try! SnappThemingParser.parse(from: json)
}
