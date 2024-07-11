cimport libheif
from libheif cimport heif_context, heif_image_handle, heif_image, heif_encoder, heif_context_alloc, heif_context_free, heif_context_read_from_file, heif_context_get_primary_image_handle, heif_image_handle_decode_image, heif_image_handle_get_width, heif_image_handle_get_height, heif_image_create, heif_image_release, heif_image_add_plane, heif_image_get_plane, heif_encoder_alloc, heif_encoder_release, heif_encoder_set_lossy_quality, heif_context_encode_image
from cpython.mem cimport PyMem_Malloc, PyMem_Free
from libc.string cimport memcpy

# Inline functions for checking null pointers
cdef inline bint is_null(void* ptr):
    """
    Checks if a pointer is null.

    Args:
        ptr: Any C pointer.

    Returns:
        True if the pointer is null, False otherwise.
    """
    return ptr == NULL #type: ignore

cdef inline bint is_not_null(void* ptr):
    """
    Checks if a pointer is not null.

    Args:
        ptr: Any C pointer.

    Returns:
        True if the pointer is not null, False otherwise.
    """
    return ptr != NULL #type: ignore

cdef class HeifWrapper:
    cdef heif_context* ctx
    cdef heif_image_handle* handle
    cdef heif_image* img
    cdef heif_encoder* encoder

    def __cinit__(self):
        self.ctx = libheif.heif_context_alloc()
        if is_null(self.ctx):
            raise MemoryError("Failed to allocate heif_context")

    def __dealloc__(self):
        if is_not_null(self.ctx):
            heif_context_free(self.ctx)
        if is_not_null(self.img):
            heif_image_release(self.img)
        if is_not_null(self.encoder):
            heif_encoder_release(self.encoder)
