function ok = receive_snack(msg)
    global SNACK
    if(msg.id == SNACK)
        ok = true;
    else
        ok = false;
    end
end
