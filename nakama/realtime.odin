package nakama

import c "core:c/libc"

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

    @(link_name = "NRtClient_tick")
    rt_tick :: proc(client: RtClient) ---

    @(link_name = "NRtClient_setUserData")
    rt_set_user_data :: proc(client: RtClient, user_data: rawptr) ---

    @(link_name = "NRtClient_getUserData")
    rt_get_user_data :: proc(client: RtClient) -> rawptr ---

    @(link_name = "NRtClient_connect")
    rt_connect :: proc(client: RtClient, session: Session, create_status: bool, protocol: RtClientProtocol) ---

    @(link_name = "NRtClient_isConnected")
    rt_is_connected :: proc(client: RtClient) -> bool ---

    @(link_name = "NRtClient_disconnect")
    rt_disconnect :: proc(client: RtClient) ---

    @(link_name = "NRtClient_joinChat")
    rt_join_chat :: proc(client: RtClient, target: cstring, type: ChannelType, persistence, hidden: bool, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^Channel), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_leaveChat")
    rt_leave_chat :: proc(client: RtClient, channel_id: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_writeChatMessage")
    rt_write_chat_message :: proc(client: RtClient, channel_id, content: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^ChannelMessageAck), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_updateChatMessage")
    rt_update_chat_message :: proc(client: RtClient, channel_id, message_id, content: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^ChannelMessageAck), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_removeChatMessage")
    rt_remove_chat_message :: proc(client: RtClient, channel_id, message_id: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^ChannelMessageAck), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_createMatch")
    rt_create_match :: proc(client: RtClient, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^Match), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_joinMatch")
    rt_join_match :: proc(client: RtClient, match_id: cstring, metadata: StringMap, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^Match), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_joinMatchByToken")
    rt_join_match_by_token :: proc(client: RtClient, token: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^Match), error: RtClientErrorCallback) ---
    
    @(link_name = "NRtClient_leaveMatch")
    rt_leave_match :: proc(client: RtClient, match_id: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^Match), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_addMatchmaker")
    rt_add_matchmaker :: proc(client: RtClient, min_count, max_count: c.int32_t, query: cstring, string_props: StringMap, numeric_props: StringDoubleMap, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^MatchmakerTicket), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_removeMatchmaker")
    rt_remove_matchmaker :: proc(client: RtClient, ticket: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_sendMatchData")
    rt_send_match_data :: proc(client: RtClient, match_id: cstring, op: c.int64_t, data: ^Bytes, presences: ^UserPresence, presences_count: c.uint16_t) ---

    @(link_name = "NRtClient_followUsers")
    rt_follow_users :: proc(client: RtClient, user_ids: ^cstring, user_ids_count: c.uint16_t, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^Status), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_unfollowUsers")
    rt_unfollow_users :: proc(client: RtClient, user_ids: ^cstring, user_ids_count: c.uint16_t, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---
    
    @(link_name = "NRtClient_updateStatus")
    rt_update_status :: proc(client: RtClient, status: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_acceptPartyMember")
    rt_accept_party_member :: proc(client: RtClient, party_id: cstring, presence: UserPresence, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_addMatchmakerParty")
    rt_add_matchmaker_party :: proc(client: RtClient, party_id, query: cstring, min_count, max_count: c.int32_t, string_props: StringMap, numeric_props: StringDoubleMap, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^PartyMatchmakerTicket), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_closeParty")
    rt_close_party :: proc(client: RtClient, party_id: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_createParty")
    rt_create_party :: proc(client: RtClient, open: bool, max_size: c.int32_t, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^Party), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_joinParty")
    rt_join_party :: proc(client: RtClient, party_id: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_leaveParty")
    rt_leave_party :: proc(client: RtClient, party_id: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_listPartyJoinRequests")
    rt_list_party_join_requests :: proc(client: RtClient, party_id: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^PartyJoinRequest), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_promotePartyMember")
    rt_promote_party_member :: proc(client: RtClient, party_id: cstring, member: UserPresence, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_removeMatchmakerParty")
    rt_remove_matchmaker_party :: proc(client: RtClient, party_id, ticket: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_removePartyMember")
    rt_remove_party_member :: proc(client: RtClient, party_id: cstring, presence: UserPresence, data: RtClientReqData, success: proc(RtClient, RtClientReqData), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_sendPartyData")
    rt_send_party_data :: proc(client: RtClient, party_id: cstring, op: c.uint16_t, data: ^Bytes) ---

    @(link_name = "NRtClient_rpc")
    rt_rpc :: proc(client: RtClient, id, payload: cstring, data: RtClientReqData, success: proc(RtClient, RtClientReqData, ^Rpc), error: RtClientErrorCallback) ---

    @(link_name = "NRtClient_setConnectCallbak")
    rt_set_connect_callback :: proc(client: RtClient, callback: proc(RtClient)) ---

    @(link_name = "NRtClient_setDisconnectCallback")
    rt_set_disconnect_callback :: proc(client: RtClient, callback: proc(RtClient, ^RtClientDisconnectInfo)) ---

    @(link_name = "NRtClient_setErrorCallback")
    rt_set_error_callback :: proc(client: RtClient, callback: proc(RtClient, ^RtError)) ---

    @(link_name = "NRtClient_setChannelMessageCallback")
    rt_set_channel_message_callback :: proc(client: RtClient, callback: proc(RtClient, ^ChannelMessage)) ---

    @(link_name = "NRtClient_setChannelPresenceCallback")
    rt_set_channel_presence_callback :: proc(client: RtClient, callback: proc(RtClient, ^ChannelPresenceEvent)) ---

    @(link_name = "NRtClient_setMatchmakerMatchedCallback")
    rt_set_matchmaker_matched_callback :: proc(client: RtClient, callback: proc(RtClient, ^MatchmakerMatched)) ---

    @(link_name = "NRtClient_setMatchDataCallback")
    rt_set_match_data_callback :: proc(client: RtClient, callback: proc(RtClient, ^MatchData)) ---

    @(link_name = "NRtClient_setMatchPresenceCallback")
    rt_set_match_presence_callback :: proc(client: RtClient, callback: proc(RtClient, ^MatchPresenceEvent)) ---

    @(link_name = "NRtClient_setNotificationsCallback")
    rt_set_notifications_callback :: proc(client: RtClient, callback: proc(RtClient, ^NotificationList)) ---

    @(link_name = "NRtClient_setPartyCallback")
    rt_set_party :: proc(client: RtClient, callback: proc(RtClient, ^Party)) ---

    @(link_name = "NRtClient_setPartyCloseCallback")
    rt_set_party_close_callback :: proc(client: RtClient callback: proc(RtClient, ^PartyClose)) ---

    @(link_name = "NRtClient_setPartyDataCallback")
    rt_set_party_data_callback :: proc(client: RtClient, callback: proc(RtClient, ^PartyData)) ---

    @(link_name = "NRtClient_setPartyJoinRequestCallback")
    rt_set_party_join_request_callback :: proc(client: RtClient, callback: proc(RtClient, ^PartyJoinRequest)) ---

    @(link_name = "NRtClient_setPartyLeaderCallback")
    rt_set_party_leader_callback :: proc(client: RtClient, callback: proc(RtClient, ^PartyLeader)) ---

    @(link_name = "NRtClient_setPartyMatchmakerTicketCallback")
    rt_set_party_matchmaker_ticket_callback :: proc(client: RtClient, callback: proc(RtClient, ^PartyMatchmakerTicket)) ---

    @(link_name = "NRtClient_setPartyPresenceCallback")
    rt_set_party_presence_callback :: proc(client: RtClient, callback: proc(RtClient, ^PartyPresenceEvent)) ---

    @(link_name = "NRtClient_setStatusPresenceCallback")
    rt_set_status_presence_callback :: proc(client: RtClient, callback: proc(RtClient, ^StatusPresenceEvent)) ---

    @(link_name = "NRtClient_setStreamPresenceCallback")
    rt_set_stream_presence_callback :: proc(client: RtClient, callback: proc(RtClient, ^StreamPresenceEvent)) ---

    @(link_name = "NRtClient_setStreamDataCallback")
    rt_set_stream_data_callback :: proc(client: RtClient, callback: proc(RtClient, ^StreamData)) ---

    @(link_name = "NRtClient_destroy")
    rt_destroy :: proc(client: RtClient) ---
}
