FROM    node

RUN 	git clone https://github.com/OWASP/Maturity-Models.git
WORKDIR Maturity-Models
RUN     sed -i 's/git@github.com:/https:\/\/<user>:<token>@github.com\//' .gitmodules
RUN     git submodule init
RUN     git submodule update
RUN     git pull origin master

WORKDIR code/api
RUN     npm install --quiet
WORKDIR ../..

WORKDIR code/ui
RUN     npm install --quiet
RUN     npm install --quiet -g bower
RUN     npm install --quiet -g gulp
RUN     bower --allow-root install
RUN     gulp
WORKDIR ../..

CMD     npm start


# travis builds image and deploys to docker hub at: diniscruz/maturity-models
# build manually using: docker build -t diniscruz/maturity-models .
