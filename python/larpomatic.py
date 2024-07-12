import argparse
from pprint import pprint
from pathlib import Path
import shlex
import exiftool


def get_json_metadata(et: exiftool.ExifTool, source_image):
    params = ["-ee3", "-U", "-G3:1", "-api", "requestall=3", "-api", "largefilesupport"]

    data = et.execute_json(*params, source_image)

    return data


def copy_metadata_to_image(source_image, target_image):
    with exiftool.ExifToolAlpha() as et:
        et.copy_tags(source_image, target_image)


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

    # copy_metadata(args.source, args.target)
    copy_metadata_to_image(args.source, args.target)


if __name__ == "__main__":
    main()
