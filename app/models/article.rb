# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# $ rails generate model Article を実行すると作成される

class Article < ApplicationRecord
    # 以下、追記
    validates :title, presence: true
    validates :content, presence: true

    # index.html.erb,show.html.erbで使用
    def display_created_at
        # selfにてarticleを取得
        I18n.l(self.created_at, format: :default)
    end
end
