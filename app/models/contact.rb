class Contact < Person
  belongs_to :client    , :foreign_key => "external_id"
  belongs_to :department, :foreign_key => "department_id", :class_name => "DeptContact"
end
