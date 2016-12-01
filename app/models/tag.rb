class Tag < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true

  def self.search(search)
    if search
      words = search.strip.split
      # find(:all)
      # find(:all, :conditions => [(['nome LIKE ?'] * search_length).join(' AND ')] + search.strip.split.map { |word| "%#{word}%" })
      Tag.where( (['nome LIKE ?'] * words.length).join(' AND '), words.map { |word| "%#{word}%" } ).select(:taggable_id,:taggable_type).distinct.order(id: :desc)
    else
      Tag.all.select(:taggable_id,:taggable_type).distinct.order(id: :desc)
    end
  end

  self.per_page = 30
end
