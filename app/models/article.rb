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
    validates :title, length: { minimum: 2, maximum: 100 }
    validates :title, format: { with: /\A(?!\@)/ }

    validates :content, presence: true
    validates :content, length: {minimum: 10}
    validates :content, uniqueness: true

    # 独自のvalidate作成（複数のカラムを参照してルールを決めるようなメソッドはrailsに用意されてないから自ら作成）
    # 独自のvalidate:複数形validatesではなく単数形validateを使用することに注意
    validate :validate_title_and_content_length

    # index.html.erb,show.html.erbで使用
    def display_created_at
        # selfにてarticleを取得
        I18n.l(self.created_at, format: :default)
    end

    private
    def validate_title_and_content_length
        char_count = self.title.length + self.content.length
        unless char_count > 100
            errors.add(:content, '100文字以上で!')
        end
    end

end
