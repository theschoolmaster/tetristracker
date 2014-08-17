class Game < ActiveRecord::Base
  belongs_to :user

  default_scope {  order( created_at: :desc) }

  def calculated_finish_level
    unless lines.blank?
      if TETRIS_LEVEL_ADVANCE[start_level] > lines
        start_level
      else
        ( (lines - TETRIS_LEVEL_ADVANCE[start_level])/10 + start_level + 1).floor
      end
    end
  end
end
