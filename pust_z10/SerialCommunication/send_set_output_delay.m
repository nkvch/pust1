function ok = send_set_output_delay(eid, value)
    global START STOP
    global SET_OUTPUT_DELAY
    global SOCKET
    msg = [START; SET_OUTPUT_DELAY; 0; 2; eid; value; 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    ok = receive_sack(msg_rcv);
end
