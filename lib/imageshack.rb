require "tempfile_extension"

module ImageShack
  
  def upload_image_to_imageshack(*fields)
    include InstanceMethods
    
    cattr_accessor :imageshack_fields
    self.imageshack_fields = fields

    self.before_validation :check_if_an_imageshack_field_has_changed
  end

  module InstanceMethods
    
    def check_if_an_imageshack_field_has_changed
      raise "You haven't added your key to ImageShack. Do this in config/initializers/imageshack_config.rb." if IMAGESHACK_KEY == "CHANGE ME"
      
      imageshack_fields.each do |field|
        if imageshack_field_changed?(field) && can_upload_to_imageshack?(field)
          self[field] = self[field].upload_to_imageshack(IMAGESHACK_KEY)
        end
      end
    end
    
    private
      def imageshack_field_changed?(field)
        send "#{field}_changed?"
      end
    
      def can_upload_to_imageshack?(field)
        self[field].respond_to? :upload_to_imageshack
      end
      
  end
  
end

ActiveRecord::Base.extend ImageShack