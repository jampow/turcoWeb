# ExtendAcl9

module ActionController
  class Base

    class << self
      LEVELS = {:e => [:index, :show, :new, :edit, :create, :update, :destroy], :l => [:index, :show], :s => [] }
      # Class methods here

      def controller_name
        self.name.gsub(/Controller/, '').downcase
      end

      def autom_permissions
      #  access_control do
      #    LEVELS.each do |level, permissions|
      #      access_name = (self.name.gsub(/Controller/, '').downcase+"_"+level.to_s).to_sym
      #      allow access_name, :to => permissions
      #    end
      #  end
      end #def autom_permissions
    end #class << self
  # Instance methods here
  end
end

