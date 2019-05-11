// Arg0 = player-socket list. Arg1 = player instance map
// Send all relevant player data to client Lobby objects
var list = argument0;
var map = argument1;

var buff = buffer_create(16384, buffer_fixed, 1);
buffer_seek(buff, buffer_seek_start, 0);

// Packet Type
buffer_write(buff, buffer_s16, CMD_PLAYERS);

// Content
buffer_write(buff, buffer_s16, ds_list_size(list));  // Current player count
for (var i=0; i<ds_list_size(list); i++) {
    // Player name
    var inst = ds_map_find_value(map, list[|i]);
    buffer_write(buff, buffer_s16, list[|i]);   // SocketID
    buffer_write(buff, buffer_string, inst.name);  // Name
    buffer_write(buff, buffer_s16, inst.currentScore);  // Score
}

// Send to players
for (var i=0; i<ds_list_size(list); i++) {
    show_debug_message(network_send_packet(0, buff, buffer_tell(buff)));
}

// Clean-up
buffer_delete(buff);
