#ファイル名：articles_controller.rb と class名：ArticlesController は同じにするルール
#コントローラーの名称は複数形がある名詞は複数形にするのがルール ∴複数形がない名詞は避けるべき
class ArticlesController < ApplicationController
    before_action :set_article, only: [:show]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        #render 'home/index'
        #@title = 'デイトラ'
        @articles = Article.all
    end

    def show
        #@article = Article.find(params[:id])
        # @article => このページの一番下のset_articleの@articleを使用
        @comments = @article.comments
    end

    def new
        # @article = Article.new
        # buildはnewと違いはないが、モデルの関連付けの際はbuildを使用する
        @article = current_user.articles.build
    end

    # https://qiita.com/Kawanji01/items/96fff507ed2f75403ecb
    # index.html.erb:<%= link_to article_path(id: article.id) do %>と同様の意味
    def create
        # render :newでは@articleは保存されないがarticle_paramsの情報を持ったインスタンス変数がnew.html.erbで使用される
        # privateメソッドのarticle_paramsにてnewの対象を限定
        # @article = Article.new(article_params)
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to article_path(@article), notice: '保存できたよ'
        else
            flash.now[:error] = '保存に失敗しました'
            render :new
        end
    end

    def edit
       # @article = Article.find(params[:id])
       @article = current_user.articles.find(params[:id])
    end

    def update
        #@article = Article.find(params[:id])
        # privateメソッドのarticle_paramsにてupdateの対象を限定
        @article = current_user.articles.find(params[:id])
        if @article.update(article_params)
            redirect_to article_path(@article), notice: '更新できました'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    def destroy
        # インスタンス変数はviewsで使用するためにrailsでは使われる 今回はviewsには繋がないのでインスタンス変数不要
        # article = Article.find(params[:id])
        article = current_user.articles.find(params[:id])

        # !をつけなくても良いが、つけることにより削除されなかった場合に例外が発生する
        # !:ActiveRecord::RecordNotDestroyed例外を発生させる
        # !:appの実装が誤っていることによりここで処理が中断されるよう例外が発生する
        article.destroy!
        redirect_to root_path, notice: '削除に成功しました'
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
        params.require(:article).permit(:title, :content, :eyecatch)
    end

    def set_article
        @article = Article.find(params[:id])
    end

    #def about
    #end
end
