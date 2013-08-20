class MessagesController < ApplicationController
  authorize_resource

  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  # GET /messages/inbox
  def index
    @unread_messages = Message.where(recipient: current_user, read: false, deleted_by_recipient: false)
    @read_messages = Message.where(recipient: current_user, read: true, deleted_by_recipient: false)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    message = Message.find(params[:id])

    if (message.recipient == current_user) && !message.read
      message.read = true
      message.save
    end
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
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

  # DELETE /messages/1
  # DELETE /messages/1.json
  def delete
    set_message

    if @message.sender == current_user
      if @message.deleted_by_recipient
        destroy
      else
        @message.deleted_by_sender = true
        @message.save
      end
    end

    if @message.recipient == current_user
      if @message.deleted_by_sender
        destroy
      else
        @message.deleted_by_recipient = true
        @message.save
        
        redirect_to inbox_messages_path
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
