cd %gitditabase%
call gradlew
cd \DCS\test\degrees\
call %gitdita% -install
call %gitdita% -i rootDegrees.ditamap -f html5 -temp temp -Dclean.temp=no