class Session < ApplicationRecord
  belongs_to :user
  has_secure_token :token_digest
end
