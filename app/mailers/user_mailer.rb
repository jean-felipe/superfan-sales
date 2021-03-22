class UserMailer < ApplicationMailer
  default from: 'notifications@super-fan.com.br'

  def welcome
    @user = params[:user]
    mail(to: @user.email, subject: 'Bem Vindo ao Super Fã - Sales')
  end

  def new_user
   @user = params[:user]
    mail(to: 'mandakeru.corporation@gmail.com', subject: 'Novo usuario cadastrado ')
  end
end
