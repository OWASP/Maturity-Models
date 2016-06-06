app = angular.module('MM_Graph')

class MM_Graph_API
  constructor: (http)->
    @.$http = http

  routes: (callback)=>
    url = "/api/v1/routes/list"
    @.$http.get url
           .success (data)->
              callback data


app.service 'MM_Graph_API', ($http)=>
  return new MM_Graph_API $http