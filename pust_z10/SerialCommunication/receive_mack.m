function ok = receive_mack(msg)
    global MACK
    if(msg.id == MACK)
        ok = true;
    else
        ok = false;
    end
end
