class Message < ActiveRecord::Base
	# Informationen zur Handhabung mehrmaliger Assoziation mit der selben Tabelle aus:
	# http://www.spacevatican.org/2008/5/6/creating-multiple-associations-with-the-same-table/
	belongs_to :sender, :class_name => 'User'
	belongs_to :recipient, :class_name => 'User'
end
