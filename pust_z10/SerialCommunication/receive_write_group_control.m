function [ok, gid, control] = receive_write_group_control(msg)
    global WRITE_GROUP_CONTROL
    if(msg.id == WRITE_GROUP_CONTROL)
        gid = msg.data(1);
        control = int16a2dec(msg.data(2:3));
        ok = true;
    else
        ok = false;
    end
end
