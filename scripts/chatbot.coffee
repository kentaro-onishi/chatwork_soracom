# Description:
#  invoke soracom cli command.
#  and post the results to the chatwork room.
#

# chat work api url
chatworkApiUrl = 'https://api.chatwork.com/v1'
# sim imis
# [todo]
# pass by arguments
simImsi = 'xxxxxxxxxxxxxxx'

module.exports = (robot) ->
  chatworkPost = (message) ->
    robot.logger.error "#{process.env.HUBOT_CHATWORK_ROOMS}"
    robot.http("#{chatworkApiUrl}/rooms/#{process.env.HUBOT_CHATWORK_ROOMS}/messages")
      .headers
        'Content-Type': 'application/x-www-form-urlencoded'
        'X-ChatWorkToken': process.env.HUBOT_CHATWORK_TOKEN
      .post('body=' + message) (err, r, body) ->
        robot.logger.error "Chatwork error:#{err}, body:#{body}" if err?
  soracomCallback = (error, stdout, stderr) ->
    chatworkPost error if error?
    chatworkPost stdout if stdout?
    chatworkPost stderr if stderr?
  soracom = (type, speedclass=null) ->
    robot.logger.error "#{type}"
    @exec = require('child_process').exec
    if type == 'list'
      command = "soracom subscriber list"
      robot.logger.info "command #{command}"
      @exec command, (error, stdout, stderr) ->
        soracomCallback(error, stdout, stderr)
    else if type == 'activate'
      command = "soracom subscriber activate --imsi=#{simImsi}"
      robot.logger.info "command #{command}"
      @exec command, (error, stdout, stderr) ->
        soracomCallback(error, stdout, stderr)
    else if type == 'deactivate'
      command = "soracom subscriber deactivate --imsi=#{simImsi}"
      robot.logger.info "command #{command}"
      @exec command, (error, stdout, stderr) ->
        soracomCallback(error, stdout, stderr)
    else if type == 'speedclass'
      command = "soracom subscriber update_speed_class --imsi=#{simImsi} --speed-class=#{speedclass}"
      robot.logger.info "command #{command}"
      @exec command, (error, stdout, stderr) ->
        soracomCallback(error, stdout, stderr)
  robot.hear /^いちらんちょうだい$/i, (res) ->
    soracom "list"
  robot.hear /^うごけぇぇぇぇ$/i, (res) ->
    soracom "activate"
  robot.hear /^とまれーーーー$/i, (res) ->
    soracom "deactivate"
  robot.hear /^ヘイスト$/i, (res) ->
    soracom "speedclass", "s1.fast"
  robot.hear /^スロウ$/i, (res) ->
    soracom "speedclass", "s1.minimum"
  robot.hear /どこおるん？/, (res) ->
     chatworkPost "ここおんで！"

