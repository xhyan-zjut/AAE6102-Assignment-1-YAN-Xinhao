function [X_est,P_est] = ekf(satPos,satVel,obs,dopplers,settings,X,P,Q)

numSat = size(obs,2);
dt = settings.navSolPeriod/1000;
A = eye(8);
A(1, 4) = dt;  A(2, 5) = dt;  A(3, 6) = dt;
A(7, 8) = dt;

R = 1000;
R_doppler = 10000;

H = zeros(2*numSat, size(X,1));
Z = zeros(2*numSat, 1);
h_x = zeros(2*numSat, 1);

% prediction 
X_pre = A * X;
P_pre = A*P*A'+Q;

for i = 1:numSat
    %--- Correct satellite position (do to earth rotation) --------
    Xs = satPos(1, i);  Ys = satPos(2, i);  Zs = satPos(3, i);
    VXs = satVel(1,i); VYs = satVel(2,i); VZs = satVel(3,i);
    dX = Xs - X_pre(1);
    dY = Ys - X_pre(2);
    dZ = Zs - X_pre(3);
    dVX = VXs - X_pre(4);
    dVY = VYs - X_pre(5);
    dVZ = VZs - X_pre(6);
    rho = sqrt(dX^2 + dY^2 + dZ^2); % Range

    traveltime = rho / settings.c ;
    Rot_X = e_r_corr(traveltime, satPos(:, i));

    %--- Find the elevation angel of the satellite ----------------
    % [az(i), el(i), ~] = topocent(X_kk(1:3), Rot_X - X_k(1:3));

    % if (settings.useTropCorr == 1)
    %     %--- Calculate tropospheric correction --------------------
    %     trop = tropo(sin(el(i) * dtr), ...
    %         0.0, 1013.0, 293.0, 50.0, 0.0, 0.0, 0.0);
    % else
    %     % Do not calculate or apply the tropospheric corrections
    %     trop = 0;
    % end
    % weight(i)=sin(el(i))^2;

    Xs = Rot_X(1);  Ys = Rot_X(2);  Zs = Rot_X(3);
    dX = Xs - X_pre(1);
    dY = Ys - X_pre(2);
    dZ = Zs - X_pre(3);
    rho = sqrt(dX^2 + dY^2 + dZ^2); % Range

    % Pseudorange Measurement
    H(i, :) = [-dX/rho, -dY/rho, -dZ/rho, 0,0,0,1,0];
    Z(i) = obs(i) ;
    h_x(i) = rho +  X_pre(7);

    % Doppler Measurement
    if i > length(dopplers)  % Ensure index does not exceed doppler length
        disp('Lack Doppler measurement.');
    else
        H(numSat + i, :) = [0, 0, 0, -dX/rho, -dY/rho, -dZ/rho, 0, 1];
        h_x(numSat + i) = (dX*dVX + dY*dVY + dZ*dVZ ) / rho +  X_pre(8);
        Z(numSat + i) = dopplers(i);
    end
end

R = diag([ones(1, numSat) * R, ones(1, numSat) * R_doppler]);

epsilon = Z - h_x;
K = P_pre * H' * pinv(H * P_pre * H' + R);
X_est = X_pre + (K * epsilon);
P_est = (eye(size(X, 1)) - K * H) * P_pre;
end