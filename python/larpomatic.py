import pyexiv2
import argparse
from pprint import pprint
from pathlib import Path
from typing import Any


def create_new_metadata(source_metadata: dict, target_metadata: dict):
    remove_target_tags = {
        "Exif.Image.Software",
    }

    # Remove the software key so that we can use the source's software key, and merge the keys
    for key in remove_target_tags:
        if target_metadata.get(key, None) is not None:
            del target_metadata[key]

    # Combine the two images metadata, target_metadata's keys take priority
    # This is necessary so that the dimensions from the target image are used
    new_metadata: dict[str, dict[str, str]] = source_metadata | target_metadata

    return new_metadata


def copy_metadata(source_path, target_path):
    source_path = Path(source_path).resolve()
    target_path = Path(target_path).resolve()
    source_metadata = {}
    original_target_metadata = {}

    pyexiv2.set_log_level(1)
    # Load source and target images
    with source_path.open("rb") as source_image:
        with pyexiv2.ImageData(source_image.read()) as source_data:
            source_metadata["exif"] = source_data.read_exif()
            source_metadata["xmp"] = source_data.read_xmp()
            source_metadata["iptc"] = source_data.read_iptc()

    with target_path.open("rb") as target_image:
        with pyexiv2.ImageData(target_image.read()) as target_data:
            original_target_metadata.update(target_data.read_exif())
            new_metadata = create_new_metadata(
                source_metadata, original_target_metadata
            )
            target_data.modify_exif(new_metadata["exif"])
            target_data.modify_xmp(new_metadata["xmp"])
            target_data.modify_iptc(new_metadata["iptc"])

    # Save the target image with the new metadata
    # target_image.save(output_path)
    # print(
    #    f"Metadata copied from {source_path} to {target_path} and saved to {output_path}"
    # )


def main():
    parser = argparse.ArgumentParser(
        description="Copy metadata from one image to another."
    )
    parser.add_argument(
        "--source", "-s", required=True, help="Path to the source image"
    )
    parser.add_argument(
        "--target", "-t", required=True, help="Path to the target image"
    )
    parser.add_argument(
        "--output", "-o", required=False, help="Path to save the output image"
    )

    args = parser.parse_args()

    copy_metadata(args.source, args.target)


if __name__ == "__main__":
    main()
