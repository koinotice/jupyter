echo "from notebook.auth import passwd
from os import environ
print(passwd('biying2018'))" > pwgen.py

echo $(python pwgen.py)
