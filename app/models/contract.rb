class Contract < ActiveRecord::Base
  validates_presence_of :text

# Select c1.id
#      , Concat(IfNull(Cast(c4.`order` As Char),'')
#             , IfNull(Cast(c3.`order` As Char),'')
#             , IfNull(Cast(c2.`order` As Char),'')
#             , IfNull(Cast(c1.`order` As Char),'')) As ordenator
#      , SubString(c1.text, 1, 200) as text
# From contracts c1
# Left Join contracts c2 On c2.id = c1.father_id
# Left Join contracts c3 On c3.id = c2.father_id
# Left Join contracts c4 On c4.id = c3.father_id
# Order by ordenator;

  named_scope :grid, :select => "c1.id, Concat('.',IfNull(Cast(c4.`order` As Char),''), IfNull(Cast(c3.`order` As Char),''), IfNull(Cast(c2.`order` As Char),''), IfNull(Cast(c1.`order` As Char),'')) As ordenator, SubString(c1.text, 1, 300) as text ",
                     :joins  => "c1 Left Join contracts c2 On c2.id = c1.father_id Left Join contracts c3 On c3.id = c2.father_id Left Join contracts c4 On c4.id = c3.father_id",
                     :order  => "ordenator"
end
