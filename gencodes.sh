#!/usr/bin/env bash

#delete previous gencodes
rm src/*.h
rm include/*.h
rm src/*.cxx
rm src/*.xml
rm src/make*

#get the new idl file created
CURRENT_IDL=$(basename ./idl/*.idl .idl)
#get prev idl file 
PREV_IDL=$(head -n 1 gencodes.cache)

#generate codes
cd src
rtiddsgen -replace -language C++ -example x64Linux3gcc4.8.2 ../idl/*.idl -d ./

cd ..
#change the filenames on CMakeLists based on newly generated codes
perl -pi -e "s/$PREV_IDL/$CURRENT_IDL/g" CMakeLists.txt

#change library name based on idl
perl -pi -e "s/$PREV_IDL_lib/$CURRENT_IDL_lib/g" CMakeLists.txt


#store the previous idl name so the bash file knows what to replace next call
perl -pi -e "s/$PREV_IDL/$CURRENT_IDL/g" gencodes.cache

#move generated header files to include folder
mv src/*.h include