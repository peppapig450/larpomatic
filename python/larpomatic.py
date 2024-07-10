from PIL import Image
import pyexiv2
import argparse
from pprint import pprint
from pathlib import Path


def get_lens_metadata(exif_metadata):
    lens_metadata = {}

    desired_keys = {"Exif.Photo.LensModel", "Exif.Photo.LensMake"}


def copy_metadata(source_path, target_path, output_path):
    source_path = Path(source_path).resolve()
    metadata_dict = {}

    # Load source and target images
    with source_path.open("rb") as source_image:
        with pyexiv2.ImageData(source_image.read()) as data:
            metadata_dict.update(data.read_exif_detail())
            metadata_dict.update(data.read_xmp_detail())
            metadata_dict.update(data.read_iptc_detail())

    # Save the target image with the new metadata
    # target_image.save(output_path)
    # print(
    #    f"Metadata copied from {source_path} to {target_path} and saved to {output_path}"
    # )
    return metadata_dict


def main():
    parser = argparse.ArgumentParser(
        description="Copy metadata from one image to another."
    )
    parser.add_argument(
        "--source", "-s", required=True, help="Path to the source image"
    )
    parser.add_argument(
        "--target", "-t", required=False, help="Path to the target image"
    )
    parser.add_argument(
        "--output", "-o", required=False, help="Path to save the output image"
    )

    args = parser.parse_args()

    metadata = copy_metadata(args.source, args.target, args.output)
    pprint(metadata)


if __name__ == "__main__":
    main()
