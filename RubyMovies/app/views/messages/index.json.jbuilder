json.array!(@messages) do |message|
  json.extract! message, :sender_id, :recipient_id, :subject, :text, :read, :deleted_by_sender, :deleted_by_recipient
  json.url message_url(message, format: :json)
end
