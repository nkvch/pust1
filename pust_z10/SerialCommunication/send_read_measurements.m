function [ok, size, measurements] = send_read_measurements()
    global START STOP
    global READ_MEASUREMENTS
    global SOCKET
    msg = [START; READ_MEASUREMENTS; 0; 0; 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    [ok, size, measurements] = receive_give_measurements(msg_rcv);
end
