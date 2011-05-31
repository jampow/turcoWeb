class Contact < Person
  belongs_to :client, :foreign_key => "external_id"
end

