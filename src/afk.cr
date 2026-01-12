require "rosegold"
client = Rosegold::Client.new "167.114.124.106"
bot = Rosegold::Bot.new(client)
SPECTATE_HOST = ENV.fetch "SPECTATE_HOST", "0.0.0.0"
SPECTATE_PORT = ENV.fetch("SPECTATE_PORT", "25566").to_i

spectate_server = Rosegold::SpectateServer.new(SPECTATE_HOST, SPECTATE_PORT)
spectate_server.start
spectate_server.attach_client client
bot.join_game
sleep 3.seconds

PITCHGOAL = 15

def forward(bot)
  bot.move_to(bot.location[0] - 2, bot.location[2])
end

def reach_pitch(bot)
  current_pitch = 90
  while current_pitch > PITCHGOAL
    current_pitch = current_pitch - 5
    bot.pitch = current_pitch
    puts "Current pitch is #{current_pitch}"
    bot.wait_tick
  end
end

counter = 0
while counter < 10
  bot.start_using_hand
  reach_pitch(bot)
  forward(bot)
  counter += 1
end
