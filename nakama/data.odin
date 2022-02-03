package nakama

import c "core:c/libc"

// Constant for default port.
// This is not a valid port, actual port will be selected automatically when this
// value is passed.
DefaultPort :: -1

ErrorCode :: enum c.int {
    Unknown          = 0,
    NotFound         = 1,
    AlreadyExists    = 1,
    InvalidArgument  = 1,
    Unauthenticated  = 4,
    PermissionDenied = 5,
    ConnectionError  = -1,
    InternalError    = -2,
    CancelledByUser  = -3,
}

Error :: struct {
    message: cstring,
    code:    ErrorCode,
}

StringMap :: ^struct {
    c: c.char,
}

StringDoubleMap :: ^struct {
    c: c.char,
}

// The group role status
UserGroupState :: enum c.int {
    // The user is a superadmin will full control of the group.
    Superadmin  = 0,
    // The user is an admin with additional privileges
    Admin       = 1,
    // The user is a regular member
    Member      = 2,
    // The user has requested to join the group
    JoinRequest = 3,
}

// The available channel types on the server
ChannelType :: enum c.int {
    // Default case. Assumed as Room type.
    TypeUnspecified = 0,
    // A chat room which can be created dynamically with a name.
    Room            = 1,
    // A private chat between two users.
    DirectMessage   = 2,
    // A chat within a group on the server.
    Group           = 3,
}

// Unix time in milliseconds
// Use get_unix_timestamp_ms() to get current time
Timestamp :: c.uint64_t

// array of bytes
Bytes :: struct {
    bytes: ^c.uint8_t,
    size:  c.uint32_t,
}

ClientParameters :: struct {
    server_key: cstring,
    host:       cstring,
    port:       i32,
    ssl:        bool,
}

Client :: ^struct {
    c: c.char,
}

Session :: ^struct {
    c: c.char,
}

ClientReqData :: rawptr

ClientDefaultErrorCallback :: proc(client: Client, error: ^Error)
ClientErrorCallback :: proc(client: Client, data: ClientReqData, error: ^Error)
SessionCallback :: proc(client: Client, session: Session)
SuccessEmptyCallback :: proc(client: Client, data: ClientReqData)
LinkSuccessCallback :: proc(client: Client, data: ClientReqData)

Account :: struct {
    user:          User,
    wallet:        cstring,
    email:         cstring,
    devices:       ^AccountDevice,
    devices_count: c.uint16_t,
    custom_id:     cstring,
    verify_time:   Timestamp,
    disable_time:  Timestamp,
}

AccountDevice :: struct {
    id: cstring,
}

ChannelMessage :: struct {
    channel_id:  cstring,
    message_id:  cstring,
    code:        c.int32_t,
    sender_id:   cstring,
    username:    cstring,
    content:     cstring,
    create_time: Timestamp,
    update_time: Timestamp,
    persistent:  bool,
    using info:  BaseChannelInfo,
}

ChannelMessageList :: struct {
    messages:       ^ChannelMessage,
    messages_count: c.uint16_t,
    next:           ^c.char,
    prev:           ^c.char,
}

FriendState :: enum c.int {
    Friend         = 0,
    InviteSent     = 1,
    InviteReceived = 2,
    Blocked        = 3,
}

Friend :: struct {
    user:        User,
    state:       FriendState,
    update_time: Timestamp,
}

FriendList :: struct {
    friends:       ^Friend,
    friends_count: c.uint16_t,
    curosr:        ^c.char,
}

Group :: struct {
    id:          cstring,
    creator_id:  cstring,
    name:        cstring,
    description: cstring,
    lang:        cstring,
    metadata:    cstring,
    avatar_uri:  cstring,
}

GroupList :: struct {
    groups:       ^Group,
    groups_count: c.uint16_t,
    cursor:       ^c.char,
}

GroupUser :: struct {
    user:  User,
    state: UserGroupState,
}

GroupUserList :: struct {
    group_users:       ^Group,
    group_users_count: c.uint16_t,
    cursor:            ^c.char,
}

LeaderboardRecord :: struct {
    leadboard_id:  cstring,
    owner_id:      cstring,
    username:      cstring,
    score:         c.int64_t,
    subscore:      c.int64_t,
    num_score:     c.int32_t,
    max_num_score: c.uint32_t,
    metadata:      cstring,
    create_time:   Timestamp,
    update_time:   Timestamp,
    expiry_time:   Timestamp,
    rank:          c.int64_t,
}

LeaderboardRecordList :: struct {
    records:             ^Group,
    records_count:       c.uint16_t,
    owner_records:       ^Group,
    owner_records_count: c.uint16_t,
    next:                ^c.char,
    prev:                ^c.char,
}

Match :: struct {
    match_id:        cstring,
    authoritative:   bool,
    label:           cstring,
    size:            c.int32_t,
    presences:       ^UserPresence,
    presences_count: c.uint16_t,
    self:            UserPresence,
}

MatchList :: struct {
    matches:       ^Match,
    matches_count: c.uint16_t,
}

Notification :: struct {
    id:          cstring,
    subject:     cstring,
    content:     cstring,
    code:        c.int32_t,
    sender_id:   cstring,
    create_time: Timestamp,
    persistent:  bool,
}

NotificationList :: struct {
    notifications:       ^Notification,
    notifications_count: c.uint16_t,
    cacheable_cursor:    ^c.char,
}

Rpc :: struct {
    id:       cstring,
    payload:  cstring,
    http_key: cstring,
}

StorageObject :: struct {
    collection:       cstring,
    key:              cstring,
    user_id:          cstring,
    value:            cstring,
    version:          cstring,
    permission_read:  StoragePermissionRead,
    permission_write: StoragePermissionWrite,
    create_time:      Timestamp,
    update_time:      Timestamp,
}

StorageObjectAck :: struct {
    collection: cstring,
    key:        cstring,
    version:    cstring,
    user_id:    cstring,
}

StorageObjectId :: struct {
    collection: cstring,
    key:        cstring,
    user_id:    cstring,
}

StorageObjectList :: struct {
    objects:       ^StorageObject,
    objects_count: c.uint16_t,
    cursor:        ^c.char,
}

StorageObjectWrite :: struct {
    collection:       cstring,
    key:              cstring,
    value:            cstring,
    version:          cstring,
    permission_read:  ^StoragePermissionRead,
    permission_write: ^StoragePermissionWrite,
}

StoragePermissionRead :: enum c.int {
    NoRead     = 0,
    OwnerRead  = 1,
    PublicRead = 2,
}

StoragePermissionWrite :: enum c.int {
    NoWrite    = 0,
    OwnerWrite = 1,
}

Tournament :: struct {
    id:            cstring,
    title:         cstring,
    description:   cstring,
    category:      c.uint32_t,
    sort_order:    c.uint32_t,
    size:          c.uint32_t,
    max_size:      c.uint32_t,
    max_num_score: c.uint32_t,
    can_enter:     bool,
    create_time:   Timestamp,
    start_time:    Timestamp,
    end_time:      Timestamp,
    end_active:    c.uint32_t,
    next_reset:    c.uint32_t,
    duration:      c.uint32_t,
    start_active:  c.uint32_t,
    metadata:      cstring,
}

TournamentList :: struct {
    tournaments:       ^Tournament,
    tournaments_count: c.uint16_t,
    cursor:            ^c.char,
}

TournamentRecordList :: struct {
    records:             ^Group,
    records_count:       c.uint16_t,
    owner_records:       ^Group,
    owner_records_count: c.uint16_t,
    next:                ^c.char,
    prev:                ^c.char,
}

User :: struct {
    id:             cstring,
    username:       cstring,
    display_name:   cstring,
    avatar_url:     cstring,
    lang:           cstring,
    location:       cstring,
    time_zone:      cstring,
    metadata:       cstring,
    facebook_id:    cstring,
    google_id:      cstring,
    game_center_id: cstring,
    apple_id:       cstring,
    stream_id:      cstring,
    online:         bool,
    edge_count:     c.int32_t,
    created_at:     Timestamp,
    updated_at:     Timestamp,
}

UserGroup :: struct {
    group: Group,
    state: UserGroupState,
}

UserGroupList :: struct {
    user_groups:       ^UserGroup,
    user_groups_count: c.uint16_t,
    cursor:            ^c.char,
}

Users :: struct {
    users:       ^User,
    users_count: c.uint16_t,
}
