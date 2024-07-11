from libc.stdint cimport uint8_t

cdef extern from "libheif/heif.h":
    ctypedef struct heif_context:
        pass

    ctypedef struct heif_image_handle:
        pass

    ctypedef struct heif_image:
        pass

    heif_context* heif_context_alloc()
    void heif_context_free(heif_context* ctx)
    int heif_context_read_from_file(heif_context* ctx, const char* filename, const void* options)
    int heif_context_get_primary_image_handle(heif_context* ctx, heif_image_handle** handle)
    int heif_image_handle_decode_image(heif_image_handle* handle, heif_image** img, int colorspace, int chroma)

    int heif_image_handle_get_width(const heif_image_handle* handle)
    int heif_image_handle_get_height(const heif_image_handle* handle)

    heif_image* heif_image_create(int width, int height, int colorspace, int chroma)
    void heif_image_release(heif_image* img)
    int heif_image_add_plane(heif_image* img, int channel, int width, int height, int bits_per_pixel)
    uint8_t* heif_image_get_plane(heif_image* img, int channel, int* stride)

    ctypedef struct heif_encoder:
        pass

    heif_encoder* heif_encoder_alloc()
    void heid_encoder_release(heif_encoder* enc)
    int heif_encoder_set_lossy_quality(heif_encoder* enc, int quality)
    int heif_context_encode_image(heif_context* ctx, heif_image* img, heif_encoder* enc, void *options, const char* filename)