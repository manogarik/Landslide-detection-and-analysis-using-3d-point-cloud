function y = seacolor(n)
%SEACOLOR Sea colormap adapted from NGDC ETOPO1
%
%	Author: Francois Beauducel <beauducel@ipgp.fr>
J = [ ...
    0.0392         0    0.4745
    0.1020         0    0.5373
    0.1020         0    0.5373
    0.1490         0    0.5961
    0.1490         0    0.5961
    0.1059    0.0118    0.6510
    0.1059    0.0118    0.6510
    0.0627    0.0235    0.7059
    0.0627    0.0235    0.7059
    0.0196    0.0353    0.7569
    0.0196    0.0353    0.7569
         0    0.0549    0.7961
         0    0.0549    0.7961
         0    0.0863    0.8235
         0    0.0863    0.8235
         0    0.1176    0.8471
         0    0.1176    0.8471
         0    0.1529    0.8745
         0    0.1529    0.8745
    0.0471    0.2667    0.9059
    0.0471    0.2667    0.9059
    0.1020    0.4000    0.9412
    0.1020    0.4000    0.9412
    0.0745    0.4588    0.9569
    0.0745    0.4588    0.9569
    0.0549    0.5216    0.9765
    0.0549    0.5216    0.9765
    0.0824    0.6196    0.9882
    0.0824    0.6196    0.9882
    0.1176    0.6980    1.0000
    0.1176    0.6980    1.0000
    0.1686    0.7294    1.0000
    0.1686    0.7294    1.0000
    0.2157    0.7569    1.0000
    0.2157    0.7569    1.0000
    0.2549    0.7843    1.0000
    0.2549    0.7843    1.0000
    0.3098    0.8235    1.0000
    0.3098    0.8235    1.0000
    0.3686    0.8745    1.0000
    0.3686    0.8745    1.0000
    0.5412    0.8902    1.0000
    0.5412    0.8902    1.0000
    0.7373    0.9020    1.0000
];
l = length(J);
if nargin < 1
	n = 256;
end
y = interp1(1:l,J,linspace(1,l,n),'*linear');