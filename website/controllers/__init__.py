import os
import glob

# This will import all .py files in this folder.
# Removes the need to explicitly import each and every new file.
__all__ = [os.path.basename(f)[:-3] for f in glob.glob(os.path.dirname(__file__) + "/*.py")]