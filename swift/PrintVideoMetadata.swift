import Foundation
import AVFoundation

func printMetadata(from videoURL: URL) async throws {
    // Create an AVAsset from the provided url
    let asset = AVAsset(url: videoURL)

    // Load available metadata formats
    let avaiableMetadataFormats = try await asset.load(.availableMetadataFormats)

    for format in avaiableMetadataFormats {
            // Load metadata for the specific format
            let metadataItems = try await asset.loadMetadata(for: format)

            print("Metadata for format: \(format)")

            // Process the loaded metadata
            for item in metadataItems {
                // Extract the key using commonKey and fall back to item.key
                let key: String
                if let commonKey = item.commonKey {
                    value = try await item.load(stringValue)

                // Print the key and value
                print("\(commonKey): \(item.value ?? "N/A")")
            }
        }
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
    let fileURL : URL
    if let fileURL = URL(fileURLWithPath: filePath)  {
        guard FileManager.default.fileExists(atPath: filePath) else {
            print("File not found at: \(filePath)")
            return
        }
        do {
            try await printMetadata(from: fileURL)
        } catch {
            print("Error creating URL from path: \(filePath)")
            return
        }
    } else {
        print("Error creating URL from path: \(filePath)")
        return
    }

}

main()