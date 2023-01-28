class AdminMailer < ApplicationMailer
  default from: 'ryan@classlyst.com'
 
  def admin_email
    @user = params[:user]
    mail(to: 'ryan@classlyst.com', subject: 'New Admin Request')
  end
end
