var buff = buffer_create(256, buffer_grow, 1);
buffer_seek(buff, buffer_seek_start, 0);

// Packet Type
buffer_write(buff, buffer_s16, CMD_ROOM);

// Content
buffer_write(buff, buffer_string, argument1);

// Send
network_send_packet(argument0, buff, buffer_tell(buff));

// Clean-up
buffer_delete(buff);

