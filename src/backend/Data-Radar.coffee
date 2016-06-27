class Data_Radar

  constructor: (options)->    
    @.options      = options || {}
    @.score_Initial = 0.2
    @.score_Yes     = 0.4
    @.score_Maybe   = 0.1
    @.key_Yes       = 'Yes'
    @.key_Maybe     = 'Maybe'

  get_Radar_Data: (file_Data)=>
    data = []
    data.push @.get_Radar_Fields()
    #data.push @.get_Default_Data()           #todo this needs to be implemented as supporting multiple data sets
    #data.push map_Team_Data(level_1_Data)
    data.push @.get_Team_Data @.mapData(file_Data)
    data
      
  get_Radar_Fields: ()->
    axes: [
      { axis: "Strategy & Metrics"        , xOffset: 1    , value: 0},
      { axis: "Conf & Vuln Management"    , xOffset: -110 , value: 0},
      { axis: "Software Environment"      , xOffset: -30  , value: 0},
      { axis: "Penetration Testing"       , xOffset: 1    , value: 0},
      { axis: "Security Testing"          , xOffset: -25  , value: 0},
      { axis: "Code Review"               , xOffset: -60  , value: 0},
      { axis: "Architecture Analysis"     , xOffset: 1    , value: 0},
      { axis: "Standards & Requirements"  , xOffset: 100  , value: 0},
      { axis: "Security Features & Design", xOffset: 30   , value: 0},
      { axis: "Attack Models"             , xOffset: 1    , value: 0},
      { axis: "Training"                  , xOffset: 30   , value: 0},
      { axis: "Compliance and Policy"     , xOffset: 100  , value: 0},
    ]
    
  get_Team_Data: (data)->
    {
      axes: [
        {value: data.SM   },  # Strategy & Metrics
        {value: data.CMVM },  # Configuration & Vulnerability Management
        {value: data.SE   },  # Software Environment
        {value: data.PE   },  # Penetration Testing
        {value: data.ST   },  # Security Testing
        {value: data.CR   },  # Code Review
        {value: data.AA   },  # Architecture Analysis
        {value: data.SR   },  # Standards & Requirements
        {value: data.SFD  },  # Security Features & Design
        {value: data.AM   },  # Attack Models
        {value: data.T    },  # Training
        {value: data.CP   },  # Compliance and Policy
      ]
    }  

  mapData: (file_Data)=>
    result = file_Data
    calculate = (activity, prefix)=>
      score  = @.score_Initial
      for key,value of result?.activities?[activity] when key.contains(prefix)
        if value is @.key_Yes
          score = (score + @.score_Yes).to_Decimal()                          # due to JS Decimal addition bug
        if value is @.key_Maybe
          score = (score + @.score_Maybe).to_Decimal()
      score
  
    data =
      SM  : calculate 'Governance'  , 'SM'
      CMVM: calculate 'Deployment'  , 'CMVM'
      SE  : calculate 'Deployment'  , 'SE'
      PE  : calculate 'Deployment'  , 'SE'
      ST  : calculate 'SSDL'        , 'ST'
      CR  : calculate 'SSDL'        , 'CR'
      AA  : calculate 'SSDL'        , 'AA'
      SR  : calculate 'Intelligence', 'SR'
      SFD : calculate 'Intelligence', 'SFD'
      AM  : calculate 'Deployment'  , 'AM'
      T   : calculate 'Governance'  , 'T'
      CP  : calculate 'Governance'  , 'CP'
      
    return data

module.exports = Data_Radar