del basetopic.ditamap
call java -jar \DITATools\idwb\lib\saxon9.jar -xsl:generate.xsl -o:basetopic.ditamap -s:\Users\IBM_ADMIN\github\metadita\ditarng\combined.rng
call \dita-ot\dita-ot-3.0.2\bin\dita -i basetopic.ditamap -l log.txt -f html5