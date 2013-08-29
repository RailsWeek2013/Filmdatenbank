class Message < ActiveRecord::Base
	# Informationen zur Handhabung mehrmaliger Assoziation mit der selben Tabelle aus:
	# http://www.spacevatican.org/2008/5/6/creating-multiple-associations-with-the-same-table/
	belongs_to :sender, :class_name => 'User'
	belongs_to :recipient, :class_name => 'User'

	def delete user 
		if self.sender == user
			if self.deleted_by_recipient
				destroy
			else
				self.deleted_by_sender = true
				self.save
			end
			true
		end

		if self.recipient == user
			if self.deleted_by_sender
				destroy
			else
				self.deleted_by_recipient = true
				self.save
			end
			false
		end
	end

	def set_read
		self.read = true
		self.save
	end
end
