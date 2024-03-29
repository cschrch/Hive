class Post < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable
  acts_as_commentable
  belongs_to :category
  belongs_to :user

  def previous
  	  Post.where(["id < ?", id]).last
  end

  def next
  	  Post.where(["id > ?", id]).first
  end

  def prevcat
    Post.where(["id < ? AND category_id = ?", id, category_id]).last
  end

  def nextcat
    Post.where(["id > ? AND category_id = ?", id, category_id]).first
  end

  has_attached_file :image,
    :styles => {
      :thumb => "222x256#",
      :medium => "1600x1600>" },
    :convert_options => {
      :thumb => "-gravity center -crop 500x500+0+0 -quality 80",
      :medium => '-quality 80' }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
