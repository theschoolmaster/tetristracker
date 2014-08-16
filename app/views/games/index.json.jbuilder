json.array!(@games) do |game|
  json.extract! game, :id, :score, :start_level, :finish_level, :lines, :user_id
  json.url game_url(game, format: :json)
end
