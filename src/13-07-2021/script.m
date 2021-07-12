clc;
clear;

% Import Comsol simulation data
data = xlsread('Data_[5-20]mm_Comsol',1);

% X Axis : from 5mm to 20mm
H = data(1:16,1);   

% 12 data set to fit : 3 subsystems : real & Imag of 2 parameters
%-----------------------------------------------------------------
% Subsysteme 1 : Dynamic Stub1 [5,20]mm , Stub2&3 at 5mm
% What to Fit :
S11real_S1data    = data(1:16,6);
S11imag_S1data    = data(1:16,7);
S21real_S1data    = data(1:16,11);
S21imag_S1data    = data(1:16,12);

% Subsysteme 2 : Dynamic Stub2 [5,20]mm , Stub1&3 at 5mm
% What to Fit :
S11real_S2data    = data(17:32,6);
S11imag_S2data    = data(17:32,7);
S21real_S2data    = data(17:32,11);
S21imag_S2data    = data(17:32,12);

% Subsysteme 3 : Dynamic Stub3 [5,20]mm , Stub1&2 at 5mm
% What to Fit :
S11real_S3data     = data(33:48,6);
S11imag_S3data     = data(33:48,7);
S21real_S3data     = data(33:48,11);
S21imag_S3data     = data(33:48,12);

%Fiting session for each data set to select the polynom order
%------------------------------------------------------------
%{
%Fiting session for each data set to select the polynom order
for n=3:18
    p=polyfit(H,S21imag_S3data,n);
    f=polyval(p,H);
    plot(H,S21imag_S3data,H,f)
    err(n-2)=norm(f-S21imag_S3data)./norm(S21imag_S3data);
end
%}

% Fiting order results :
% 15th degree order for all polynoms --> err = 0.0001 or less
%-------------------------------------------------------------
% Subsysteme 1 curve fitting
S11real_S1coeff = polyfit(H,S11real_S1data,15);
S11real_S1fited = @(H)polyval(S11real_S1coeff,H);

S11imag_S1coeff = polyfit(H,S11imag_S1data,15);
S11imag_S1fited = @(H)polyval(S11imag_S1coeff,H);

S21real_S1coeff = polyfit(H,S21real_S1data,15);
S21real_S1fited = @(H)polyval(S21real_S1coeff,H);

S21imag_S1coeff = polyfit(H,S21imag_S1data,15);
S21imag_S1fited = @(H)polyval(S21imag_S1coeff,H);

% Subsysteme 2 curve fitting
S11real_S2coeff = polyfit(H,S11real_S2data,15);
S11real_S2fited = @(H)polyval(S11real_S2coeff,H);

S11imag_S2coeff = polyfit(H,S11imag_S2data,15);
S11imag_S2fited = @(H)polyval(S11imag_S2coeff,H);

S21real_S2coeff = polyfit(H,S21real_S2data,15);
S21real_S2fited = @(H)polyval(S21real_S2coeff,H);

S21imag_S2coeff = polyfit(H,S21imag_S2data,15);
S21imag_S2fited = @(H)polyval(S21imag_S2coeff,H);

% Subsysteme 3 curve fitting
S11real_S3coeff = polyfit(H,S11real_S3data,15);
S11real_S3fited = @(H)polyval(S11real_S3coeff,H);

S11imag_S3coeff = polyfit(H,S11imag_S3data,15);
S11imag_S3fited = @(H)polyval(S11imag_S3coeff,H);

S21real_S3coeff = polyfit(H,S21real_S3data,15);
S21real_S3fited = @(H)polyval(S21real_S3coeff,H);

S21imag_S3coeff = polyfit(H,S21imag_S3data,15);
S21imag_S3fited = @(H)polyval(S21imag_S3coeff,H);

% Resulting S11 & S21 ( complex format )
%---------------------------------------
% Subsysteme 1 
S11_S1fited = @(H)S11real_S1fited(H) + 1i*S11imag_S1fited(H);
S21_S1fited = @(H)S21real_S1fited(H) + 1i*S21imag_S1fited(H);
% Subsysteme 2 
S11_S2fited = @(H)S11real_S2fited(H) + 1i*S11imag_S2fited(H);
S21_S2fited = @(H)S21real_S2fited(H) + 1i*S21imag_S2fited(H);
% Subsysteme 3 
S11_S3fited = @(H)S11real_S3fited(H) + 1i*S11imag_S3fited(H);
S21_S3fited = @(H)S21real_S3fited(H) + 1i*S21imag_S3fited(H);

%Compare Fitting with Comsol Data : Plot
%-------------------------------
% Subsysteme 1 
S11mod_S1data    = data(1:16,8);
S11arg_S1data    = data(1:16,9);
figure('Name','Subsysteme 1 real(S11)');
plot(H,S11real_S1data,H,S11real_S1fited(H))
legend('Comsol','Fitting')
figure('Name','Subsysteme 1 Imag(S11)');
plot(H,S11imag_S1data,H,S11imag_S1fited(H))
legend('Comsol','Fitting')

%plot(H,S11mod_S1data,H,abs(S11_S1fited(H)))
%plot(H,S11arg_S1data,H,arg(S11_S1fited(H)))


S21mod_S1data    = data(1:16,13);
S21arg_S1data    = data(1:16,14);
figure('Name','Subsysteme 1 real(S21)');
plot(H,S21real_S1data,H,S21real_S1fited(H))
legend('Comsol','Fitting')
figure('Name','Subsysteme 1 Imag(S21)');
plot(H,S21imag_S1data,H,S21imag_S1fited(H))
legend('Comsol','Fitting')

%plot(H,S21mod_S1data,H,abs(S21_S1fited(H)))
%plot(H,S21arg_S1data,H,arg(S21_S1fited(H)))


% Subsysteme 2
S11mod_S2data    = data(17:32,8);
S11arg_S2data    = data(17:32,9);
figure('Name','Subsysteme 2 real(S11)');
plot(H,S11real_S2data,H,S11real_S2fited(H))
legend('Comsol','Fitting')
figure('Name','Subsysteme 2 Imag(S11)');
plot(H,S11imag_S2data,H,S11imag_S2fited(H))
legend('Comsol','Fitting')

%plot(H,S11mod_S2data,H,abs(S11_S2fited(H)))
%plot(H,S11arg_S2data,H,arg(S11_S2fited(H)))


S21mod_S2data    = data(17:32,13);
S21arg_S2data    = data(17:32,14);
figure('Name','Subsysteme 2 real(S21)');
plot(H,S21real_S2data,H,S21real_S2fited(H))
legend('Comsol','Fitting')
figure('Name','Subsysteme 2 Imag(S21)');
plot(H,S21imag_S2data,H,S21imag_S2fited(H))
legend('Comsol','Fitting')

%plot(H,S21mod_S2data,H,abs(S21_S2fited(H)))
%plot(H,S21arg_S2data,H,arg(S21_S2fited(H)))


% Subsysteme 3
S11mod_S3data    = data(33:48,8);
S11arg_S3data    = data(33:48,9);
figure('Name','Subsysteme 3 real(S11)');
plot(H,S11real_S3data,H,S11real_S3fited(H))
legend('Comsol','Fitting')
figure('Name','Subsysteme 3 Imag(S11)');
plot(H,S11imag_S3data,H,S11imag_S3fited(H))
legend('Comsol','Fitting')

%plot(H,S11mod_S3data,H,abs(S11_S3fited(H)))
%plot(H,S11arg_S3data,H,arg(S11_S3fited(H)))


S21mod_S3data    = data(33:48,13);
S21arg_S3data    = data(33:48,14);
figure('Name','Subsysteme 3 real(S21)');
plot(H,S21real_S3data,H,S21real_S3fited(H))
legend('Comsol','Fitting')
figure('Name','Subsysteme 3 Imag(S21)');
plot(H,S21imag_S3data,H,S21imag_S3fited(H))
legend('Comsol','Fitting')

%plot(H,S21mod_S3data,H,abs(S21_S3fited(H)))
%plot(H,S21arg_S3data,H,arg(S21_S3fited(H)))


% System cascade network function
%--------------------------------
delta = @(H2)(S11_S2fited(H2).^2) - (S21_S2fited(H2).^2);
num = @(H1,H2,H3)(S21_S1fited(H1).^2)*(S11_S2fited(H2)- (delta(H2)*S11_S3fited(H3)));
den = @(H1,H2,H3)(1-(S11_S2fited(H2)*S11_S1fited(H1))-(S11_S2fited(H2)*S11_S3fited(H3))+(S11_S1fited(H1)*S11_S3fited(H3)*delta(H2)));
S11_cascade = @(H1,H2,H3) S11_S1fited(H1) + num(H1,H2,H3)./den(H1,H2,H3);

% Another System cascade network function ( To verify )
%{
delta = @(H1)(S21_S1fited(H1).^2) - (S11_S1fited(H1).^2);
beta  = @(H2)(S21_S2fited(H2).^2) - (S11_S2fited(H2).^2);
num = @(H1,H2,H3) S11_S1fited(H1) + (S11_S2fited(H2)* delta(H1)) + S11_S3fited(H3)*((delta(H1)*beta(H2))-(S11_S1fited(H1)*S11_S2fited(H2)));
den = @(H1,H2,H3) 1-(S11_S2fited(H2)*S11_S1fited(H1))-S11_S3fited(H3)*((S11_S1fited(H1)*beta(H2))+S11_S2fited(H2));
S11_cascade = @(H1,H2,H3)num(H1,H2,H3)./den(H1,H2,H3);
%}

% Compare System response with Comsol data simulation : Plot
% ---------------------------------------------------
figure('Name','System : real(S11)');
%plot(H,S11real_S1data,H,real(S11_cascade(H,5,5)))
plot(H,S11real_S2data,H,real(S11_cascade(5,H,5)))
%plot(H,S11real_S3data,H,real(S11_cascade(5,5,H)))
%plot(H,S11real_datadiv,H,real(S11_cascade(10,H,16)))
legend('Comsol','Cascade')

figure('Name','System : Imag(S11)');
%plot(H,S11imag_S1data,H,imag(S11_cascade(H,5,5)))
plot(H,S11imag_S2data,H,imag(S11_cascade(5,H,5)))
%plot(H,S11imag_S3data,H,imag(S11_cascade(5,5,H)))
%plot(H,S11imag_datadiv,H,imag(S11_cascade(10,H,16)))
legend('Comsol','Cascade')

%figure('Name','module');
%plot(H,S11mod_S1data,H,abs(S11_cascade(H,5,5)))
%plot(H,S11mod_S2data,H,abs(S11_cascade(5,H,5)))
%plot(H,S11mod_S3data,H,abs(S11_cascade(5,5,H)))
%plot(H,S11mod_datadiv,H,abs(S11_cascade(10,H,16)))

%figure('Name','arg');
%plot(H,S11arg_S1data,H,arg(S11_cascade(H,5,5)))
%plot(H,S11arg_S2data,H,arg(S11_cascade(5,H,5)))
%plot(H,S11arg_S3data,H,arg(S11_cascade(5,5,H)))
%plot(H,S11arg_datadiv,H,arg(S11_cascade(10,H,16)))

% Ignore 
%{
% This is another set of comsol simulation data to compare with
datadiv = xlsread('Data-divers',1);
S11real_datadiv    = datadiv(1:end,4);
S11imag_datadiv    = datadiv(1:end,5);
S11mod_datadiv     = datadiv(1:end,6);
S11arg_datadiv     = datadiv(1:end,7);
%}
