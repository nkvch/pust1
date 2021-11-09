function ok = receive_clear_group_table(msg)
    global CLEAR_GROUP_TABLE
    if(msg.id == CLEAR_GROUP_TABLE)
        ok = true;
    else
        ok = false;
    end
end
