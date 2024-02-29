FROM python:3

RUN apt-get update && apt-get install -y ca-certificates curl gnupg
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
#RUN NODE_MAJOR=20
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install nodejs -y

#RUN curl -sL https://deb.nodesource.com/setup_14.x |  bash -
#RUN  apt-get install -y nodejs

RUN git clone https://github.com/sveinpj/tinypilot
#COPY requirements.txt /tinypilot
#COPY dev_requirements.txt /tinypilot

WORKDIR /tinypilot
#RUN apt-get update
#RUN pip install --upgrade pip
#RUN pip install --upgrade setuptools
#RUN apt upgrade -y
RUN pip install -r requirements.txt
RUN pip install -r dev_requirements.txt
RUN npm install prettier
RUN ./dev-scripts/build

EXPOSE 8000
ENV PORT=8000

CMD ["python", "/tinypilot/app/main.py"]
