# ExtendAcl9

module ActionController
  class Base
    class << self
      LEVELS = {:e => [:index, :show, :new, :edit, :create, :update, :destroy], :l => [:index, :show], :s => [] }
      # Class methods here
      def autom_permissions
        controller = self.name.gsub(/Controller/, '')
        access_control do
          LEVELS.each do |level, permissions|
            access_name = (controller.downcase+"_"+level.to_s).to_sym
            allow access_name, :to => permissions
          end
        end
      end #def autom_permissions

    end #class << self
  # Instance methods here
  end
end

