class LarpomaticProcessingError(Exception):
    """
    Base exception for Larpomatic errors.
    """

    pass


class LarpomaticImageProcessingError(LarpomaticProcessingError):
    """
    Sub-class base exception for any image processing related error.
    """

    pass


class LarpomaticMetadataHandlingError(LarpomaticProcessingError):
    """
    Sub-class base exception for any metadata processing/handling related error.
    """

    pass


class UnsupportedImageFormatError(LarpomaticProcessingError):
    """
    Raised when an uploaded image format is not supported for processing.
    """

    pass


class NoLensInformationError(LarpomaticProcessingError):
    """
    Raised when the source image uploaded to copy metadata from contains no Lens information.
    """

    # TODO: maybe in the future add the ability to generate this without input metadata.
    pass


class InvalidMetadataError(LarpomaticProcessingError):
    """
    Raised when a error occurs while processing the metadata.
    """

    pass
