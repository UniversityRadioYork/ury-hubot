# Description:
#   URY stream info
#
# Commands:
#   hubot now playing - See what's currently playing on URY
#   hubot listeners - See how many people are currently listening to URY
module.exports = (robot) ->
  robot.respond /now playing/i, (msg) ->
    robot.http("http://uryfs1.york.ac.uk:7070/json2.xsl")
      .get() (err, res, body) ->
        data = JSON.parse(body)
        msg.send "Now playing: #{data.mounts["/live-high"].title}"

  robot.respond /listeners/i, (msg) ->
    robot.http("http://uryfs1.york.ac.uk:7070/json2.xsl")
      .get() (err, res, body) ->
        data = JSON.parse(body)
        msg.send "Live listeners: #{data.total_listeners}"
