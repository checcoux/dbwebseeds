class Tag < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true

  def self.search(search, type)
    result = Tag.all
    if search
      words = search.strip.split
      # find(:all)
      # find(:all, :conditions => [(['nome LIKE ?'] * search_length).join(' AND ')] + search.strip.split.map { |word| "%#{word}%" })
      # Tag.where( (['nome LIKE ?'] * words.length).join(' AND '), words.map { |word| "%#{word}%" } ).select(:taggable_id,:taggable_type).distinct.order(id: :desc)

      # words.map! { |word| "nome LIKE '%#{word}%'" }
      # sql = words.join(' AND ')
      # Tag.where(sql).select(:taggable_id,:taggable_type).distinct.order(taggable_id: :desc)

      words.each do |word|
        result = result.where("nome LIKE ?", "%#{word}%")
      end
    end
    if type=='a'
      result = result.where("taggable_type = 'Page'")
    elsif type=='m'
      result = result.where("taggable_type = 'Attachment'")
    elsif type=='f'
      result = result.where("taggable_type = 'Photoalbum'")
    end
    result.select(:taggable_id, :taggable_type).distinct.order(created_at: :desc)
  end

  self.per_page = 30
end
