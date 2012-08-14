class Talk < ActiveRecord::Base
  belongs_to :from, :class_name => "User", :foreign_key => "from_id"
  belongs_to :to  , :class_name => "User", :foreign_key => "to_id"

  def self.broadcast(user_id, message)
    talk = Talk.create({ :from_id => user_id, :text => message, :read => true})
    Pusher['broadcast'].trigger('new-message', {:text => "<b>#{talk.from.name}</b> #{talk.text}"})
  end

end
