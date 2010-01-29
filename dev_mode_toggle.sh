#!/bin/bash

if [ -a config/preinitializer.rb ]
then
	echo "dev mode on"
	mv config/preinitializer.rb config/__preinitializer.rb
else
	echo "dev mode off"
	mv config/__preinitializer.rb config/preinitializer.rb
fi

