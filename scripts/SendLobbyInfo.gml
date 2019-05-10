// Arg0 = target. Arg1 = player-socket list. Arg2 = player instance map
// Send all relevant player data to client Lobby objects
var list = argument1;
var map = argument2;

var buff = buffer_create(256, buffer_grow, 1);
buffer_seek(buff, buffer_seek_start, 0);

// Packet Type
buffer_write(buff, buffer_s16, CMD_LOBBY);

// Content
buffer_write(buff, buffer_s16, ds_list_size(list));  // Current player count
for (var i=0; i<ds_list_size(list); i++) {
    // Player name
    var name = ds_map_find_value(map, argulist[|i]);
    buffer_write(buff, buffer_string, name);
}

// Send
network_send_packet(argument0, buff, buffer_tell(buff));

// Clean-up
buffer_delete(buff);
