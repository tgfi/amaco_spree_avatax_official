module SpreeAvataxOfficial
  class Transaction < ActiveRecord::Base
    SALES_ORDER               = 'SalesOrder'.freeze
    SALES_INVOICE             = 'SalesInvoice'.freeze
    RETURN_INVOICE            = 'ReturnInvoice'.freeze
    DEFAULT_ADJUSTMENT_REASON = 'Other'.freeze

    AVAILABLE_TRANSACTION_TYPES = [
      SALES_INVOICE,
      RETURN_INVOICE
    ].freeze

    belongs_to :order, class_name: 'Spree::Order'

    # with_options presence: true do
      validates :code, uniqueness: true, presence: true
      validates :order, presence: true
      validates :transaction_type, presence: true
    # end

    validates :transaction_type, inclusion: { in: AVAILABLE_TRANSACTION_TYPES }

    scope :sales_invoices,  -> { with_kind(SALES_INVOICE) }
    scope :return_invoices, -> { with_kind(RETURN_INVOICE) }
    scope :with_kind,       ->(*s) { where(transaction_type: s) }
  end
end
