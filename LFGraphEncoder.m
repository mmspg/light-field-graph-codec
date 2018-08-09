function W = LFGraphEncoder(lf, theta, delta, prec)
%LFGraphEncoder Learn the graph weights for 4D light field structure
%   Usage: W = LFGraphEncoder(lf, theta, delta, prec);
%  
%   Input parameters
%       lf      = light field structure, size N-by-M-by-D
%                   N, M number of views to be encoded
%                   D total number of pixels in each view
%       theta   = sparsity parameter (default = 0.01)
%       delta   = scaling parameter (default = 1000)
%       prec    = precision of the graph weights (default = 1)
%
%   Output parameters
%       W = graph weights        
%
%   This function generates the graph weights to be used to reconstruct the
%   entire light field.

% Copyright (c) Irene Viola, Hermina Petric Maretic, Pascal Frossard, 
% Touradj Ebrahimi. Ecole Polytechnique Federale de Lausanne (EPFL).
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% If you use this software please kindly cite
%     I. Viola, H. Petric Maretic, P. Frossard, and T. Ebrahimi.
%     A graph learning approach for light field image compression
%     SPIE Optics + Photonics, Aug. 2018.

if nargin < 2
    theta = 0.01;
end

if nargin < 3
    delta = 1000;
end

if nargin < 4
    prec = 1;
end


N = size(lf, 1);
M = size(lf, 2);
D  = size(lf,3);
X = reshape(lf, N*M, D);
Z = gsp_distanz((X)').^2;


W = delta * gsp_learn_graph_log_degrees(theta * Z, 1, 1);

W(W<prec) = 0;

%   Optional: save the graph weights (uncomment to enable)
% 
% [Ws, d] = spdiags(triu(W));
% save('graphWeights.mat', 'Ws');
% fileID = fopen('graphIndices.bin','w');
% fwrite(fileID, d, 'uint8');
% fclose(fileID);

end