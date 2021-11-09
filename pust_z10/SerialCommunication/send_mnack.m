function ok = send_mnack()
    global START STOP
    global MNACK
    global SOCKET
    msg = [START; MNACK; 0; 0; 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    ok = receive_sack(msg_rcv);
end
