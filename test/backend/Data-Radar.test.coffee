Data_Radar = require '../../src/backend/Data-Radar'

describe 'backend | Data-Project', ->
  data_Radar   = null
  project      = null
  team         = null
  test_Data    = null
  beforeEach ->
    project = 'bsimm'
    team    = 'team-A'
    test_Data =
      activities:
        Governance  : { 'SM.1.1': 'Yes'  , 'SM.1.4': 'NA'   , 'SM.2.3': 'Yes'  , 'CP.1.1'  : 'Maybe' }
        Intelligence: { 'AM1.3' : 'Maybe', 'AM1.4' : 'Maybe', 'SDF1.1': 'Maybe', 'SDF.1.1' : 'Maybe' }
        SSDL        : { 'AA.1.1': 'Yes'  , 'AA.1.4': 'NA'   , 'CR.1.1': 'Yes'  , 'CR.1.2'  : 'Yes'   }
        Deployment  : { 'PT.1.1': 'Maybe', 'PT.1.2': 'Maybe', 'SE.2.2': 'Yes'  , 'CMVM.2.3': 'Yes'   }

    data_Radar = new Data_Radar()

  it 'constructor',->
    using data_Radar, ->
      @.constructor.name.assert_Is 'Data_Radar'            


  it 'get_Radar_Fields', ->
    using data_Radar, ->
      using @.get_Radar_Fields(), ->
        @.axes.assert_Size_Is 12
        @.axes.first().assert_Is { axis: "Strategy & Metrics" , xOffset: 1, value: 0},

  it 'mapData (calculates radar values)', ->
    using data_Radar, ->
      expected_Result = { "SM": 1.0, "CMVM": 0.6, "SE" : 0.6, "PE": 0.6, "ST": 0.2, "CR": 1, "AA": 0.6, "SR"  : 0.2, "SFD": 0.2, "AM": 0.2, "T" : 0.2, "CP": 0.3 }
      @.mapData(test_Data).assert_Is expected_Result


  # Other and regression tests
  it 'Check when data is not provided', ->
    using new Data_Radar(), ->
      using @.get_Radar_Data(), ->
        @.first().axes.first().assert_Is { axis: 'Strategy & Metrics', xOffset: 1, value: 0 },
        @.second().axes.first().assert_Is { value: 0.2}

  it 'Issue xyz - JS Decimal bug is causing Radar calculations to be wrong', ->
    using data_Radar, ->

      result =  @.mapData(test_Data)

      wrong_Value   = 0.6000000000000001      
      result['CMVM'].assert_Is_Not wrong_Value
      result['SE'  ].assert_Is_Not wrong_Value

      correct_Value = 0.60
      result['CMVM'].assert_Is correct_Value
      result['SE'  ].assert_Is correct_Value