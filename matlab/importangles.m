function [Timestamp, Kinect_LShoulderExtFlx, Kinect_LShoulderAbdAdd, Kinect_LElbow, Kinect_RShoulderExtFlx, Kinect_RShoulderAbdAdd, Kinect_RElbow, LS_X, LS_Y, LS_Z, LE_X, LE_Y, LE_Z, RS_X, RS_Y, RS_Z, RE_X, RE_Y, RE_Z] = importangles(filename, dataLines)
%IMPORTFILE1 Import data from a text file
%  [TIMESTAMP, KINECT_LSHOULDEREXTFLX, KINECT_LSHOULDERABDADD,
%  KINECT_LELBOW, KINECT_RSHOULDEREXTFLX, KINECT_RSHOULDERABDADD,
%  KINECT_RELBOW, LS_X, LS_Y, LS_Z, LE_X, LE_Y, LE_Z, RS_X, RS_Y, RS_Z,
%  RE_X, RE_Y, RE_Z] = IMPORTFILE1(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as column
%  vectors.
%
%  [TIMESTAMP, KINECT_LSHOULDEREXTFLX, KINECT_LSHOULDERABDADD,
%  KINECT_LELBOW, KINECT_RSHOULDEREXTFLX, KINECT_RSHOULDERABDADD,
%  KINECT_RELBOW, LS_X, LS_Y, LS_Z, LE_X, LE_Y, LE_Z, RS_X, RS_Y, RS_Z,
%  RE_X, RE_Y, RE_Z] = IMPORTFILE1(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  [Timestamp, Kinect_LShoulderExtFlx, Kinect_LShoulderAbdAdd, Kinect_LElbow, Kinect_RShoulderExtFlx, Kinect_RShoulderAbdAdd, Kinect_RElbow, LS_X, LS_Y, LS_Z, LE_X, LE_Y, LE_Z, RS_X, RS_Y, RS_Z, RE_X, RE_Y, RE_Z] = importfile1("F:\github\wearable-jacket\matlab\kinect+imudata\wearable+kinecttesting_04-10-2019 13-32.txt", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 10-Apr-2019 14:30:35

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 19);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Timestamp", "Kinect_LShoulderExtFlx", "Kinect_LShoulderAbdAdd", "Kinect_LElbow", "Kinect_RShoulderExtFlx", "Kinect_RShoulderAbdAdd", "Kinect_RElbow", "LS_X", "LS_Y", "LS_Z", "LE_X", "LE_Y", "LE_Z", "RS_X", "RS_Y", "RS_Z", "RE_X", "RE_Y", "RE_Z"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
tbl = readtable(filename, opts);

%% Convert to output type
Timestamp = tbl.Timestamp;
Kinect_LShoulderExtFlx = tbl.Kinect_LShoulderExtFlx;
Kinect_LShoulderAbdAdd = tbl.Kinect_LShoulderAbdAdd;
Kinect_LElbow = tbl.Kinect_LElbow;
Kinect_RShoulderExtFlx = tbl.Kinect_RShoulderExtFlx;
Kinect_RShoulderAbdAdd = tbl.Kinect_RShoulderAbdAdd;
Kinect_RElbow = tbl.Kinect_RElbow;
LS_X = tbl.LS_X;
LS_Y = tbl.LS_Y;
LS_Z = tbl.LS_Z;
LE_X = tbl.LE_X;
LE_Y = tbl.LE_Y;
LE_Z = tbl.LE_Z;
RS_X = tbl.RS_X;
RS_Y = tbl.RS_Y;
RS_Z = tbl.RS_Z;
RE_X = tbl.RE_X;
RE_Y = tbl.RE_Y;
RE_Z = tbl.RE_Z;
end