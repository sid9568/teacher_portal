class Student < ApplicationRecord
  belongs_to :user, optional: true
end
