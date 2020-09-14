class Link < ApplicationRecord
  before_validation :generate_short_name_and_password, on: :create

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

  def to_param
    short_name
  end

  default_scope -> { order(created_at: :desc) }

  private

    def generate_short_name_and_password
      new_short_name = SecureRandom.alphanumeric(5)
      if Link.find_by(short_name: new_short_name)
        generete_short_name
      else
        self.short_name = new_short_name
        self.password = SecureRandom.hex(2)
      end
    end
end
