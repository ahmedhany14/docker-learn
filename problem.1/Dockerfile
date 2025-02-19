# pull the latest python image
FROM python:latest

# set the working directory and open it
WORKDIR /app

# copy the current directory contents into the container at /app

COPY requirements.txt .

# copy requirements.txt to the container at /app
RUN pip install -r requirements.txt

COPY my_app.py .

# expose the port 5000
EXPOSE 5000

# run the command to start flask
CMD python my_app.py