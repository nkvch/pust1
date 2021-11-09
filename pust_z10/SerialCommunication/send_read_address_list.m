function [ok, size, addresses] = send_read_address_list()
    global START STOP
    global READ_ADDRESS_LIST
    global SOCKET
    msg = [START; READ_ADDRESS_LIST; 0; 0; 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    [ok, size, addresses] = receive_give_address_list(msg_rcv);
end
