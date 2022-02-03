package realtime

import c "core:c/libc"
import nakama ".."

RtErrorCode :: enum c.int {
    ConnectError             = -1,
    TransportError           = -2,
    RuntimeException         = 0,
    UnrecognizedPayload      = 1,
    MissingPayload           = 2,
    BadInput                 = 3,
    MatchNotFound            = 4,
    MatchJoinRejected        = 5,
    RuntimeFunctionNotFound  = 6,
    RuntimeFunctionException = 7,
}

RtError :: struct {
    code:    RtErrorCode,
    message: cstring,
    ctx:     nakama.StringMap,
}

RtClient :: ^struct {
    c: c.char,
}

RtClientReqData :: rawptr

RtClientErrorCallback :: proc(_: RtClient, _: RtClientReqData, _: ^RtError)

@(default_calling_convention="c")
foreign lib {
    @(link_name="RtErrorCode_toString") error_code_to_string :: proc(code: RtErrorCode) -> cstring ---
}
