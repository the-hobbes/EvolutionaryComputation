function timeSeries_formatData( data_in, numVars, windowIncrement, varargin )
%TIMESERIES_FORMATDATA used to create time steps for predicting time series
%   Reads in a csv file containing the data we wish to train on, then
%   writes this data out to an appropriate offset format for use with the
%   modified GPLab function used to predict time series data.
%
%   Input arguments: 
%   DATA_IN- the name of the csv file containing all of the data
%   NUMVAR- the number of variables of the source data you wish to use to
%   train
%
%   Output arguments:
%   writes out a text file containing data offset timesteps
%
%   AUTHOR pvendevi@uvm.edu

    %set default values if no arguments are passed in
    if isempty(varargin)
        data_in = 'testReadIn.txt';
        numVars = 5;
        windowIncrement = 24;        
    end

    m = csvread(data_in); %read in source file and make a vector
    m = m'; %transpose data from rows to columns
    
    %set starting window size variables
    fileLength = length(m);
    totalLength = 336;
    startWin = 1;
    endWin = numVars;

    %create a NAN array that has numvars rows and columns to store windows
    windowStorage = NaN(fileLength, numVars); %rows, columns
    counter = 1;
    
    %set total length to be 336 (two weeks at hourly intervals)
    %set the increment for the window to be user specified (usually 12 or
    %24)
    
    while(endWin <= totalLength)
        
        %loop through each window and store in an array until done
        windowStorage(counter,:) = m(1,startWin:endWin);
        
        counter = counter + 1; 
        startWin = startWin + windowIncrement;
        endWin = endWin + windowIncrement;
    end
    windowStorage = windowStorage(isfinite(windowStorage(:, 1)), :);
    %save contents of windowStorage into a space separated text file
    dlmwrite('z_TESTME.txt', windowStorage, 'delimiter','\t');
    
end

