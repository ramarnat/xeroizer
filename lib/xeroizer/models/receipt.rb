module Xeroizer
  module Record
    
    class ReceiptModel < BaseModel
      set_permissions :read, :write
    
    end

    class Receipt < Base
      set_primary_key :receipt_id
      set_possible_primary_keys :receipt_id, :receipt_number

      RECEIPT_STATUS = {
        'AUTHORISED' =>       'Approved receipts awaiting payment',
        'DELETED' =>          'Draft receipts that are deleted',
        'DRAFT' =>            'Receipts saved as draft or entered via API',
        'PAID' =>             'Receipts approved and fully paid',
        'SUBMITTED' =>        'Receipts entered by an employee awaiting approval',
        'VOIDED' =>           'Receipts invoices that are voided'
      } unless defined?(RECEIPT_STATUS)
      RECEIPT_STATUSES = RECEIPT_STATUS.keys.sort

      
      guid      :receipt_id
      date      :date
      
      string    :status
      string    :line_amount_types
      decimal   :sub_total, :calculated => true
      decimal   :total_tax, :calculated => true
      decimal   :total, :calculated => true
      datetime  :updated_date_utc, :api_name => 'UpdatedDateUTC'

      belongs_to  :user
      belongs_to  :contact
      has_many    :line_items

      validates_presence_of :date, :unless => :new_record?
      validates_inclusion_of :status, :in => RECEIPT_STATUSES, :unless => :new_record?
      validates_inclusion_of :line_amount_types, :in => LINE_AMOUNT_TYPES, :unless => :new_record?
      validates_associated :contact

      
      def contact_id
        contact.id if contact
      end
      
      def account_id
        account.id if account
      end
      
      def account_code
        account.code if account
      end

      def user_id
        user.id if user
      end
    
    end    
  end
end