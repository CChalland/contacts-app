class Contact < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :user

  def friendly_created_at
    created_at.strftime("%B %e, %Y")
  end

  def friendly_update_at
    updated_at.strftime("%B %e, %Y")
  end

  def full_name
    return "#{last_name}, #{first_name}"
  end

  def prefix_adder
    phone_with_prefix = "+81 #{phone_number}"
  end

  def as_json
    {
      user_id: user_id,
      id: id,
      first_name: first_name,
      middle_name: middle_name,
      last_name: last_name,
      full_name: full_name,
      email: email,
      phone_number: phone_number,
      bio: bio,
      created_at: friendly_created_at,
      updated_at: friendly_update_at
    }
  end
end
