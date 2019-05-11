var buff = buffer_create(256, buffer_grow, 1);
buffer_seek(buff, buffer_seek_start, 0);

// Packet Type
buffer_write(buff, buffer_s16, CMD_BROADCAST);

// Content
buffer_write(buff, buffer_string, argument0);

// Send to all 
for (var i=0; i<ds_list_size(sockets); i++) {
    var socket = ds_list_find_value(sockets, i);
    network_send_packet(socket, buff, buffer_tell(buff));
}

// Clean-up
buffer_delete(buff);
