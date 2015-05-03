@echo off

pelican

pushd .\output

python -m SimpleHTTPServer

popd