function postProcess(solution, problem, options)
% postProcess - Show all the the required plots and process the solution
%
% Syntax:  postProcess(solution, problem, options)
%
% Output:
%    returns none

%------------- BEGIN CODE --------------

opti = solution.output;
num_of_steps = options.nodes;
X = solution.X;
U_app = solution.U_app;

if options.print.time
    disp(newline+"Time taken to solve: "+num2str(solution.time_taken)+" secs")
end

if options.NLPsolver == "ipopt"
    disp("Total iterations performed by NLP solver is "+num2str(solution.output.stats.iter_count))
end

if options.print.cost
    disp(newline+"The cost is: "+num2str(solution.cost))
end

% Extract optimal values
X_out = zeros(problem.nx, num_of_steps + 1);
U_out = zeros(problem.nu, num_of_steps); %
for i = 1 : num_of_steps + 1
    X_out(:, i) = opti.value(X(:, i));
end
for i = 1 : num_of_steps
    U_out(:, i) = opti.value(U_app(:, i));
end

% Figure
time_horizon = linspace(problem.time.t0, problem.time.tf, num_of_steps+1);

if options.plot
    % Plot action trajectories
    for ui = 1 : problem.nu
        figure
        plot(time_horizon(1:end-1), U_out(ui,:),'b','LineWidth',1);
        ylabel("Action trajectory");
        xlabel('Time [s]');
        xlim([problem.time.t0, problem.time.tf])
        grid on
        label= sprintf('$u_{%d}$',ui);
        legend(label,'Interpreter','Latex');
    end
    
    % Plot state trajectories
    if options.plot == 2
        for xi = 1 : problem.nx
            figure
            plot(time_horizon, X_out(xi,:),'b','LineWidth',1);
            ylabel("State trajectory");
            xlabel('Time [s]');
            xlim([problem.time.t0, problem.time.tf])
            grid on
            label= sprintf('$x_{%d}$',xi);
            legend(label,'Interpreter','Latex');
        end
    end
end

% Plot robot path
% center of invalid circle areas
a1 = 40; b1 = 20;
a2 = 55; b2 = 40;
a3 = 45; b3 = 65;
r1 = 10; r2 = 80;
figure
hold on
plot(X_out(1,:), X_out(2,:),'LineWidth',1);
th = 0:pi/50:2*pi;
plot(r1*cos(th) + a1, r1*sin(th) + b1, '--r');
plot(r1*cos(th) + a2, r1*sin(th) + b2, '--r');
plot(r1*cos(th) + a3, r1*sin(th) + b3, '--r');
hold off
ylabel("x2");
xlabel('x1');
xlim([0, 80])
ylim([0, 80])
grid on



%-------------- END CODE ---------------
end