for (var i=0; i<ds_list_size(sockets); i++) {
    var socket = ds_list_find_value(sockets, i);
    UpdatePlayers(socket, sockets, players);
}
