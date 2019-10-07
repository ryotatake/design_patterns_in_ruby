# https://ruby-rails.hatenadiary.com/entry/20150415/1429031791

# app/decorators/article_decorator.rb
class ArticleDecorator < Draper::Decorator
  delegate_all # こうするとArticleモデルの全てのメソッドを呼ぶことができる。

  def formatted_title
    title.center(20)
  end
end

# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  def index
    # @articles = Articles.all の代わりに
    @articles = ArticleDecorator.decorate_collection(Article.all)
  end
end

# app/views/article/index.html.haml
- @articles.each do |article|
  = article.formatted_title
