function a = dec2int16a(x)
    y = dec2int16(x);
    a = zeros(2,1);
    a(1) = bitshift(y,-8);
    a(2) = bitand(y,hex2dec('ff'));
end
