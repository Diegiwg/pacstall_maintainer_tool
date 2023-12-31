#!/bin/bash
#
# STD - Standard Library for Efficient Scripting
#
# A collection of basic functions and constants for efficient script development.
#
# Versions
#
# 0.1: Project Start, with the basic implementation of a test function to be imported, using `source $STD` and used in other scripts called by the pmt tool with `STD_test`.
# 0.2: Removed the test function. Implemented the initial version of the Strings sub-library, which provides functions for string manipulation.
# 0.3: Implemented the initial version of the Hash sub-library, which provides functions for calculating hash values.
# 0.4: Implemented the initial version of the Pacscript sub-library.
#
# Maintained by Diegiwg
# Copyright (c) 2023
#

source "./lib/Strings.sh"
source "./lib/Hash.sh"
source "./lib/Pacscript.sh"
