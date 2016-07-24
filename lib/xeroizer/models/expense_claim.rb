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
      datetime  :created_date_utc, :api_name => 'CreatedDateUTC'
      datetime  :updated_date_utc, :api_name => 'UpdatedDateUTC'
      
      belongs_to  :user
      has_many  :receipts
      
      def user_id
        user.id if user
      end
      
      def total 
         sum = (receipts || []).inject(BigDecimal.new('0')) { | sum, receipt | sum + receipt.total; puts "Total: #{Integer(sum)}" }
      end
    end
  end
end