angular.module('MM_Graph')
  .controller 'RadarController', ($scope, $routeParams, MM_Graph_API)->
    $scope.version = 'v0.7.7'

    target = $routeParams.target

    if target
      MM_Graph_API.file_Get target,(result)->
        $scope.data = result
        $scope.team = result.metadata.team

        mapData result, (data)->
          showRadar(data)

    mapData = (result, next)->

      calculate = (activity, prefix)->
        score = 0.2
        for key,value of result.activities[activity] when key.contains(prefix)
          if value is 'Yes'
            score += 0.4
          if value is 'NA'
            score += 0.1
        score

      data =
        SM  : calculate 'Governance', 'SM'
        CMVM: calculate 'Deployment', 'CMVM'
        SE  : calculate 'Deployment', 'SE'
        PE  : calculate 'Deployment', 'SE'
        ST  : calculate 'SSDL', 'ST'
        CR  : calculate 'SSDL', 'CR'
        AA  : calculate 'SSDL', 'AA'
        SR  : calculate 'Intelligence', 'SR'
        SFD : calculate 'Intelligence', 'SFD'
        AM  : calculate 'Deployment', 'AM'
        T   : calculate 'Governance', 'T'
        CP  : calculate 'Governance', 'CP'
      next data

    showRadar = (data)->
      data = [
          {
              axes: [
                  {axis: "Strategy & Metrics", xOffset: 1, value: 0},
                  {axis: "Conf & Vuln Management", xOffset: -110, value: 0},
                  {axis: "Software Environment", xOffset: -30, value: 0},
                  {axis: "Penetration Testing", xOffset: 1, value: 0},
                  {axis: "Security Testing", xOffset: -25, value: 0},
                  {axis: "Code Review", xOffset: -60, value: 0},
                  {axis: "Architecture Analysis", xOffset: 1, value: 0},
                  {axis: "Standards & Requirements", xOffset: 100, value: 0},
                  {axis: "Security Features & Design", xOffset: 30, value: 0},
                  {axis: "Attack Models", xOffset: 1, value: 0},
                  {axis: "Training", xOffset: 30, value: 0},
                  {axis: "Compliance and Policy", xOffset: 100, value: 0},

              ]
          },
          {
              axes: [
                  {value: 2.0},  # Strategy & Metrics
                  {value: 2.0},  # Configuration & Vulnerability Management
                  {value: 1.8},  # Software Environment
                  {value: 1.5},  # Penetration Testing
                  {value: 1.5},  # Security Testing
                  {value: 1.4},  # Code Review
                  {value: 1.4},  # Architecture Analysis
                  {value: 1.9},  # Standards & Requirements
                  {value: 1.6},  # Security Features & Design
                  {value: 1.3},  # Attack Models
                  {value: 1.2},  # Training
                  {value: 2.1},  # Compliance and Policy
              ]
          },
          {
              colour: 'red',
              axes: [
                  {value: data.SM },  # Strategy & Metrics
                  {value: data.CMVM},  # Configuration & Vulnerability Management
                  {value: data.SE},  # Software Environment
                  {value: data.PE},  # Penetration Testing
                  {value: data.ST},  # Security Testing
                  {value: data.CR},  # Code Review
                  {value: data.AA},  # Architecture Analysis
                  {value: data.SR},  # Standards & Requirements
                  {value: data.SFD},  # Security Features & Design
                  {value: data.AM},  # Attack Models
                  {value: data.T},  # Training
                  {value: data.CP},  # Compliance and Policy
              ]
          }
      ];

      config = {
          color: (index)->
              return ['black', 'orange', 'green'][index];
          w: 450,
          h: 450,
          levels: 6,
          maxValue: 3.0
      }

      RadarChart.draw(".chart-container", data, config);
