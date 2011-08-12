class Contact < Person
  belongs_to :client    , :foreign_key => "external_id"
  belongs_to :department, :foreign_key => "department_id", :class_name => "DeptContact"
  belongs_to :function  , :foreign_key => "function_id"  , :class_name => "FuncContact"

  validates_format_of :email, :with => /(^$)|(^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$)/i
end

