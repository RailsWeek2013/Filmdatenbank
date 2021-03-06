class MessagesController < ApplicationController
  authorize_resource

  before_action :set_message, only: [:show, :edit, :update, :destroy, :delete]

  # GET /messages
  # GET /messages.json
  # GET /messages/inbox
  def index
    @unread_messages = Message.where(recipient: current_user, read: false, deleted_by_recipient: false).order(created_at: :desc).page params[:page]
    @read_messages = Message.where(recipient: current_user, read: true, deleted_by_recipient: false).order(created_at: :desc).page params[:page]
  end

  # GET /messages/outbox
  def outbox
    @messages = Message.where(sender: current_user, deleted_by_sender: false).order(created_at: :desc).page params[:page]
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    #message = Message.find(params[:id])
    message = Message.where("id = ? AND (sender_id = ? OR recipient_id = ?)",params[:id], current_user.id, current_user.id ).take
    if (message.recipient == current_user) && !message.read
      message.set_read
    end
  end

  # GET /messages/new
  def new
    @message = Message.new
    if params[:mid] != nil
      m = Message.find(params[:mid])
      @message.recipient = m.sender
      @message.subject = "AW: #{m.subject}"
      @message.text = "\n----------\n#{m.text}"
    end
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    if current_user.is_allowed_to_send? params[:message][:recipient_id]
      respond_to do |format|
        if @message.save
          format.html { redirect_to @message, notice: 'Nachricht erfolreich verschickt.' }
          format.json { render action: 'show', status: :created, location: @message }
        else
          format.html { render action: 'new' }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_message_path, notice: 'Sie dürfen an diesen Benutzer keine Nachricht verschicken!'
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def delete
    if @message.delete current_user
      redirect_to outbox_messages_path
    else
      redirect_to inbox_messages_path
    end
  end

  def block
    if current_user.add_to_blocklist params[:user] 
      notice = "Benutzer ist nun blockiert!"
    else
      notice = "Der Benutzer ist bereits blockiert!"
    end
    redirect_to inbox_messages_path, notice: notice
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender_id, :recipient_id, :subject, :text, :read, :deleted_by_sender, :deleted_by_recipient)
    end
  end
