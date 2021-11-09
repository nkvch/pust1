function ok = sendControls(ids, values)
    if(~isvector(ids) || ~isvector(values))
        error('Arguments of this function must be of type vector.');
    end
    
    new_order = [1,3,2,0,4,5]; % Change in numeration for users' convenience
    ok = 1;
    for i = 1:length(ids)
        ok = min(ok,send_write_group_control(new_order(ids(i)), uint16(10*values(i))));
    end
end