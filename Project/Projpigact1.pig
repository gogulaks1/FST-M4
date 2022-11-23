inputFile = LOAD 'hdfs:///user/GogulaFSTM4/episode4_dialouges.txt' USING PigStorage('\t') AS ( name:chararray,line:chararray);
inputFileRanked = RANK inputFile;
onlyDialouges = FILTER inputFileRanked BY ( rank_inputFile > 2);
groupByName = GROUP onlyDialouges BY name;
names =  FOREACH groupByName GENERATE $0 as name, COUNT($1) as no_of_lines;
nameOrdered = ORDER names BY no_of_lines DESC;
STORE nameOrdered INTO 'hdfs:///user/GogulaFSTM4/outputs/episodeIVoutput' USING PigStorage('\t');
