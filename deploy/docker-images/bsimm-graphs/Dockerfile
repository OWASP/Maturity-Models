FROM    node

RUN 	git clone https://github.com/DinisCruz/BSIMM-Graphs.git
WORKDIR BSIMM-Graphs
RUN     sed -i 's/git@github.com:/https:\/\/<user>:<token>@github.com\//' .gitmodules
RUN     git submodule init
RUN     git submodule update
RUN     git pull origin master
RUN     npm install

RUN     npm install -g bower; bower --allow-root install
RUN     npm install -g gulp;
RUN     cd src-ui; gulp
#WORKDIR src-ui
#RUN     ../node_modules/.bin/gulp
#WORKDIR ..

RUN     mkdir logs              # node app was failing to create this folder

RUN     ls -la

CMD     npm start

