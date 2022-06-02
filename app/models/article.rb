# $ rails generate model Article を実行すると作成される

class Article < ApplicationRecord
    # 以下、追記
    validates :title, presence: true
    validates :content, presence: true
end
