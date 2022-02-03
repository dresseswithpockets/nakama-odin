package nakama

import c "core:c/libc"

when ODIN_OS == "windows" {foreign import lib "windows/nakama.lib"}
when ODIN_OS == "linux" {foreign import lib "linux/nakama.lib"}
when ODIN_OS == "darwin" {foreign import lib "macos/nakama.lib"}

@(default_calling_convention = "c")
foreign lib {
    // get nakama sdk version
    @(link_name = "getNakamaSdkVersion")
    get_nakama_sdk_version :: proc() -> cstring ---

    /*
     * Error codes
     */
    @(link_name = "NErrorCode_toString")
    error_code_to_string :: proc(code: ErrorCode) -> cstring ---
    @(link_name = "NError_toString")
    error_to_string :: proc(error: ^Error) -> cstring ---

    /*
     * String map
     */
    @(link_name = "NStringMap_create")
    string_map_create :: proc() -> StringMap ---
    @(link_name = "NStringMap_setValue")
    string_map_set_value :: proc(smap: StringMap, key, value: cstring) ---
    @(link_name = "NStringMap_getValue")
    string_map_get_value :: proc(smap: StringMap, key: cstring) -> cstring ---
    @(link_name = "NStringMap_getKeys")
    string_map_get_keys :: proc(smap: StringMap, keys: ^cstring) ---
    @(link_name = "NStringMap_getSize")
    string_map_get_size :: proc(smap: StringMap) -> c.uint16_t ---
    @(link_name = "NStringMap_destroy")
    string_map_destroy :: proc(smap: StringMap) ---

    /*
     * String:Double map
     */
    @(link_name = "NStringDoubleMap_create")
    double_map_create :: proc() -> StringDoubleMap ---
    @(link_name = "NStringDoubleMap_setValue")
    double_map_set_value :: proc(smap: StringDoubleMap, key, value: c.double) ---
    @(link_name = "NStringDoubleMap_getValue")
    double_map_get_value :: proc(smap: StringDoubleMap, key: cstring) -> c.double ---
    @(link_name = "NStringDoubleMap_getKeys")
    double_map_get_keys :: proc(smap: StringDoubleMap, keys: ^cstring) ---
    @(link_name = "NStringDoubleMap_getSize")
    double_map_get_size :: proc(smap: StringDoubleMap) -> c.uint16_t ---
    @(link_name = "NStringDoubleMap_destroy")
    double_map_destroy :: proc(smap: StringDoubleMap) ---

    /*
     * Timestamp
     */
    @(link_name = "getUnixTimestampMs")
    get_unix_timestamp_ms :: proc() -> Timestamp ---

    /*
     * Client factory
     */
    @(link_name = "createDefaultNakamaClient")
    create_default_nakama_client :: proc(parameters: ^ClientParameters) -> Client ---
    @(link_name = "createGrpcNakamaClient")
    create_grpc_nakama_client :: proc(parameters: ^ClientParameters) -> Client ---
    @(link_name = "createRestNakamaClient")
    create_rest_nakama_client :: proc(parameters: ^ClientParameters) -> Client ---
    @(link_name = "destroyNakamaClient")
    destroy_nakama_client :: proc(client: Client) ---

    /*
     * Session
     */
    @(link_name = "NSession_getAuthToken")
    session_get_auth_token :: proc(session: Session) -> cstring ---
    @(link_name = "NSession_isCreated")
    session_is_created :: proc(session: Session) -> bool ---
    @(link_name = "NSession_getUsername")
    session_get_username :: proc(session: Session) -> cstring ---
    @(link_name = "NSession_getUserId")
    session_get_user_id :: proc(session: Session) -> cstring ---
    @(link_name = "NSession_getCreateTime")
    session_get_create_time :: proc(session: Session) -> Timestamp ---
    @(link_name = "NSession_getExpireTime")
    session_get_expire_time :: proc(session: Session) -> Timestamp ---
    @(link_name = "NSession_isExpired")
    session_is_expired :: proc(session: Session) -> bool ---
    @(link_name = "NSession_isExpiredByTime")
    session_is_expired_by_time :: proc(session: Session, now: Timestamp) -> bool ---
    @(link_name = "NSession_getVariables")
    session_get_variables :: proc(session: Session) -> StringMap ---
    @(link_name = "NSession_getVariable")
    session_get_variable :: proc(session: Session, name: cstring) -> cstring ---
    @(link_name = "NSession_destroy")
    session_destroy :: proc(session: Session) ---
    @(link_name = "restoreNakamaSession")
    restore_nakama_session :: proc(token: cstring) -> Session ---

    /*
     * Client
     */

    // Set default error callback
    //
    // Will be called if a request fails and no error callback was set for the request.
    @(link_name = "NClient_setErrorCallback")
    set_error_callback :: proc(client: Client, error_callback: ClientDefaultErrorCallback) ---
    @(link_name = "NClient_setUserData")
    set_user_data :: proc(client: Client, user_data: rawptr) ---
    @(link_name = "NClient_getUserData")
    get_user_data :: proc(client: Client) -> rawptr ---
    @(link_name = "NClient_disconnect")
    disconnect :: proc(client: Client) ---
    @(link_name = "NClient_tick")
    tick :: proc(client: Client) ---

    @(link_name = "NClient_createRtClient")
    create_realtime_client_simple :: proc(client: Client, port: c.int32_t) -> RtClient ---
    @(link_name = "NClient_createRtClientEx")
    create_realtime_client_ex :: proc(
        client: Client,
        parameters: ^RtClientParameters,
    ) -> RtClient ---

    @(link_name = "NClient_authenticateDevice")
    authenticate_device :: proc(
        client: Client,
        id,
        username: cstring,
        create: bool,
        vars: StringMap,
        data: ClientReqData,
        success: SessionCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_authenticateEmail")
    authenticate_email :: proc(
        client: Client,
        email,
        password,
        username: cstring,
        create: bool,
        vars: StringMap,
        data: ClientReqData,
        success: SessionCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_authenticateFacebook")
    authenticate_facebook :: proc(
        client: Client,
        token,
        username: cstring,
        create: bool,
        vars: StringMap,
        data: ClientReqData,
        success: SessionCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_authenticateGoogle")
    authenticate_google :: proc(
        client: Client,
        token,
        username: cstring,
        create: bool,
        vars: StringMap,
        data: ClientReqData,
        success: SessionCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_authenticateGameCenter")
    authenticate_game_center :: proc(
        client: Client,
        player_id,
        bundle_id: cstring,
        timestamp_s: Timestamp,
        salt,
        signature,
        public_key_url,
        username: cstring,
        create: bool,
        vars: StringMap,
        data: ClientReqData,
        success: SessionCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_authenticateApple")
    authenticate_apple :: proc(
        client: Client,
        token,
        username: cstring,
        create: bool,
        vars: StringMap,
        data: ClientReqData,
        success: SessionCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_authenticateCustom")
    authenticate_custom :: proc(
        client: Client,
        id,
        username: cstring,
        create: bool,
        vars: StringMap,
        data: ClientReqData,
        success: SessionCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_authenticateSteam")
    authenticate_steam :: proc(
        client: Client,
        token,
        username: cstring,
        create: bool,
        vars: StringMap,
        data: ClientReqData,
        success: SessionCallback,
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_linkFacebook")
    link_facebook :: proc(
        client: Client,
        session: Session,
        token: cstring,
        import_friends: bool,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_linkEmail")
    link_email :: proc(
        client: Client,
        session: Session,
        email,
        password: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_linkDevice")
    link_device :: proc(
        client: Client,
        session: Session,
        id: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_linkGoogle")
    link_google :: proc(
        client: Client,
        session: Session,
        token: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_linkGameCenter")
    link_game_center :: proc(
        client: Client,
        session: Session,
        player_id,
        bundle_id: cstring,
        timestamp_s: Timestamp,
        salt,
        signature,
        public_key_url: cstring,
        import_friends: bool,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_linkApple")
    link_apple :: proc(
        client: Client,
        session: Session,
        token: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_linkSteam")
    link_steam :: proc(
        client: Client,
        session: Session,
        token: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_linkCustom")
    link_custom :: proc(
        client: Client,
        session: Session,
        token: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_unlinkFacebook")
    unlink_facebook :: proc(
        client: Client,
        session: Session,
        token: cstring,
        import_friends: bool,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_unlinkEmail")
    unlink_email :: proc(
        client: Client,
        session: Session,
        email,
        password: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_unlinkDevice")
    unlink_device :: proc(
        client: Client,
        session: Session,
        id: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_unlinkGoogle")
    unlink_google :: proc(
        client: Client,
        session: Session,
        token: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_unlinkGameCenter")
    unlink_game_center :: proc(
        client: Client,
        session: Session,
        player_id,
        bundle_id: cstring,
        timestamp_s: Timestamp,
        salt,
        signature,
        public_key_url: cstring,
        import_friends: bool,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_unlinkApple")
    unlink_apple :: proc(
        client: Client,
        session: Session,
        token: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_unlinkSteam")
    unlink_steam :: proc(
        client: Client,
        session: Session,
        token: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_unlinkCustom")
    unlink_custom :: proc(
        client: Client,
        session: Session,
        token: cstring,
        data: ClientReqData,
        success: LinkSuccessCallback,
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_importFacebookFriends")
    import_facebook_friends :: proc(
        client: Client,
        token: cstring,
        reset: bool,
        vars: StringMap,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_getAccount")
    get_account :: proc(
        client: Client,
        session: Session,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: cstring),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_updateAccount")
    update_account :: proc(
        client: Client,
        session: Session,
        username,
        display_name,
        avatar_url,
        lang_tag,
        location,
        timezone: cstring,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_getUsers")
    get_users :: proc(
        client: Client,
        session: Session,
        ids: ^cstring,
        ids_count: c.uint16_t,
        usernames: ^cstring,
        usernames_count: c.uint16_t,
        facebook_ids: ^cstring,
        facebook_ids_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^Users),
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_addFriends")
    add_friends :: proc(
        client: Client,
        session: Session,
        ids: ^cstring,
        ids_count: c.uint16_t,
        usernames: ^cstring,
        usernames_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_deleteFriends")
    delete_friends :: proc(
        client: Client,
        session: Session,
        ids: ^cstring,
        ids_count: c.uint16_t,
        usernames: ^cstring,
        usernames_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_blockFriends")
    block_friends :: proc(
        client: Client,
        session: Session,
        ids: ^cstring,
        ids_count: c.uint16_t,
        usernames: ^cstring,
        usernames_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_listFriends")
    list_friends :: proc(
        client: Client,
        session: Session,
        limit: ^c.int32_t,
        state: ^FriendState,
        cursor: ^c.char,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^FriendList),
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_createGroup")
    create_group :: proc(
        client: Client,
        session: Session,
        name,
        description,
        avatar_url,
        lang_tag: cstring,
        open: bool,
        max_count: ^c.int32_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^Group),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_deleteGroup")
    delete_group :: proc(
        client: Client,
        session: Session,
        id: cstring,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_addGroupUsers")
    add_group_users :: proc(
        client: Client,
        session: Session,
        id: cstring,
        user_ids: ^cstring,
        ids_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_listGroupUsers")
    list_group_users :: proc(
        client: Client,
        session: Session,
        id: cstring,
        limit: ^c.int32_t,
        state: ^FriendState,
        cursor: ^c.char,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^GroupUserList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_kickGroupUsers")
    kick_group_users :: proc(
        client: Client,
        session: Session,
        id: cstring,
        user_uds: ^cstring,
        ids_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_joinGroup")
    join_group :: proc(
        client: Client,
        session: Session,
        id: cstring,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_leaveGroup")
    leave_group :: proc(
        client: Client,
        session: Session,
        id: cstring,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_listGroups")
    list_groups :: proc(
        client: Client,
        session: Session,
        name: cstring,
        limit: ^c.int32_t,
        cursor: ^c.char,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^GroupList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_listOwnUserGroups")
    list_own_user_groups :: proc(
        client: Client,
        session: Session,
        limit: ^c.int32_t,
        state: ^FriendState,
        cursor: ^c.char,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^UserGroupList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_listUserGroups")
    list_user_groups :: proc(
        client: Client,
        session: Session,
        user_id: cstring,
        limit: ^c.int32_t,
        state: ^FriendState,
        cursor: ^c.char,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^UserGroupList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_promoteGroupUsers")
    promote_group_users :: proc(
        client: Client,
        session: Session,
        id: cstring,
        user_ids: ^cstring,
        user_ids_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_demoteGroupUsers")
    demote_group_users :: proc(
        client: Client,
        session: Session,
        id: cstring,
        user_ids: ^cstring,
        user_ids_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_updateGroup")
    update_group :: proc(
        client: Client,
        session: Session,
        id,
        name,
        description,
        avatar_url,
        lang_tag: cstring,
        open: ^bool,
        max_count: ^c.int32_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_listLeaderboardRecords")
    list_leaderboard_records :: proc(
        client: Client,
        session: Session,
        id: cstring,
        owner_ids: ^cstring,
        owner_ids_count: c.uint16_t,
        limit: c.int32_t,
        cursor: ^c.char,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^LeaderboardRecordList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_listLeaderboardRecordsAroundOwner")
    list_leaderboard_records_around_owner :: proc(
        client: Client,
        session: Session,
        id: cstring,
        owner_id: cstring,
        limit: c.int32_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^LeaderboardRecordList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_writeLeaderboardRecord")
    write_leaderboard_record :: proc(
        client: Client,
        session: Session,
        id: cstring,
        score: c.int64_t,
        subscore: ^c.int64_t,
        metadata: cstring,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^LeaderboardRecord),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_writeTournamentRecord")
    write_tournament_record :: proc(
        client: Client,
        session: Session,
        id: cstring,
        score: c.int64_t,
        subscore: ^c.int64_t,
        metadata: cstring,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^LeaderboardRecord),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_deleteLeaderboardRecord")
    delete_leaderboard_record :: proc(
        client: Client,
        session: Session,
        id: cstring,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_listMatches")
    list_matches :: proc(
        client: Client,
        session: Session,
        min_size,
        max_size,
        limit: c.int32_t,
        label: cstring,
        authoritative: bool,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^MatchList),
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_listNotifications")
    list_notifications :: proc(
        client: Client,
        session: Session,
        limit: c.int32_t,
        cacheable_cursor: ^c.char,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^NotificationList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_deleteNotifications")
    delete_notifications :: proc(
        client: Client,
        session: Session,
        ids: ^cstring,
        ids_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_listChannelMessage")
    list_channel_messages :: proc(
        client: Client,
        session: Session,
        channel_id: cstring,
        limit: c.int32_t,
        cursor: ^c.char,
        forward: bool,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^ChannelMessageList),
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_listTournaments")
    list_tournaments :: proc(
        client: Client,
        session: Session,
        cat_start,
        cat_end,
        start_time,
        end_time: ^c.uint32_t,
        limit: c.int32_t,
        cursor: ^c.char,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^TournamentList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_listTournamentRecords")
    list_tournament_records :: proc(
        client: Client,
        session: Session,
        id: cstring,
        limit: c.int32_t,
        cursor: ^c.char,
        owner_ids: ^cstring,
        owner_ids_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^TournamentRecordList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_listTournamentRecordsAroundOwner")
    list_tournament_records_around_owner :: proc(
        client: Client,
        session: Session,
        id,
        owner_id: cstring,
        limit: c.int32_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^TournamentRecordList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_joinTournament")
    join_tournament :: proc(
        client: Client,
        session: Session,
        id: cstring,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_listStorageObjects")
    list_storage_objects :: proc(
        client: Client,
        session: Session,
        collection: cstring,
        limit: c.int32_t,
        cursor: ^c.char,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^StorageObjectList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_listUsersStorageObjects")
    list_users_storage_objects :: proc(
        client: Client,
        session: Session,
        collection,
        user_id: cstring,
        limit: c.int32_t,
        cursor: ^c.char,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^StorageObjectList),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_writeStorageObjects")
    write_storage_objects :: proc(
        client: Client,
        session: Session,
        objects: ^StorageObjectWrite,
        objects_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^StorageObjectAck, _: c.uint16_t),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_readStorageObjects")
    read_storage_objects :: proc(
        client: Client,
        session: Session,
        object_ids: ^StorageObjectId,
        object_ids_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^StorageObject, _: c.uint16_t),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_deleteStorageObjects")
    delete_storage_objects :: proc(
        client: Client,
        session: Session,
        object_ids: ^StorageObjectId,
        object_ids_count: c.uint16_t,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData),
        error: ClientErrorCallback,
    ) ---

    @(link_name = "NClient_rpc")
    rpc :: proc(
        client: Client,
        session: Session,
        id,
        payload: cstring,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^Rpc),
        error: ClientErrorCallback,
    ) ---
    @(link_name = "NClient_rpc_with_http_key")
    rpc_with_http_key :: proc(
        client: Client,
        session: Session,
        http_key,
        id,
        payload: cstring,
        data: ClientReqData,
        success: proc(_: Client, _: ClientReqData, _: ^Rpc),
        error: ClientErrorCallback,
    ) ---
}

create_realtime_client :: proc {
    create_realtime_client_simple,
    create_realtime_client_ex,
}
