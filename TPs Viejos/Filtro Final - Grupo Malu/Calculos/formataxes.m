function [ ] = formataxes( titlestr, xlabelstr, ylabelstr, varargin )
% FORMAT AXES
% formato general del grafico (interpretes en latex, grilla)
% varargin = los strings de legend

ax = gca;
title(titlestr, 'interpreter', 'latex');
set(ax,'TickLabelInterpreter','latex');
grid on;

if nargin >= 2 
    xlabel(xlabelstr,'interpreter','latex');
end

if nargin >= 3 
    ylabel(ylabelstr,'interpreter','latex');
%    ax.AxesGrid.YUnits = '';
end

if nargin >= 4
    legendstr = varargin(1) ;
    for i=2:size(varargin,2)
        legendstr= [legendstr;(cell2mat(varargin(i)))];
    end
    lgd = legend(legendstr);
    lgd.Interpreter = 'latex';
end
fig = gcf;
fig.Position = [100 200 1000 350];

% xticks(sort([xticks 25e3]));
% xticklabels({'$10^3$', '$10^4$', '$2.5\times 10^4$', '$10^5$', '$10^6$'});
end

