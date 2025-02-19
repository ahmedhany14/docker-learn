# Statment
Create a flask app, and initialize Dockerfile, that has this structure:

```Dockerfile
pull from python
create a directory /app

copy the requirements.txt file to /app
run pip install -r /app/requirements.txt

copy project files to /app

expose port 5000

run the flask app by running the command python /app/app.py
```
