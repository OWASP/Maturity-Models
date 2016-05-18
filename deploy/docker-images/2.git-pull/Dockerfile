FROM    bsimm-graph
RUN     git pull origin master
RUN     git submodule update
RUN     npm install

# node was not creating this folder
RUN     mkdir logs