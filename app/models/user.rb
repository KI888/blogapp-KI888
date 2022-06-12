# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 以下はusersテーブルとarticlesテーブルを紐づける設定 (userは複数のarticlesを保持しているから複数形) ActiveRecordとして実行可能になる
  # dependent: :destroy →ユーザーが削除されたときにそのユーザーの記事も削除する設定
  # has_many(関連モデル名, scope=nil, オプション引数) テーブル名でないところに注意
  has_many :articles, dependent: :destroy

  # 一つしかないので複数形にしない
  # 1対1の関連を宣言 has_one(関連モデル名 [, scope ,オプション])
  has_one :profile, dependent: :destroy

  # 以下のように書くことによりコメントアウトのdef bitthday def genderと同じことを意味することが可能
  # allow_nill: true => ぼっち演算子と同様の意味 nillだった場合でもエラーが発生せずに使用可能となる
  delegate :birthday, :age, :gender, to: :profile, allow_nil: true

  # show.html.hamlにて使用
  def has_written?(article)
    articles.exists?(id: article.id)
  end

  # aaa@gmail.comにおいて前半の@までをsplitにより取得 => ['aaa', 'gmail.com'] first=[0]
  # self.emailでこのメールアドレスを取得
  def display_name
    # if profile && profile.nickname
    #   profile.nickname
    # else
    #   self.email.split('@').first
    # end
    # ↓
    # &. => ぼっち演算子 profileがnill出なかった場合のみnicknameを実行するという意味
    profile&.nickname || self.email.split('@').first
  end

  # def birthday
  #   profile&.birthday
  # end

  # def gender
  #   profile&.gender
  # end

  def prepare_profile
    profile || build_profile
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

end
