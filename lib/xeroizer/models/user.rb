module Xeroizer
  module Record
    
    class UserModel < BaseModel
      set_xml_root_name 'Users'
      set_permissions :read, :write
    
    end

    class User < Base

      guid      :user_id
      string    :first_name
      string    :last_name
      datetime  :updated_date_utc, :api_name => 'UpdatedDateUTC'
      boolean   :is_subscriber
      string    :organization_role      
    
    end
  end
end