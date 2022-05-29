class HomeController < ApplicationController
    def index
        #render 'home/index'
        #@title = 'デイトラ'
        @article = Article.first
    end

    def about
    end
end