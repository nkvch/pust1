function ok = receive_wait_for_new_iteration(msg)
    global WAIT_FOR_NEW_ITERATION
    if(msg.id == WAIT_FOR_NEW_ITERATION)
        ok = true;
    else
        ok = false;
    end
end
