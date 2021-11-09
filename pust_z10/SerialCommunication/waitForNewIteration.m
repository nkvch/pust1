function ok = waitForNewIteration()
    while(~send_wait_for_new_iteration())
    end
end