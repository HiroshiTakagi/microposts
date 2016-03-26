class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      @search_keywords = SearchKeywords.new
    end
  end

  def search
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)

      @search_keywords =  SearchKeywords.new(params.require(:search_keywords))
      unless @search_keywords.keywords.strip == ''
        @keywords = @search_keywords.keywords.gsub(/　/, ' ').split
        @keywords.each_with_index do |keyword, i|
          if i == 0
            @microposts_found  = Micropost.where("content LIKE ?", "%#{keyword}%")
          else
            @microposts_found  = @microposts_found.where("content LIKE ?", "%#{keyword}%")
          end
        end 
      end
      render :action =>'home'
    end
  end
end
