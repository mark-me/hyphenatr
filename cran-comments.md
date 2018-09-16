## Test environments
* local OS X install, R 3.5.1
* ubuntu 14.04 (on travis-ci), R 3.5.1
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

* This is a maintanance release

----

Fixes CRAN check errors on the erroring platforms and adds C code registration.

As per the communication for the initial version, the hypenation dictionaries
are included to make it easy on users vs have to deal with getting permission
from them to make a directory and add an interface to download the dictionaries
on-demand.

Also updated/added the following dictionaries:

- bg, ca, de, de, de, es, fr, id, pt, ro

