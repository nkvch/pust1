function [ok, eid, gid, weight] = receive_give_group_entry(msg)
    global GIVE_GROUP_ENTRY
    if(msg.id == GIVE_GROUP_ENTRY)
        eid = msg.data(1);
        gid = msg.data(2);
        weight = int16a2dec(msg.data(3:4));
        ok = true;
    else
        eid = 0;
        gid = 0;
        weight = 0;
        ok = false;
    end
end
