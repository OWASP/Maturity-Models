FROM    node

RUN 	git clone https://github.com/DinisCruz/BSIMM-Graphs.git
WORKDIR BSIMM-Graphs
RUN     sed -i 's/git@github.com:/https:\/\/<user>:<token>@github.com\//' .gitmodules
RUN     git submodule init
RUN     npm install -g bower; bower --allow-root install
RUN     npm install gulp    ; cd src-ui ; ../node_modules/.bin/gulp ; cd ..
#RUN     npm install

#RUN     git pull origin master
#RUN     git submodule update

#RUN     mkdir logs              # node app was failing to create this folder

#CMD     npm start

