from notebook.auth import passwd
from os import environ
print(passwd(environ['NOTEBOOK_PASSWORD']))
