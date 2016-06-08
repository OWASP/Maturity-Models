angular.module('MM_Graph')
  .config ($locationProvider)->
    $locationProvider.html5Mode
     enabled    : true
     requireBase: true

    #console.log 'global config will go here'