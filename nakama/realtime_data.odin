package nakama

import c "core:c/libc"

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
    ctx:     StringMap,
}

RtClient :: ^struct {
    c: c.char,
}

RtClientParameters :: struct {
    host: cstring,
    port: c.int32_t,
    ssl:  bool,
}

RtClientProtocol :: enum c.int {
    Protobuf,
    Json,
}

RtClientDisconnectInfo :: struct {
    code:   c.uint16_t,
    reason: cstring,
    remote: bool,
}

RtClientReqData :: rawptr

RtClientErrorCallback :: proc(_: RtClient, _: RtClientReqData, _: ^RtError)

BaseChannelInfo :: struct {
    room_name:   cstring,
    group_id:    cstring,
    user_id_one: cstring,
    user_id_two: cstring,
}

Channel :: struct {
    id:              cstring,
    presences:       ^UserPresence,
    presences_count: c.uint16_t,
    self:            UserPresence,
    using info:      BaseChannelInfo,
}

ChannelMessageAck :: struct {
    channel_id:  cstring,
    message_id:  cstring,
    username:    cstring,
    code:        c.uint32_t,
    create_time: Timestamp,
    update_time: Timestamp,
    persistent:  bool,
    using info:  BaseChannelInfo,
}

ChannelPresenceEvent :: struct {
    channel_id:   cstring,
    joins:        ^UserPresence,
    joins_count:  c.uint16_t,
    leaves:       ^UserPresence,
    leaves_count: c.uint16_t,
    using info:   BaseChannelInfo,
}

MatchData :: struct {
    match_id: cstring,
    presence: UserPresence,
    op:       c.int64_t,
    data:     Bytes,
}

MatchPresenceEvent :: struct {
    match_id:     cstring,
    joins:        ^UserPresence,
    joins_count:  c.uint16_t,
    leaves:       ^UserPresence,
    leaves_count: c.uint16_t,
}

MatchmakerUser :: struct {
    presence:      UserPresence,
    string_props:  StringMap,
    numeric_props: StringDoubleMap,
}

MatchmakerMatched :: struct {
    ticket:      cstring,
    match_id:    cstring,
    token:       cstring,
    users:       ^MatchmakerUser,
    users_count: c.uint16_t,
    self:        MatchmakerUser,
}

MatchmakerTicket :: struct {
    ticket: cstring,
}

Party :: struct {
    id:              cstring,
    open:            bool,
    max_size:        c.int,
    self:            UserPresence,
    leader:          UserPresence,
    presences:       ^UserPresence,
    presences_count: c.uint16_t,
}

PartyClose :: struct {
    id: cstring,
}

PartyData :: struct {
    party_id: cstring,
    presence: UserPresence,
    op:       c.int64_t,
    data:     Bytes,
}

PartyJoinRequest :: struct {
    party_id:        cstring,
    presences:       ^UserPresence,
    presences_count: c.uint16_t,
}

PartyLeader :: struct {
    party_id: cstring,
    presence: UserPresence,
}

PartyMatchmakerTicket :: struct {
    party_id: cstring,
    ticket:   cstring,
}

PartyPresenceEvent :: struct {
    party_id:     cstring,
    joins:        ^UserPresence,
    joins_count:  c.uint16_t,
    leaves:       ^UserPresence,
    leaves_count: c.uint16_t,
}

Status :: struct {
    presences:       ^UserPresence,
    presences_count: c.uint16_t,
}

StatusPresenceEvent :: struct {
    joins:        ^UserPresence,
    joins_count:  c.uint16_t,
    leaves:       ^UserPresence,
    leaves_count: c.uint16_t,
}

Stream :: struct {
    mode:       c.int32_t,
    subject:    cstring,
    subcontext: cstring,
    label:      cstring,
}

StreamData :: struct {
    stream: Stream,
    sender: UserPresence,
    data:   cstring,
}

StreamPresenceEvent :: struct {
    stream:       Stream,
    joins:        ^UserPresence,
    joins_count:  c.uint16_t,
    leaves:       ^UserPresence,
    leaves_count: c.uint16_t,
}

UserPresence :: struct {
    user_id:     cstring,
    session_id:  cstring,
    username:    cstring,
    persistence: bool,
    status:      cstring,
}
