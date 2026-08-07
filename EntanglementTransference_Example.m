%% EntanglementTransference_Example.m
% 
% This MATLAB script is intended to accompany the work initially published
% by Patterson, Wang, and Mann in arxiv:2603.23601, title "Entanglement
% transference and non-inertial quantum reference frames."
%
% This code is meant to allow the interested reader to test the validity of
% Entanglement Transference for different choices of initial 3-qubit states.
% 
% This version computes the Entanglement Entropy (eE) and the Relative Entropy 
% of Subsystem Coherence (eC). 
% One could alternatively chose to use the Linear Entropy (lE) and the l2-Norm
% of Coherence (lC) as the entanglement and coherence quantifiers.
%
% This script makes extensive use of the QETLAB package developped by N, Johnston:
%   https://qetlab.com/Main_Page
% which requires us to specify its path:
addpath(genpath('/Applications/QETLAB-1.0'))
% Note that the path is computer-dependent.
%
% Author: Everett A. Patterson
% Date: February 13, 2026
% Last Updated: August 7, 2026


%% Outline
% (1) Define an initial 3-qubit pure state:
%       (i) the initial state in the paper,
%       (ii) a random 3-qubit state,
%       (iii) user-defined 3-qubit state
% (2) Assign Perspectives to the state
% (3) Compute the E,C 
%       (i) 3E, 
%       (ii) 2E, 
%       (iii) 2C, 
%       (iv) E+C

% Note: Only run/uncomment one of (1.i), (1.ii), and (1.iii)!



%% (1) Define an initial 3-qubit state
% Uncomment only one of sections (1.i), (1.ii), or (1.iii)

% (1.i) Define the initial 3-qubit state to be the pure state |phi_r> 
% found in Eq. (16) of the paper with variable radius 0<=r<=pi/4.
phi = @(r) (1/sqrt(2)) * [cos(r);0;0;sin(r);0;0;1;0];
% |phi> = 1/sqrt(2) * ( cos(r)|000> + sin(r)|011> + |110> ) 
% Define the radius. Required in order to use function later.
% Ensure that rr is in [0,pi/4].
rr = pi/8;
phi = phi(rr);
% Print the particular initial r and state phi
disp("The radius of the state ");
disp("   |phi> = 1/sqrt(2) * ( cos(r)|000> + sin(r)|011> + |110> ) ");
disp("is " + rr/pi + " pi.");


% % (1.ii) Define the initial 3-qubit state to be a random pure state.
% phiRandom = RandomStateVector(8);
% % Print the particular initial state phi
% disp("The initial state is was randomly chosen.");
% phi = phiRandom;


% (1,iii) Test the code for particular initial state
% Only define one of the following: 

% % Define the GHZ state
% % GHZ state = 1/sqrt(2) * (|000> + |111>)
% disp("The initial state is the GHZ state.")
% phi = GHZState(2,3);

% % Define the W-state for Q=3 qubits
% % W-state = 1/sqrt(3) * (|100>+|010>+|001>)
% disp("The initial state is the W state.")
% phi = WState(3);    

% % Generalized W-state with coefficients a, b, c
% disp("The initial state is a generalized W state.")
% a = 2+i; b =i; c=5;
% phi = WState(3,[a,b,c]/norm([a;b;c]));    

% % Define product state of 3-random qubits 
% disp("The initial state is a product state of 3 random qubits.")
% phi = kron(kron(RandomStateVector(2),RandomStateVector(2)),RandomStateVector(2));

% % Define random 3-rebit state:
% disp("The initial state is a random 3-rebit system.")
% phi = rand(8,1);
% phi = phi/norm(phi);

% % Define an 'Even' three-qubit state
% % Even-state = a|000> + d|011> + f|101> + g|110>
% disp("The initial state is an even state.")
% a = 2+i; d = i; f = -2; g = 3; 
% phi = [a;0;0;d;0;f;g;0];       
% phi = phi/norm([a;d;f;g]); % Renormalize

% % Define an 'Odd' three-qubit state
% % Even-state = b|001> + c|010> + e|100> + h|111>
% disp("The initial state is an odd state.")
% b = 2+i; c = i; e = -2; h = 3; 
% phi = [0;b;c;0;e;0;0;h];       
% phi = phi/norm([b;c;e;h]); % Renormalize

% % Define an 'extended' parity state
% disp("The initial state is an extended parity state.")
% b = 2+i; c = i; e = -2; h = 3; a=0; d=0; f=0; g=3;
% phi = [0;b;c;0;e;0;g;h];    % Define parity state + extra term   
% phi = phi/norm([a;b;c;d;e;f;g;h]); % Remove g or set g=0, when not using
% % The presence of the 'g' voids Entnaglement Transference, i,e, 
% % the conjecture that 3E = 2E + 2C.

% % Define a general 8-parameter state
% disp("The initial state is a 8-parameter state.")
% q=0.5;
% a = sqrt(0.5-q); b = sqrt(q); c = -sqrt(q); d = sqrt(0.5-q); e=sqrt(q); f=0; g=0; h=sqrt(q);
% phi = [a;b;c;d;e;f;g;h];    % Define totally general 3-q state   
% phi = phi/norm([a;b;c;d;e;f;g;h]); 


% Print the particular initial state phi.
% Leave this uncommented for all initial states.
disp("The initial 3-qubit pure state is: ");
disp( phi );




%% (2) Assign Perspectival states
% Assign the different perspectives

% Assign the perspective of A
phiA = [sqrt(abs(phi(1))^2+abs(phi(8))^2); sqrt(abs(phi(2))^2+abs(phi(7))^2); sqrt(abs(phi(3))^2+abs(phi(6))^2); sqrt(abs(phi(4))^2+abs(phi(5))^2)];       % Assign the perspective
disp("In the perspective of A:");
disp( phiA );

% Assign the perspective of R
phiR = [sqrt(abs(phi(1))^2+abs(phi(8))^2); sqrt(abs(phi(2))^2+abs(phi(7))^2); sqrt(abs(phi(4))^2+abs(phi(5))^2); sqrt(abs(phi(3))^2+abs(phi(6))^2)];      % Assign the perspective
disp("In the perspective of R: ");
disp( phiR );

% Assign the perspective of RA
phiAR = [sqrt(abs(phi(1))^2+abs(phi(8))^2); sqrt(abs(phi(3))^2+abs(phi(6))^2); sqrt(abs(phi(4))^2+abs(phi(5))^2); sqrt(abs(phi(2))^2+abs(phi(7))^2)];     % Assign the perspective
disp("In the perspective of AR: ");
disp( phiAR );



%% (3) Compute the Es and Cs for these systems.
% In this section, we compute various entanglement and coherence measures
% for our given state.

% Notation: 'PTn' stands for 'Partial Trace of system n'


% (3.i) Compute 3E -- the global entanglement entropy
% Rquires the 'global' state as input.

% 3E w.r.t. System 1 (Alice)
phiPT1 = PartialTrace(phi,1,[2,2,2]);  % This is a matrix. 
e3Ephi1vs23 = Entropy(phiPT1); 
disp("The 3E between A and R,AR is " + e3Ephi1vs23);

% 3E w.r.t. System 2 (Rob)
phiPT2 = PartialTrace(phi,2,[2,2,2]);
e3Ephi2vs13 = Entropy(phiPT2);
disp("The 3E between R and A,AR is " + e3Ephi2vs13);

% 3E w.r.t. System 3 (anti-Rob)
phiPT3 = PartialTrace(phi,3,[2,2,2]);
e3Ephi3vs12 = Entropy(phiPT3);
disp("The 3E between AR and A,R is " + e3Ephi3vs12);


% (3.ii) Compute 2E -- the perspectival entanglement entropy
% Requires a perspectival state as input.
% disp(" ");    % Adds a line break in the print outs.

% Compute the 2E between systems 2 and 3 (perspective of 1)
phiAPT3 = PartialTrace(phiA,2,[2,2]);    % This is a matrix.
e2EphiA = Entropy(phiAPT3);
% disp("The 2E in the perspective of A is " + e2EphiA);

% Compute the 2E between systems 1 and 3 (perspective of 2)
phiRPT3 = PartialTrace(phiR,2,[2,2]);
e2EphiR = Entropy(phiRPT3);
% disp("The 2E in the perspective of R is " + e2EphiR);

% Compute the 2E between systems 1 and 2 (perspective of 3)
phiARPT2 = PartialTrace(phiAR,2,[2,2]);
e2EphiAR = Entropy(phiARPT2);
% disp("The 2E in the perspective of AR is " + e2EphiAR);


% (3.iii) Compute 2C -- the perspectival subsystem coherence
% Requires a perspectival state as input.

% Compute the 2C for system 2 in the perspective of system 1
e2CphiAfor2 = RelEntCoherence(phiAPT3);
% Compute the 2C for system 3 in the perspective of system 1
phiAPT2 = PartialTrace(phiA,1,[2,2]);     % Compute the other PT
e2CphiAfor3 = RelEntCoherence(phiAPT2);

% Compute the 2C for system 1 in the perspective of system 2
e2CphiRfor1 = RelEntCoherence(phiRPT3);
% Compute the 2C for system 3 in the perspective of system 2
phiRPT1 = PartialTrace(phiR,1,[2,2]);     
e2CphiRfor3 = RelEntCoherence(phiRPT1);

% Compute the 2C for system 1 in the perspective of system 3
e2CphiARfor1 = RelEntCoherence(phiARPT2);
% Compute the 2C for system 2 in the perspective of system 3
phiARPT1 = PartialTrace(phiAR,1,[2,2]);     
e2CphiARfor2 = RelEntCoherence(phiARPT1);


% (3.iv) Compute 2E + 2C -- the sum of perspectival entanglement and
% coherence

% E+C in the perspective of A
e2SumAforR = e2EphiA + e2CphiAfor2;
e2SumAforAR = e2EphiA + e2CphiAfor3;
% E+C in the perspective of R
e2SumRforA = e2EphiR + e2CphiRfor1;
e2SumRforAR = e2EphiR + e2CphiRfor3;
% E+C in the perspective of A
e2SumARforA = e2EphiAR + e2CphiARfor1;
e2SumARforR = e2EphiAR + e2CphiARfor2;

disp(" ");
% Verify and display 2E+2C result
disp("The E+C of R in the perspective of A is " + e2SumAforR);
disp("And E+C for A in the perspective of R is " + e2SumRforA);
disp("The E+C of AR in the perspective of R is " + e2SumRforAR);
disp("And E+C for R in the perspective of AR is " + e2SumARforR);
disp("The E+C of A in the perspective of AR is " + e2SumARforA);
disp("And E+C for AR in the perspective of A is " + e2SumAforAR);

disp(" ");
