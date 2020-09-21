class FaveShow < ApplicationRecord
    belongs_to :user
    belongs_to :show
    validates :user, uniqueness: {scope: :show}
    

    
end