function ok = send_modify_address_list(n, addresses)
    global START STOP
    global MODIFY_ADDRESS_LIST
    global SOCKET
    data = zeros(n*8,1);
    k = 1;
    for i = 1:n
        for j = 1:8
            data(k) = addresses(i,j); 
            k = k+1;
        end
    end
    msg = [START; MODIFY_ADDRESS_LIST; 0; (n*8+1); n; data; 0; STOP];
    fwrite(SOCKET,msg); 
    msg_rcv = read_msg(SOCKET);
    ok = receive_sack(msg_rcv);
end
