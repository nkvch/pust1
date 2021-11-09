function [ok, eid] = receive_read_group_entry(msg)
    global READ_GROUP_ENTRY
    if(msg.id == READ_GROUP_ENTRY)
        eid = msg.data(1);
        ok = true;
    else
        ok = false;
    end
end
