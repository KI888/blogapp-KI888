class ProfilesController < ApplicationController
  # deviseにより定義されている
  # ユーザー認証機能 ログインしていないと操作不可
  before_action :authenticate_user!


  def show
    # current_userはdeviseにより定義されている
    # user.rbのhas_one にてprifileを指定しているのでここでprofileを使用可能
    @profile = current_user.profile
  end

  def edit
    # if current_user.profile.present?
    #   @profile = current_user.profile
    # else
    #   # has_oneの場合は単数形なのでbuild_モデル名(単数形)にて記述
    #   # 空のインスタンス変数作成
    #   @profile = current_user.build_profile
    # end
    # ↓
    # @profile = current_user.profile || current_user.build_profile
    # ↓
    # prepare_profile => user.rbにて定義
    @profile = current_user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィール更新!'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  private
  def profile_params
    params.require(:profile).permit(
      :nickname,
      :introduction,
      :gender,
      :birthday,
      :subscribed,
      :avatar
    )
  end
end