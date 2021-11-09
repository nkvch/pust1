function [ok, eid, gid, weight] = receive_modify_group_entry(msg)
    global MODIFY_GROUP_ENTRY
    if(msg.id == MODIFY_GROUP_ENTRY)
        eid = msg.data(1);
        gid = msg.data(2);
        weight = int16a2dec(msg.data(3:4));
        ok = true;
    else
        ok = false;
    end
end
