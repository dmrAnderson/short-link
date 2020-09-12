module LinksHelper
  def useless_link?(link)
    link.updated_at < 2.months.ago
  end
end
