function ok = send_wait_for_new_iteration()
    global START STOP
    global WAIT_FOR_NEW_ITERATION
    global SOCKET
    msg = [START; WAIT_FOR_NEW_ITERATION; 0; 0; 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    ok = receive_new_iteration_ready(msg_rcv);
end
