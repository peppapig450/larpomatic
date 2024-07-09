import Foundation
import AVFoundation

func fetchMetadata(from url: URL) async {
    print(url)
    let asset = AVAsset(url: url)


    do {
        for format in try await asset.load(.availableMetadataFormats) {
            print(format)
            let metadataItems = try await asset.loadMetadata(for: format)
            for item in metadataItems {
                if let key = item.commonKey?.rawValue {
                    let value = try await item.load(.value) as? String ?? "N/A"
                    print("Key: \(key), Value: \(value)")
                }
            }
        }
    } catch {
        print("Error loading metadata: \(error)")
    }
}

// Main function to handle command-line arguments
func main() async {
    let arguments = CommandLine.arguments
    guard arguments.count == 2 else {
        print("Usage: \(arguments[0]) <path to video file>")
        return
    }

    let filePath = arguments[1]
    guard FileManager.default.fileExists(atPath: filePath) else {
        print("File not found at: \(filePath)")
        return
    }

    let videoURL = URL(filePath: filePath)
    await fetchMetadata(from: videoURL)
}

Task {
    await main()
}
