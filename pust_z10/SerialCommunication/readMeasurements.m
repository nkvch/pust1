function m = readMeasurements(ids)
        m = zeros(size(ids));
        tmp = 1;
        [ok, ~, measurements] = send_read_measurements();
        for i = ids
            m(tmp) = measurements(i);
            tmp = tmp+1;
        end
end