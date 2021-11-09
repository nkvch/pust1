function [ok, eid_, gid_, weight_] = send_read_group_entry(eid)
    global START STOP
    global READ_GROUP_ENTRY
    global SOCKET
    msg = [START; READ_GROUP_ENTRY; 0; 1; eid; 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    [ok, eid_, gid_, weight_] = receive_give_group_entry(msg_rcv);
end
