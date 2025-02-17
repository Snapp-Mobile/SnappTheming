import SnappTheming

private let json = """
    {}
    """

extension SnappThemingDeclaration {
    static let light = try! SnappThemingParser.parse(from: json)
}
