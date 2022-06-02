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

    def new
        @article = Article.new
    end


    # https://qiita.com/Kawanji01/items/96fff507ed2f75403ecb
    # index.html.erb:<%= link_to article_path(id: article.id) do %>と同様の意味
    def create
        # render :newでは@articleは保存されないがarticle_paramsの情報を持ったインスタンス変数がnew.html.erbで使用される
        # privateメソッドのarticle_paramsにてnewの対象を限定
        @article = Article.new(article_params)
        if @article.save
            redirect_to article_path(@article), notice: '保存できたよ'
        else
            flash.now[:error] = '保存に失敗しました'
            render :new
        end
    end


    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        # privateメソッドのarticle_paramsにてupdateの対象を限定
        if @article.update(article_params)
            redirect_to article_path(@article), notice: '更新できました'
        else
            flash.now[:error] = '更新できませんでした' 
            render :edit
        end
    end



    # params:フォームなどによって送られてきた情報（パラメーター）を取得するメソッド
    # require:読み込む
    # permit:フィルタリングする
    # ストロングパラメータにはprivateをつけるルール
    # 命名:モデル名_params
    private
    def article_params
        #puts '------------------'
        #puts params
        #puts '------------------'
        params.require(:article).permit(:title, :content)
    end


    #def about
    #end
end