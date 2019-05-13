var amt = buffer_read(n_buff, buffer_s16);
var cards = ds_list_create();

for (var i=0; i<amt; i++) {
    var playerID = buffer_read(n_buff, buffer_s16);
    var name = buffer_read(n_buff, buffer_string);
    var playerScore = buffer_read(n_buff, buffer_s16);
    var ready = buffer_read(n_buff, buffer_s16);
    var cardCount = buffer_read(n_buff, buffer_s16);
    for (var o=0; o<cardCount; o++) {
        // Read cards
        ds_list_add(cards,buffer_read(n_buff, buffer_s8));
    }
    
    a = 0;
    // Check if our list has this instance already. If not, then make a new one
    var exists = 0;
    for (var o=0; o<ds_list_size(players); o++) {
        if (players[|o].sockID == playerID) {
            exists = 1;
            show_debug_message('this one exists')
            a = players[|o];
        }
    }
    if (exists == 0) {
        show_debug_message('doesnt exist yet')
        a = instance_create(0,0,obj_player);
        a.sockID = playerID;
        ds_list_add(players, a);
    }
    // Apply updates
    a.name = name;
    a.currentScore = playerScore;
    a.ready = ready;
    
    // Apply card updates
    ds_list_clear(a.cards);
    ds_list_copy(a.cards,cards);
}
ds_list_destroy(cards);
