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

  # show.html.hamlにて使用
  def has_written?(article)
    articles.exists?(id: article.id)
  end

  # aaa@gmail.comにおいて前半の@までをsplitにより取得 => ['aaa', 'gmail.com'] first=[0]
  # self.emailでこのメールアドレスを取得
  def display_name
    self.email.split('@').first
  end

end
