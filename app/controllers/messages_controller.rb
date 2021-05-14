class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @message = Message.new
    @messages = @room.messages.includes(:user)
  end
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(form_message_content)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def form_message_content
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

end
