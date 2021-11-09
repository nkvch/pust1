function ok = receive_sack(msg)
    global SACK
    if(msg.id == SACK)
        ok = true;
    else
        ok = false;
    end
end
