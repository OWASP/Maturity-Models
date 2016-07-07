Data_Files   = require './Data-Files'
Data_Project = require './Data-Project'

class Data_Stats
  constructor: ->
    @.data_Files   = new Data_Files()
    @.data_Project = new Data_Project()
    @.score_Yes    = 1
    @.score_No     = 0
    @.score_NA     = 1
    @.score_Maybe  = 0.2

  team_Score: (project, team)=>
    scores = {}

    if project and team
      schema = @.data_Project.project_Schema(project)
      data   = @.data_Files.get_File_Data(project, team)
      #console.log schema.activities
      if schema and data
        for domain, activity of data?.activities
          for key,value of activity
            #console.log key
            if schema?.activities[key] 
              score_Key = "level_#{schema.activities[key].level}"              
              scores[score_Key] ?= { value: 0, percentage:'', activities: 0}
              score = scores[score_Key]
              switch value
                when 'Yes'   then score.value += @.score_Yes
                when 'No'    then score.value += @.score_No
                when 'NA'    then score.value += @.score_NA
                when 'Maybe' then score.value += @.score_Maybe

              score.activities++

          for key,score of scores
            score.value      = score.value.to_Decimal()
            score.percentage = Math.round((score.value / score.activities) * 100) + '%'
    scores

  teams_Scores: (project)=>
    all_Scores = {}
    for team in @.data_Files.files_Names project
      all_Scores[team] = @.team_Score project, team
    all_Scores

module.exports = Data_Stats  