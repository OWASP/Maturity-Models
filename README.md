Node application to help managing Maturity Models like the ones created by BSIMM and OpenSAMM

Build status: [![Build Status](https://travis-ci.org/OWASP/Maturity-Models.svg?branch=master)](https://travis-ci.org/OWASP/Maturity-Models)

Current QA server: http://138.68.145.52

### UI
![image](https://cloud.githubusercontent.com/assets/656739/16320406/67632dc0-398f-11e6-8aee-8a1f9bd97364.png)

### Run from source

```
git clone git@github.com:DinisCruz/Maturity-Models.git
cd Maturity-Models
git submodule init
git submodule update
npm install --quiet
cd code/ui
npm install --quiet
npm install --quiet -g bower
npm install --quiet -g gulp
bower --allow-root install
gulp
cd ..
npm run dev
```

note ```npm start``` will also work, but for now use ```npm run dev```

### Run tests
```
npm test
```

### Updating code

When doing a ```git pull origin master``` to get the latest version you might need to also do a ```git submodule update``` or ```git submodule sync``` to keep the submodules updated. 

You can check if all is good by doing an ```git status``` on the root folder of this repo (which should return 'no changes') 

### Docker image

Available at https://hub.docker.com/r/diniscruz/maturity-models/

run with (port 80): 
docker run -it -p 80:3000 diniscruz/maturity-models 

or with (as demon on port 3333): 
docker run -it -d -p 3333:3000 diniscruz/maturity-models 


### BSIMM-Graphs
The first version of this tool is designed to work with BSIMM mappings, but there is work under way to also add OpenSAMM mappings



The data is stored in the repo https://github.com/DinisCruz/BSIMM-Graphs-Data which should be forked to hold private/custom data

### Related posts:
 - [BSIMM Questions for Teams v0.7 (with all consolidated team questions and maybe column)](http://blog.diniscruz.com/2016/04/bsimm-questions-for-teams-v07-with-all.html)
 - [Updated version of BSIMM Questions for Teams (now will all activities mapped)](http://blog.diniscruz.com/2016/04/updated-version-of-bsimm-questions-for.html)
 - [First pass at BSIMM questions for teams](http://blog.diniscruz.com/2016/04/first-pass-at-bsimm-questions-for-teams.html)

### Research

 - "D3.js - Radar Chart or Spider Chart - Adjusted from radar-chart-d3" - http://bl.ocks.org/nbremer/6506614
 - "Making the D3 Radar Chart look a bit better" http://www.visualcinnamon.com/2013/09/making-d3-radar-chart-look-bit-better.html
 - "Chart.js - Radar chart introduction" http://www.chartjs.org/docs/#radar-chart-introduction

 - other:
  - https://anmolkoul.wordpress.com/2015/06/05/interactive-data-visualization-using-d3-js-dc-js-nodejs-and-mongodb/
  - https://dc-js.github.io/dc.js/
  - http://linuxsimba.com/running-d3-in-node/
  - http://blog.stapps.io/using-d3-both-on-the-front-end-and-server/
  - https://graves.cl/radar-chart-d3/ "Example of radar chart"
  - http://bl.ocks.org/chrisrzhou/2421ac6541b68c1680f8 : "D3 Radar Chart - AngularJS application showcasing an interactive D3 radar chart (with facetting)."
  - https://gist.github.com/chrisrzhou/2421ac6541b68c1680f8 : "D3 Radar Chart"
