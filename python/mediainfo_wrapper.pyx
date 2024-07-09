# cython: language_level=3
# cython: infer_types=True

cimport mediainfo
from cpython.dict cimport PyDict_New, PyDict_SetItemString
from cpython.bytes cimport PyBytes_FromStringAndSize
from libc.string import strlen

cdef class MediaInfo:
    cdef mediainfo.MediaInfo_Handle handle

    def __init__(self) -> None:
        self.handle = mediainfo.MediaInfo_New()

    def __dealloc__(self):
        mediainfo.MediaInfo_Delete(self.handle)

    # TODO: check valid path?
    def open(self, filepath):
        return mediainfo.MediaInfo_Open(self.handle, filepath.encode('utf-8'))

    def option(self, option, value):
        return mediainfo.MediaInfo_Option(self.handle, option.encode('utf-8'), value.encode('utf-8')).decode('utf-8')

    def get(self, stream_kind, stream_number, parameter, kind_of_info=0, kind_of_search=0):
        return mediainfo.MediaInfo_Get(self.handle, stream_kind, stream_number, parameter.encode('utf-8'), <size_t>kind_of_info, <size_t>kind_of_search).decode('utf-8')

    def get_metadata(self):
        cdef dict metadata = PyDict_New()
        cdef bytes value
        cdef size_t i, stream_count, stream_kind
        cdef char* parameter
        cdef char* result
        cdef size_t num_parameters = <size_t>10
        cdef char*[:] = parameters