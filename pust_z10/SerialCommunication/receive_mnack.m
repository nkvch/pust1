function ok = receive_mnack(msg)
    global MNACK
    if(msg.id == MNACK)
        ok = true;
    else
        ok = false;
    end
end
