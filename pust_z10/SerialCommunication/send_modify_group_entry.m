function ok = send_modify_group_entry(eid, gid, value)
    global START STOP
    global MODIFY_GROUP_ENTRY
    global SOCKET
    msg = [START; MODIFY_GROUP_ENTRY; 0; 4; eid; gid; dec2int16a(value); 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    ok = receive_sack(msg_rcv);
end
