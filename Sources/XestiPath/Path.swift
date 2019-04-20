// © 2018 J. G. Pusey (see LICENSE.md)

import Foundation

public final class Path: RawRepresentable {

    // MARK: Public Initializers

    public convenience init() {
        self.init("")
    }

    public init(_ rawValue: String) {
        self.rawValue = NSString.path(withComponents: [rawValue])
    }

    public convenience init?(rawValue: String) {
        self.init(rawValue)
    }

    // MARK: Public Instance Properties

    public let rawValue: String

    public var fileURL: URL {
        return URL(fileURLWithPath: rawValue)
    }
}

// MARK: - Comparable

extension Path: Comparable {
    public static func < (lhs: Path, rhs: Path) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// MARK: - CustomStringConvertible

extension Path: CustomStringConvertible {
    public var description: String {
        return rawValue
    }
}

// MARK: - Equatable

extension Path: Equatable {
    public static func == (lhs: Path, rhs: Path) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

// MARK: - Hashable

extension Path: Hashable {
    public func hash(into hasher: inout Hasher) {
        rawValue.hash(into: &hasher)
    }
}

// MARK: - Extension

public extension Path {

    // MARK: Public Type Methods

    static func + (lhs: Path, rhs: Path) -> Path {
        guard
            !rhs.isAbsolute
            else { return rhs }

        return Path(lhs.rawValue + "/" + rhs.rawValue)
    }
}
