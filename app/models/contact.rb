class Contact < Person
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  belongs_to :client    , :foreign_key => "external_id"

  # Setor e Função do contato
  belongs_to :department, :foreign_key => "department_id", :class_name => "DeptContact"
  belongs_to :function  , :foreign_key => "function_id"  , :class_name => "FuncContact"

  validates_format_of :email, :with => /(^$)|(^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$)/i
end