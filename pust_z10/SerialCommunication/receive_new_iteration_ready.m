function ok = receive_new_iteration_ready(msg)
    global NEW_ITERATION_READY
    if(msg.id == NEW_ITERATION_READY)
        ok = true;
    else
        ok = false;
    end
end
