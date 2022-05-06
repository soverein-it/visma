# frozen_string_literal: true

module Visma
# The DiscountGroupCustomer class gathers a group of Customers
# in order to provide DiscountAgreementCustomer to the group.
class DiscountGroupCustomer < Visma::Base
  self.table_name += 'DiscountGroupCustomer'
  self.primary_key = 'DiscountGrpCustNo'
  enum InActiveYesNo: %i[active inactive]
  include Visma::Timestamp
  include Visma::CreatedScopes
  include Visma::ChangeBy
  include Visma::PolymorphicName
  default_scope { active }

  has_many :customers, foreign_key: :DiscountGrpCustNo

  has_many :campaign_price_list, foreign_key: :DiscountGrpCustNo
  has_many :discount_agreement_customer, foreign_key: :DiscountGrpCustNo
  alias discount_agreements discount_agreement_customer

  has_many :articles, through: :discount_agreement_customer

  has_many :customer_order, foreign_key: :DiscountGrpCustNo
  alias orders customer_order
  has_many :customer_order_copy, foreign_key: :DiscountGrpCustNo
  alias processed_orders customer_order_copy

  # Find price for ArticleNo
  def price_for(artno)
    discount_agreements.for(artno)
  end

  scope :all_with_discount_agreements, -> { active.joins(:discount_agreement_customer).distinct(:DiscountGrpCustNo) }
end
end
