# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  birthday     :date
#  gender       :integer
#  introduction :text
#  nickname     :string
#  subscribed   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
    # enum => 「Enum」は「列挙型」のこと ActiveRecord :: Enumと言うモジュールのこと
    # この機能は、モデルの数値カラムに対して文字列による名前定義をマップすることができる
    enum gender: { male: 0, female: 1, other:2 }
    belongs_to :user
    has_one_attached :avatar

    # 年齢計算
    def age
        return '不明' unless birthday.present?
        years = Time.zone.now.year - birthday.year
        # yday => 一年の始まりからどれくらい日付が経過したのか
        days = Time.zone.now.yday - birthday.yday

        if days < 0
          "#{years - 1}歳"
        else
          "#{years}歳"
        end
    end
end
