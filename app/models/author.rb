class Author < ActiveRecord::Base
  
  has_and_belongs_to_many :books

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :first_name, :last_name

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
