from PIL import Image, UnidentifiedImageError
import pillow_heif
from dataclasses import dataclass


@dataclass
class ConvertedImage:
    """
    Dataclass to store information about a converted image.
    """

    path: str
    data: bytes
