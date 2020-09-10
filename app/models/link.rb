class Link < ApplicationRecord
  validates :full_name,
            presence: true,
            length: { maximum: 250 },
            format: URI::regexp(%w[http https])

  validates :short_name,
            presence: true,
            uniqueness: true,
            length: { is: 5 }

  validates :password,
            presence: true,
            length: { is: 4 }

  def generete_short_name
    new_short_name = SecureRandom.alphanumeric(5)
    if Link.find_by_short_name(new_short_name)
      generete_short_name
    else
      self.short_name = new_short_name
    end
  end

  def generete_password
    self.password = SecureRandom.hex(2)
  end
end
