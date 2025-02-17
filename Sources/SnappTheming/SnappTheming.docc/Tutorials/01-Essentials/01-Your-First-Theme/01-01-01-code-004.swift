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
    }
    """

extension SnappThemingDeclaration {
    static let light = try! SnappThemingParser.parse(from: json)
}
