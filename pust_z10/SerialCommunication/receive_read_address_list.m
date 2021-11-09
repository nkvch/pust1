function ok = receive_read_address_list(msg)
    global READ_ADDRESS_LIST 
    if(msg.id == READ_ADDRESS_LIST)
        ok = true;
    else
        ok = false;
    end
end
