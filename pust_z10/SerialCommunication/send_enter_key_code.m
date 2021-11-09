function ok = send_enter_key_code(key)
    global START STOP
    global ENTER_KEY_CODE
    global SOCKET
    msg = [START; ENTER_KEY_CODE; 0; 1; key; 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    ok = receive_sack(msg_rcv);
end
