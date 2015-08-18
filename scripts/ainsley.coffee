# Description:
#   For all your Ainsley Hariott needs
#
# Commands:
#   hubot ainsley me - Retrieve a rendering of our oily god

module.exports = (robot) ->
  robot.respond /(ainsley|oil)( me)? (.*)/i, (msg) ->
    ainsleyMe msg, (url) ->
      msg.send url

ainsleyMe = (msg, cb) ->
  # Using deprecated Google image search API
  q = v: '1.0', rsz: '8', q: 'ainsley harriott', safe: 'active'
  msg.http('https://ajax.googleapis.com/ajax/services/search/images')
    .query(q)
    .get() (err, res, body) ->
      if err
        msg.send "The oily god is displeased :( - #{err}"
        return
      if res.statusCode isnt 200
        msg.send "The oily one sent us HTTP #{res.statusCode}. :("
        return
      images = JSON.parse(body)
      images = images.responseData?.results
      if images?.length > 0
        image = msg.random images
        cb ensureImageExtension image.unescapedUrl

ensureImageExtension = (url) ->
  ext = url.split('.').pop()
  if /(png|jpe?g|gif)/i.test(ext)
    url
  else
    "#{url}#.png"
