# Description:
#   URY stream info
#
# Commands:
#   hubot now playing <stream> - See what's currently playing on URY
#   hubot listeners - See how many people are currently listening to URY
module.exports = (robot) ->
  robot.respond /now playing\s?(.*)/i, (msg) ->
    console.log(msg.match)
    robot.http("https://ury.org.uk/audio/status-json.xsl")
      .get() (err, res, body) ->
        data = JSON.parse(body)
        mount = "/" + ( if msg.match[1]? and (msg.match[1] != '') then msg.match[1].trim() else "live-high" )
        msg.send "Now playing: #{getNowPlaying(data, mount)}"

  robot.respond /listeners/i, (msg) ->
    robot.http("https://ury.org.uk/audio/status-json.xsl")
      .get() (err, res, body) ->
        data = JSON.parse(body)
        listeners = 0
        for source in data.icestats.source
          listeners += source.listeners
        msg.send "Live listeners: #{listeners}"

getNowPlaying = (data, mount) ->
  nowplaying = ""
  for source in data.icestats.source
    if endsWith(source.listenurl, mount)
      nowplaying = if source.title? then source.title else ""
      nowplaying += if source.artist? then " - #{source.artist}" else ""
      break
  nowplaying

endsWith = (string, substring) ->
  substring == '' or string.slice(-substring.length) == substring
