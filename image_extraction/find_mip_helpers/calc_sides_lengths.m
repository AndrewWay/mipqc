function[si,sj,sk,sl] = calc_sides_lengths(linei,linej,linek,linel)
    [si]=calc_side_length(linei,linek,linel);
    [sj]=calc_side_length(linej,linek,linel);
    [sk]=calc_side_length(linek,linei,linej);
    [sl]=calc_side_length(linel,linei,linej);    
end