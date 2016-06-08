Node application to help managing Maturity Models like the ones created by BSIMM and OpenSAMM

Build status: [![Build Status](https://travis-ci.org/DinisCruz/Maturity-Models.svg?branch=master)](https://travis-ci.org/DinisCruz/Maturity-Models)


## Run from source

```
git clone git@github.com:DinisCruz/Maturity-Models.git
cd Maturity-Models
npm install
bower install
git submodule init
git submodule update
cd ui
gulp
cd ..
npm start
```

## Run tests
```
npm test
```

## Docker image

avaialble at https://hub.docker.com/r/diniscruz/bsimm-graphs/


## BSIMM-Graphs
The first version of this tool is designed to work with BSIMM mappings, but there is work under way to also add OpenSAMM mappings



The data is stored in the repo https://github.com/DinisCruz/BSIMM-Graphs-Data which should be forked to hold private/custom data

## Related posts:
 - [BSIMM Questions for Teams v0.7 (with all consolidated team questions and maybe column)](http://blog.diniscruz.com/2016/04/bsimm-questions-for-teams-v07-with-all.html)
 - [Updated version of BSIMM Questions for Teams (now will all activities mapped)](http://blog.diniscruz.com/2016/04/updated-version-of-bsimm-questions-for.html)
 - [First pass at BSIMM questions for teams](http://blog.diniscruz.com/2016/04/first-pass-at-bsimm-questions-for-teams.html)

## Research

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
