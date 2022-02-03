package nakama

when ODIN_OS == "windows" {
    foreign import lib {
        "windows/nakama-cpp.lib",
        "windows/cpprest.lib",
        "windows/crypto.lib",
        "windows/libprotobuf.lib",
        "windows/ssl.lib",
    }
}
when ODIN_OS == "linux" {
    foreign import lib {
        "linux/libnakama-cpp.a",
        "linux/libcpprest.a",
        "linux/libcrypto.a",
        "linux/libprotobuf.a",
        "linux/libssl.a",
    }
}
when ODIN_OS == "darwin" {
    foreign import lib {
        "macos/libnakama-cpp.a",
        "macos/libcpprest.a",
        "macos/libcrypto.a",
        "macos/libprotobuf.a",
        "macos/libssl.a",
    }
}

@(default_calling_convention = "c")
foreign lib {
    @(link_name = "RtErrorCode_toString")
    rt_error_code_to_string :: proc(code: RtErrorCode) -> cstring ---
}
