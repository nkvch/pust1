function [ok, size, addresses] = receive_modify_address_list(msg)
    global MODIFY_ADDRESS_LIST
    if(msg.id == MODIFY_ADDRESS_LIST)
        size = msg.data(1);
        addresses = zeros(size,8);
        for nr = 1:size
            addresses(nr,:) = msg.data((nr-1)*8+1+(1:8));
        end
        ok = true;
    else
        ok = false;
    end
end
