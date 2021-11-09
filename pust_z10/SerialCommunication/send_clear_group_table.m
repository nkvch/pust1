function ok = send_clear_group_table()
    global START STOP
    global CLEAR_GROUP_TABLE
    global SOCKET
    msg = [START; CLEAR_GROUP_TABLE; 0; 0; 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    ok = receive_sack(msg_rcv);
end
