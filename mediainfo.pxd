cdef extern from "MediaInfoDll.h":
    ctypedef void* MediaInfo_Handle
    MediaInfo_Handle MediaInfo_New()
    void MediaInfo_Delete(MediaInfo_Handle Handle)
    size_t MediaInfo_Open(MediaInfo_Handle Handle, char* File)
    char* MediaInfo_Option(MediaInfo_Handle Handle, char* Option, char* Value)
    char* MediaInfo_Get(MediaInfo_Handle Handle, size_t StreamKind, size_t StreamNumber, char* Parameter, size_t, size_t KindOfInfo, size_t KindOfSearch)