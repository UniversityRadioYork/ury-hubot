# Description:
#   URY stream info
#
# Commands:
#   hubot now playing <stream> - See what's currently playing on URY
#   hubot listeners - See how many people are currently listening to URY
module.exports = (robot) ->
  robot.respond /now playing\s?(.*)/i, (msg) ->
    console.log(msg.match)
    robot.http("http://uryfs1.york.ac.uk:7070/json2.xsl")
      .get() (err, res, body) ->
        data = JSON.parse(body)
        mount = "/" + ( if msg.match[1]? and (msg.match[1] != '') then msg.match[1].trim() else "live-high" )
        msg.send "Now playing: #{data.mounts[mount].title}"

  robot.respond /listeners/i, (msg) ->
    robot.http("http://uryfs1.york.ac.uk:7070/json2.xsl")
      .get() (err, res, body) ->
        data = JSON.parse(body)
        msg.send "Live listeners: #{data.total_listeners}"
