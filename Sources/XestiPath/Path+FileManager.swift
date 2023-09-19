// © 2018–2022 J. G. Pusey (see LICENSE.md)

import Foundation

public extension Path {

    // MARK: Public Type Properties

    static var currentDirectory: Path {
        get { .init(Path.fileManager.currentDirectoryPath) }
        set { Path.fileManager.changeCurrentDirectoryPath(newValue.rawValue) }
    }

    // MARK: Public Instance Properties

    var componentsToDisplay: [String]? {
        Path.fileManager.componentsToDisplay(forPath: rawValue)
    }

    var displayName: String {
        Path.fileManager.displayName(atPath: rawValue)
    }

    var exists: Bool {
        Path.fileManager.fileExists(atPath: rawValue)
    }

    var isDeletable: Bool {
        Path.fileManager.isDeletableFile(atPath: rawValue)
    }

    var isExecutable: Bool {
        Path.fileManager.isExecutableFile(atPath: rawValue)
    }

    var isReadable: Bool {
        Path.fileManager.isReadableFile(atPath: rawValue)
    }

    var isWritable: Bool {
        Path.fileManager.isWritableFile(atPath: rawValue)
    }

    // MARK: Public Instance Methods

    func attributes() throws -> Attributes {
        .init(try Path.fileManager.attributesOfItem(atPath: rawValue))
    }

    func contentsOfDirectory(includingPropertiesForKeys keys: [URLResourceKey]? = nil,
                             options: FileManager.DirectoryEnumerationOptions = []) throws -> [Path] {
        try Path.fileManager.contentsOfDirectory(at: fileURL,
                                                 includingPropertiesForKeys: keys,
                                                 options: options).map {
            Path($0.path)
        }
    }

    func copy(to destination: Path) throws {
        try Path.fileManager.copyItem(at: fileURL,
                                      to: destination.fileURL)
    }

    func createDirectory(withIntermediateDirectories createIntermediates: Bool = true,
                         attributes: Attributes? = nil) throws {
        try Path.fileManager.createDirectory(at: fileURL,
                                             withIntermediateDirectories: createIntermediates,
                                             attributes: attributes?.dictionaryRepresentation)
    }

    func createFile(contents: Data? = nil,
                    attributes: Attributes? = nil) -> Bool {
        Path.fileManager.createFile(atPath: rawValue,
                                    contents: contents,
                                    attributes: attributes?.dictionaryRepresentation)
    }

    func createSymbolicLink(to destination: Path) throws {
        try Path.fileManager.createSymbolicLink(at: fileURL,
                                                withDestinationURL: destination.fileURL)
    }

    func destinationOfSymbolicLink() throws -> Path {
        let dstPath = Path(try Path.fileManager.destinationOfSymbolicLink(atPath: rawValue))

        if dstPath.isAbsolute {
            return dstPath
        }

        return appendingComponent("..") + dstPath
    }

    func link(to destination: Path) throws {
        try Path.fileManager.linkItem(at: fileURL,
                                      to: destination.fileURL)
    }

    func move(to destination: Path) throws {
        try Path.fileManager.moveItem(at: fileURL,
                                      to: destination.fileURL)
    }

    func remove() throws {
        try Path.fileManager.removeItem(at: fileURL)
    }

    func replace(with replacement: Path,
                 backup: Path? = nil,
                 usingNewMetaDataOnly: Bool = false,
                 withoutDeletingBackupItem: Bool = false) throws -> Path {
        var options: FileManager.ItemReplacementOptions = []

        if usingNewMetaDataOnly {
            options.formUnion(.usingNewMetadataOnly)
        }

        if withoutDeletingBackupItem {
            options.formUnion(.withoutDeletingBackupItem)
        }

        var resultURL: NSURL?

        try Path.fileManager.replaceItem(at: fileURL,
                                         withItemAt: replacement.fileURL,
                                         backupItemName: backup?.rawValue,
                                         options: options,
                                         resultingItemURL: &resultURL)

        return Path(resultURL?.path ?? "")
    }

    func setAttributes(_ attributes: Attributes) throws {
        try Path.fileManager.setAttributes(attributes.dictionaryRepresentation,
                                           ofItemAtPath: rawValue)
    }

    // MARK: Private Type Properties

    private static var fileManager: FileManager = .default
}
