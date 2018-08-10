function lf = LFGraphDecoder(setA, S, W, gamma)
%LFGraphDecoder Reconstruct the light field from subset A and graph weights
%W
%   Usage: lf = LFGraphDecoder(setA, S, W, gamma);
%  
%   Input parameters
%      
%       setA    = light field structure, size N-by-M-by-D
%                   N, M number of views to be encoded
%                   D total number of pixels in each view
%                 setA only has values for N, M equal to sampling location
%                 defined in S and is 0 otherwise
%       S       = sampling matrix. Equal to 1 for sampling locations and 0
%                 otherwise
%       W    = graph weights (as obtained from LFGraphEncoder)
%       gamma = data fidelity parameter (default = 1e-8)
%
%   Output parameters
%       lf      = light field structure, size N-by-M-by-D
%                   N, M number of views to be encoded
%                   D total number of pixels in each view       
%
%   This function generates the light field structure from subset A and graph
%   weights, following sampling matrix S.

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

if nargin < 4
    gamma = 1e-8;
end
N = size(setA, 1);
M = size(setA, 2);
D = size(setA, 3);


G = gsp_2dgrid(N, M);
G = gsp_update_weights(G, W);
G = gsp_create_laplacian(G, 'combinatorial');
X = reshape(setA, N*M, D);

Y = (S + gamma*G.L)\X;

% clipping
Y(Y>1) = 1;
Y(Y<0) = 0;

lf = reshape(Y, [N M D]);
end
