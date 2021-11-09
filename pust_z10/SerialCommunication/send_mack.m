function ok = send_mack()
    global START STOP
    global MACK
    global SOCKET
    msg = [START; MACK; 0; 0; 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    ok = receive_sack(msg_rcv);
end
