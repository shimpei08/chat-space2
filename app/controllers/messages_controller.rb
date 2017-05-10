class MessagesController < ApplicationController

  def index
    @groups = current_user.groups.desc
  end

  def new
    @groups = current_user.groups.desc
    @group = Group.find(params[:group_id])
    @messages = @group.messages.desc
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(create_params)
    unless @message.save
      flash[:alert] = "メッセージを送信できませんでした"
    end
    redirect_to new_group_message_url
  end

  private

  def create_params
    @group = Group.find(params[:group_id])
    params.require(:message).permit(:body, :image).merge( group_id: @group.id )
  end
end
