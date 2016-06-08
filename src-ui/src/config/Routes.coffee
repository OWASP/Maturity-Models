angular.module('MM_Graph')
  .config  ($routeProvider)->
    $routeProvider
      .when '/view/'             , templateUrl:'/ui/html/pages/welcome.page.html'
      .when '/view/routes'       , templateUrl:'/ui/html/pages/routes.page.html'
      .when '/view/teams'        , templateUrl:'/ui/html/pages/teams.page.html'
      .when '/view/:target'      , templateUrl:'/ui/html/pages/table.page.html'
      .when '/view/:target/edit' , templateUrl:'/ui/html/pages/data-ui.page.html'
      .when '/view/:target/raw'  , templateUrl:'/ui/html/pages/raw.page.html'

      .otherwise templateUrl:'/ui/html/pages/404.page.html'

