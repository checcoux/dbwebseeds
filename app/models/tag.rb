class Tag < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true

  def self.search(search)
    if search
      words = search.strip.split
      # find(:all)
      # find(:all, :conditions => [(['nome LIKE ?'] * search_length).join(' AND ')] + search.strip.split.map { |word| "%#{word}%" })
      # Tag.where( (['nome LIKE ?'] * words.length).join(' AND '), words.map { |word| "%#{word}%" } ).select(:taggable_id,:taggable_type).distinct.order(id: :desc)

      # words.map! { |word| "nome LIKE '%#{word}%'" }
      # sql = words.join(' AND ')
      # Tag.where(sql).select(:taggable_id,:taggable_type).distinct.order(taggable_id: :desc)
      result = Tag.all
      words.each do |word|
        result = result.where("nome LIKE ?", "%#{word}%")
      end
      result.select(:taggable_id, :taggable_type).distinct.order(taggable_id: :desc)
    else
      Tag.all.select(:taggable_id, :taggable_type).distinct.order(taggable_id: :desc)
    end
  end

  self.per_page = 30
end
