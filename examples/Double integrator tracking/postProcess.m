function postProcess(solution, problem, options)
% postProcess - Show all the the required plots and process the solution
%
% Syntax:  postProcess(solution, problem, options)
%
% Output:
%    returns none

%------------- BEGIN CODE --------------
U_limit = 10;
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
time_horizon = linspace(problem.time.t0, problem.time.tf, num_of_steps+1);
% Extract optimal values

X_out = zeros(2, num_of_steps + 1);
U_out = zeros(1, num_of_steps);
X_ref = zeros(2, num_of_steps + 1);
error = zeros(2, num_of_steps + 1);
for i = 1 : num_of_steps + 1
    X_out(:, i) = opti.value(X(:, i));
    X_ref(1, i) = 5*sin(time_horizon(i));
    X_ref(2, i) = 5*cos(time_horizon(i));
    error(:, i) = X_out(:, i) - [X_ref(1, i); X_ref(2, i)];
end

for i = 1 : num_of_steps
    U_out(:, i) = opti.value(U_app(:, i));
end

% Figure

if options.plot
    % Plot action trajectories
    for ui = 1 : problem.nu
        figure
        plot(time_horizon(1:end-1), U_out(ui,:),'b','LineWidth',1);
        ylabel("Action trajectory");
        xlabel('Time [s]');
        xlim([problem.time.t0, problem.time.tf])
        grid on        
        % legend("u"+num2str(ui));
        hold on
        yline(-U_limit,'r--','LineWidth',1);
        yline(U_limit,'r--','LineWidth',1);
        plot(time_horizon(1:end-1),-U_limit,time_horizon(1:end-1),U_limit,'LineWidth',1);
    end
    
    % Plot state trajectories
    if options.plot == 2
        for xi = 1 : problem.nx
            figure
            grid on
            hold on       
            plot(time_horizon, X_out(xi,:),'b','LineWidth',1);
            ylabel("State trajectory");
            xlabel('Time [s]');
            xlim([problem.time.t0, problem.time.tf])
            plot(time_horizon, X_ref(xi,:),'--','LineWidth',1);
            label= sprintf('$x_{%d}$',xi);
            legend(label,'Interpreter','Latex');
            hold off
        end
    end
end

%-------------- END CODE ---------------
end