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
