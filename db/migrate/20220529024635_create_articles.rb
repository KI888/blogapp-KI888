# $ rails generate model Article を実行すると作成される
# このファイルはテーブルを作成するためのファイル
# カラム等を追加し、ターミナルにて $ rails db:migrate を実行することによりテーブル作成可能

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      #以下、カラムの追加
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
