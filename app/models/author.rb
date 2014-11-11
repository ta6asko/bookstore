class Author < ActiveRecord::Base
  
  has_and_belongs_to_many :books

  rails_admin do
    
    edit do
      field :first_name
      field :last_name
      field :description
      field :books
    end

    show do
      field :first_name
      field :last_name
      field :description
      field :books
    end
  end

  

end
