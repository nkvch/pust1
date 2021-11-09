function ok = send_write_group_control(gid, value)
    global START STOP
    global WRITE_GROUP_CONTROL
    global SOCKET
    msg = [START; WRITE_GROUP_CONTROL; 0; 3; gid; dec2int16a(value); 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    ok = receive_sack(msg_rcv);
end
