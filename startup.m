!synclient HorizTwoFingerScroll=0
% Turn off this warning "Warning: Image is too big to fit on screen; displaying at 33% "
% To set the warning state, you must first know the message identifier for the one warning you want to enable. 
% Query the last warning to acquire the identifier.  For example: 
% warnStruct = warning('query', 'last');
% msgid_integerCat = warnStruct.identifier
% msgid_integerCat =
%    MATLAB:concatenation:integerInteraction
warning('off', 'Images:initSize:adjustingMag');