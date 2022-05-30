#ファイル名：articles_controller.rb と class名：ArticlesController は同じにするルール
#コントローラーの名称は複数形がある名詞は複数形にするのがルール ∴複数形がない名詞は避けるべき
class ArticlesController < ApplicationController
    def index
        #render 'home/index'
        #@title = 'デイトラ'
        @articles = Article.all
    end


    def show
        @article = Article.find(params[:id])
    end

    #def about
    #end
end