#!/bin/bash

${PYTHON} setup.py install

rm -rf ${PREFIX}/man
rm -f ${PREFIX}/bin/spyder_win_post_install.py
rm -rf ${SP_DIR}/Sphinx-*

# TODO :: Remove the True here, it is working around a conda-build bug.
if [[ ${PY3K} == True ]] || [[ ${PY3K} == 1 ]]; then
  if [[ ${HOST} =~ .*linux.* ]]; then
    BIN=${PREFIX}/bin
    mv ${BIN}/spyder3 ${BIN}/spyder
  fi
fi
