module Xeroizer
  module Record
    
    class ExpenseClaimModel < BaseModel
      set_xml_root_name 'ExpenseClaims'
      
      set_permissions :read, :write
    
    end

    class ExpenseClaim < Base
      set_primary_key :expense_claim_id

      guid      :expense_claim_id
      string    :status      
      datetime  :updated_date_utc, :api_name => 'UpdatedDateUTC'
      
      belongs_to  :user
      has_many  :receipt

      def receipt_id
        receipt.id if receipt
      end
      
      def user_id
        user.id if user
      end
    end
  end
end